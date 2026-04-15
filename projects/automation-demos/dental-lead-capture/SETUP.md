# Dental Lead Capture - Live Setup Guide

## Option A: Google Forms + Email (No Code)

The simplest setup - use Google Forms native notifications:

1. **Create Google Form**
   - Go to forms.google.com
   - Create new form with fields:
     - Name (short answer)
     - Phone (short answer)
     - Email (short answer)
     - Preferred Date (date)
     - Insurance Status (dropdown: Yes/No)
     - Notes (paragraph)

2. **Set up notifications**
   - In Google Forms, click "Responses" tab
   - Click the 3 dots menu > "Get email notifications for new responses"
   - You'll get email alerts for every submission

3. **Connect to Telegram**
   - Use Google Forms → Gmail → Telegram (via Zapier/IFTTT)
   - OR just forward form emails to Telegram

---

## Option B: Google Forms + Apps Script (Free, More Control)

### Step 1: Get Telegram Bot Token
1. Open Telegram → @BotFather
2. Create new bot: `/newbot`
3. Copy the API token

### Step 2: Get Your Chat ID
1. Open Telegram → @userinfobot
2. Send any message
3. Copy your Chat ID

### Step 3: Create Google Form
- Fields: Name, Phone, Email, Preferred Date, Insurance, Notes

### Step 4: Add Apps Script
1. In your Google Form → Extensions → Apps Script
2. Paste the code from `apps-script.js`
3. Replace `YOUR_TELEGRAM_BOT_TOKEN` and `YOUR_CHAT_ID`
4. Save → Run once (authorize)
5. Triggers → Add Trigger → On form submit

### Step 5: Test
- Submit a test form entry
- Get Telegram alert!

---

## Option C: Use This Demo Form

Want me to create a live form and share the link? You could use it as a portfolio piece.

---

## Files in This Demo

```
dental-lead-capture/
├── README.md           # This file
├── workflow.json       # n8n version (for self-hosted)
├── apps-script.js     # Google Apps Script version
└── SETUP.md          # Detailed setup guide
