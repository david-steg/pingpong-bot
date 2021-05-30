# pingpong-bot
Check your server status and send a message with telegram

I'm a Shell Noob.<br>
All critic are Welcome !<br>
Feel Free to Commit some Optimization.

## Tutorial

### Step 1: 

Create a Telegram Bot<br>
follow these Instructions: https://core.telegram.org/bots

### Step 2: 

Save your New Bot Token in your notes. 
> It should looks somethings like: `17439342749:AAFjKMzw7Y409OeZWMB9tpAHGAfa3hPqUUo`

### Step 3:

Add the Telegram BOT to the group.

### Step 4:

get to `https://api.telegram.org/bot<YourBOTToken>/getUpdates`
  
Look for the "chat" object:<br>
`"chat":{"id":<YourChatID>,"title":"<YourChatTitel>","type":""}`
 
Save your Chat ID in your notes.
  
### Step 5:

Add the Token and the ChatID to the Shell Script.
