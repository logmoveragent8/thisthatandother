// Google Apps Script - Realtor Lead Capture
// Sends Telegram alerts on new property inquiries

const BOT_TOKEN = '8785724372:AAFXA7yyLeVPmusHyOUbJH52V-uBim9WIKs';
const CHAT_ID = '7433176972';

function onFormSubmit(e) {
  const responses = e.response.getItemResponses();
  let message = '🏠 New Real Estate Lead!\n\n';
  
  for (let i = 0; i < responses.length; i++) {
    const item = responses[i].getItem();
    const answer = responses[i].getResponse();
    message += `${item.getTitle()}: ${answer}\n`;
  }
  
  message += `\n📅 Submitted: ${new Date().toLocaleString()}`;
  
  // Send to Telegram
  const url = `https://api.telegram.org/bot${BOT_TOKEN}/sendMessage`;
  const payload = {
    chat_id: CHAT_ID,
    text: message
  };
  
  const options = {
    method: 'post',
    contentType: 'application/json',
    payload: JSON.stringify(payload)
  };
  
  UrlFetchApp.fetch(url, options);
}

// Alternative: Auto-reply to lead
function sendAutoReply(e) {
  const responses = e.response.getItemResponses();
  let email = '';
  let name = '';
  
  // Find email and name fields
  for (let i = 0; i < responses.length; i++) {
    const item = responses[i].getItem();
    const answer = responses[i].getResponse();
    if (item.getTitle().toLowerCase().includes('email')) {
      email = answer;
    }
    if (item.getTitle().toLowerCase().includes('name')) {
      name = answer;
    }
  }
  
  if (!email) return;
  
  // Send auto-reply
  GmailApp.sendEmail(
    email,
    'Thanks for your interest!',
    `Hi ${name || 'there'},\n\nThank you for reaching out! I'm excited to help you find your perfect property.\n\nI'll be in touch within 24 hours with some great options.\n\nBest,\nShawn\nYour Realtor`
  );
}
