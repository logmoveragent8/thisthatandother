"""
Invoice Extractor - Local PDF to SQLite (v3 - improved timeout & parsing)
"""

import os
import sqlite3
import pdfplumber
import re
from datetime import datetime
from pathlib import Path
import json
import subprocess

# Configuration
INVOICE_FOLDER = Path(r"C:\Users\ShawnJing\American Associatio Dropbox\Shawn Jing\sjing\Documents\Invoices_AT\AUG24")
DB_PATH = Path(r"C:\Users\ShawnJing\American Associatio Dropbox\Shawn Jing\sjing\Documents\Invoices_AT\AUG24\invoices.db")
MODEL = "llama3.2:3b"

def init_db():
    """Initialize SQLite database"""
    DB_PATH.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS invoices (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            filename TEXT NOT NULL,
            vendor TEXT,
            amount REAL,
            date TEXT,
            description TEXT,
            service_code TEXT,
            teams TEXT,
            raw_text TEXT,
            created_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    return conn

def clean_text(text):
    """Clean up extracted text"""
    text = re.sub(r'\s+', ' ', text)
    return text.strip()

def extract_with_llm(text):
    """Extract structured data using local LLM"""
    # For very long texts, skip LLM and use regex
    if len(text) > 5000:
        print("    Text too long - using regex fallback")
        return extract_with_regex(text)
    
    prompt = f"""Extract: vendor, amount, date, description. JSON only.

Invoice:
{text[:2500]}

JSON:"""

    try:
        result = subprocess.run(
            ["ollama", "run", MODEL, prompt],
            capture_output=True, text=True, timeout=120, encoding="utf-8", errors="replace"
        )
        
        output = result.stdout.strip()
        
        # Try to find and parse JSON - be very aggressive
        import re
        match = re.search(r'\{.*\}', output, re.DOTALL)
        if match:
            json_str = match.group(0)
            for i in range(3):
                try:
                    data = json.loads(json_str)
                    
                    # Clean amount
                    if data.get("amount"):
                        if isinstance(data["amount"], str):
                            data["amount"] = data["amount"].replace("$", "").replace(",", "").strip()
                        try:
                            data["amount"] = float(data["amount"])
                        except:
                            data["amount"] = None
                    
                    # Clean vendor
                    if data.get("vendor"):
                        data["vendor"] = str(data["vendor"]).strip()
                        data["vendor"] = re.sub(r'^(From:|Bill From:|Vendor:)\s*', '', data["vendor"], flags=re.I)
                    
                    return data
                except json.JSONDecodeError:
                    json_str = json_str[:-1]
                    continue
    except subprocess.TimeoutExpired:
        print("    TIMEOUT - using regex fallback")
    except (json.JSONDecodeError, ValueError) as e:
        print(f"    LLM parse error: {e}")
    
    # Fallback to regex
    return extract_with_regex(text)

def extract_with_regex(text):
    """Fallback: extract using regex patterns"""
    data = {"vendor": None, "amount": None, "date": None, "description": None}
    lines = [l.strip() for l in text.strip().split('\n') if l.strip()]
    
    # Amount: find the largest $X,XXX.XX pattern
    amounts = re.findall(r'\$?([\d,]+\.\d{2})', text)
    if amounts:
        try:
            data["amount"] = max([float(a.replace(",", "")) for a in amounts])
        except:
            pass
    
    # Date: find common date patterns
    dates = re.findall(r'(\d{2}[/-]\d{2}[/-]\d{4})', text)
    if dates:
        data["date"] = dates[0]
    
    # Vendor: look for company name - usually first line with "Inc", "LLC", "Corp", etc
    # Or the first line after account codes (lines with just numbers)
    vendor_patterns = ['inc', 'llc', 'corp', 'company', 'co.', 'technologies', 'services', 'solutions']
    for i, line in enumerate(lines[:15]):
        line_lower = line.lower()
        # Skip lines that are just numbers (account codes)
        if line.replace(' ', '').replace('-', '').isdigit():
            continue
        # Skip common invoice headers
        if any(x in line_lower for x in ['bill to', 'invoice', 'date', 'terms', 'due', 'account', 'po number', 'amount', 'total', 'subtotal', 'payment', 'remittance']):
            continue
        # Look for company-like lines
        if any(x in line_lower for x in vendor_patterns) or (i > 2 and i < 10 and len(line) > 5):
            data["vendor"] = line
            break
    
    # Description: look for first substantive line
    for line in lines[5:25]:
        if len(line) > 15 and "$" not in line and not line.replace(' ', '').replace('-', '').isdigit():
            data["description"] = line[:200]
            break
    
    return data

def extract_invoice_info(pdf_path):
    """Extract structured data from PDF"""
    with pdfplumber.open(pdf_path) as pdf:
        text = ""
        for page in pdf.pages:
            text += page.extract_text() or ""
    
    text = clean_text(text)
    data = extract_with_llm(text)
    return data, text

def process_folder():
    """Process all PDFs in the invoice folder"""
    conn = init_db()
    cursor = conn.cursor()
    
    if not INVOICE_FOLDER.exists():
        print(f"Folder not found: {INVOICE_FOLDER}")
        return
    
    processed = 0
    skipped = 0
    
    for pdf_file in INVOICE_FOLDER.glob("*.pdf"):
        # Check if already processed
        cursor.execute("SELECT id FROM invoices WHERE filename = ?", (pdf_file.name,))
        if cursor.fetchone():
            print(f"Skipping (exists): {pdf_file.name}")
            continue
        
        print(f"Processing: {pdf_file.name}")
        try:
            data, raw_text = extract_invoice_info(pdf_file)
            
            cursor.execute("""
                INSERT INTO invoices (filename, vendor, amount, date, description, raw_text)
                VALUES (?, ?, ?, ?, ?, ?)
            """, (pdf_file.name, data.get("vendor"), data.get("amount"), 
                  data.get("date"), data.get("description"), raw_text[:5000]))
            conn.commit()
            processed += 1
            print(f"  ✓ {data.get('vendor', 'Unknown')} - ${data.get('amount', 0)}")
        except Exception as e:
            skipped += 1
            print(f"  ✗ Error: {e}")
    
    conn.close()
    print(f"\nDone! Processed {processed} invoices, {skipped} skipped.")

def query_invoices(question):
    """Query invoices using local LLM"""
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT filename, vendor, amount, date, description FROM invoices")
    rows = cursor.fetchall()
    conn.close()
    
    if not rows:
        return "No invoices found."
    
    invoice_data = "\n".join([str(r) for r in rows])
    prompt = f"""Based on this invoice data, answer the question.
    
Invoices:
{invoice_data}

Question: {question}

Answer:"""

    result = subprocess.run(
        ["ollama", "run", MODEL, prompt],
        capture_output=True, text=True, timeout=180, encoding="utf-8", errors="replace"
    )
    return result.stdout.strip()

def run_sql(sql_query):
    """Run a direct SQL query"""
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    try:
        cursor.execute(sql_query)
        rows = cursor.fetchall()
        
        if cursor.description:
            columns = [desc[0] for desc in cursor.description]
            print(f"Columns: {columns}")
            print(f"Rows: {len(rows)}\n")
            
            for row in rows:
                print(row)
        else:
            conn.commit()
            print(f"Query executed. {cursor.rowcount} rows affected.")
            
    except Exception as e:
        print(f"SQL Error: {e}")
    
    conn.close()

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1 and sys.argv[1] == "--sql":
        if len(sys.argv) > 2:
            sql_query = " ".join(sys.argv[2:])
            run_sql(sql_query)
        else:
            print("Usage: python invoice_extractor.py --sql \"SELECT * FROM invoices\"")
    elif len(sys.argv) > 1:
        print("Querying... (this may take a while)")
        print(query_invoices(" ".join(sys.argv[1:])))
    else:
        process_folder()
