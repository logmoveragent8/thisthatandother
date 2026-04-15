# Realtor Lead Capture - Setup Guide

## Quick Start (Google Forms + Apps Script)

### Step 1: Get Telegram Credentials
1. Telegram → @BotFather → /newbot → Copy token
2. Telegram → @userinfobot → Copy Chat ID

### Step 2: Create Google Form
Create a form with these fields:
- Name (short answer)
- Phone (short answer)  
- Email (email)
- Property Type (dropdown): Buy, Rent, Sell
- Budget (short answer)
- Notes (paragraph)

### Step 3: Add Apps Script
1. Open Google Form → Extensions → Apps Script
2. Paste code from `apps-script.js`
3. Replace `YOUR_TELEGRAM_BOT_TOKEN` and `YOUR_CHAT_ID`
4. Save → Run (authorize)
5. Triggers → Add Trigger → On form submit

### Step 4: Test
Submit a test entry → Get Telegram alert!

---

## Form Fields Recommended

| Field | Type | Required |
|-------|------|----------|
| Name | Short answer | ✓ |
| Phone | Short answer | ✓ |
| Email | Email | ✓ |
| Property Type | Dropdown | ✓ |
| Budget | Short answer | |
| Timeline | Dropdown | |
| Notes | Paragraph | |

---

## Demo Form Ideas

### Option A: Property Inquiry
"We have a property you're interested in"

### Option B: Home Valuation
"What's your home worth?"

### Option C: Open House Sign-In
"Register for open house"

---

## Files Included

```
realtor-lead-capture/
├── README.md          # This overview
├── workflow.json      # n8n version
├── apps-script.js    # Google Apps Script
└── SETUP.md         # Setup guide
```
