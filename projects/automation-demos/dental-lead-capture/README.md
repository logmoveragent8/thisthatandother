# Dental Lead Capture Workflow

## Overview
Automates new patient inquiries from website form → Google Sheets → Email + SMS alerts

## Components

### 1. Trigger: Google Forms (or website form)
- Name, Phone, Email, Preferred Date, Insurance Status, Notes

### 2. Action: Add to Google Sheets
- Sheet columns: Date, Name, Phone, Email, Insurance, Notes, Status

### 3. Action: Send Email
- To: patient email
- Subject: Welcome to [Practice Name]!
- Body: Confirmation + what to expect + phone number

### 4. Action: Telegram/SMS Alert
- To: Dentist
- Message: "🎉 New Patient: [Name] - [Phone] - Insurance: [Status]"

---

## Setup in n8n

### Nodes Required:
1. **Webhook** (trigger)
2. **Google Sheets** (append row)
3. **Gmail** (send email)
4. **Telegram** (send message)

### Example Flow

```
[Webhook] → [Google Sheets] → [Gmail] → [Telegram]
```

---

## Alternative: Make (Integromat) Version

- **Trigger:** Google Forms
- **Module:** Google Sheets (add row)
- **Module:** Gmail (send email)
- **Module:** Telegram (send message)

---

## Files Included

- `workflow.json` - n8n export
- `google-sheet-template.xlsx` - Lead tracking sheet
- `email-template.html` - Welcome email

---

## Extension Ideas (Upsells)

| Add-on | Price |
|--------|-------|
| SMS reminders (Twilio) | +$50/mo |
| Appointment booking calendar | +$150 setup |
| Automated review request | +$75 setup |
| Insurance verification | +$100 setup |

---

## Time to Build
- Basic version: 30 min
- With upsells: 1-2 hrs
