// Google Apps Script - Send Telegram message on Google Form submit
// Instructions: https://github.com/chriscn/google-apps-script-telegram

// 1. Open your Google Form
// 2. Go to Extensions > Apps Script
// 3. Paste this code
// 4. Save and run once to authorize
// 5. Go to Triggers > Add Trigger > On form submit
// 6. Replace YOUR_BOT_TOKEN and YOUR_CHAT_ID below

const BOT_TOKEN = 'YOUR_TELEGRAM_BOT_TOKEN';
const CHAT_ID = 'YOUR_CHAT_ID';

function onFormSubmit(e) {
  const responses = e.response.getItemResponses();
  let message = '🦷 New Dental Lead!\n\n';
  
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

// Helper function to get your chat ID
function getChatId() {
  const url = `https://api.telegram.org/bot${BOT_TOKEN}/getUpdates`;
  const response = UrlFetchApp.fetch(url);
  const data = JSON.parse(response.getContentText());
  Logger.log(JSON.stringify(data));
}
