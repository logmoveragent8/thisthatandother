"""Query invoice data - run with: python query_invoices.py"""
import sqlite3
from pathlib import Path

DB_PATH = Path(r"C:\Users\logmover\Documents\Invoices\invoices.db")

conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

# Get all invoices with their data
cursor.execute("SELECT id, filename, vendor, amount, date, description FROM invoices")
rows = cursor.fetchall()

print(f"Total invoices: {len(rows)}\n")
for r in rows:
    print(f"ID: {r[0]} | File: {r[1]}")
    print(f"  Vendor: {r[2]}")
    print(f"  Amount: {r[3]}")
    print(f"  Date: {r[4]}")
    print(f"  Description: {r[5][:100] if r[5] else 'None'}...")
    print()

conn.close()
