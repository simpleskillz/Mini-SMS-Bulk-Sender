# 📱 Mini SMS Bulk Sender – Asterisk Script

**Mini SMS Sender** is a lightweight script designed for **Raspberry Pi** running **Asterisk** with **Huawei USB Modem GSM**.  
It allows you to send bulk SMS messages directly via Asterisk, setup content of Text SMS, log delivery results, and automatically email a summary report after sending.

---

## 🧰 Features

✅ Real-time progress bar for each SMS<br>
✅ Automatic error logging and retry-ready output<br>
✅ Email summary report<br>
✅ Simple configuration and execution<br>
✅ Works with multiple Huawei GSM dongles<br>
✅ Auto-clears logs after each session

---

## ⚙️ Requirements

- **Raspberry Pi 4** (or any Linux system)
- **Asterisk** with dongle module (`dongle sms` command must work)
- **Huawei USB GSM modem** (Modems List: https://github.com/bg111/asterisk-chan-dongle/wiki/Requirements-and-Limitations)
- **SIM Card** for sending sms (any provider)
- Execute permission for `.sh` files

---

## 🧩 File Structure

| File | Description |
|------|--------------|
| `smsbulk.sh` | Main script responsible for sending SMS messages |
| `smsinfo.txt` | SMS message content (up to 160 characters) |
| `smslist.txt` | List of phone numbers (one per line, full country code required) |
| `sms_log.txt` | Log of all SMS operations (auto-generated) |
| `sent_numbers.txt` | List of successfully sent SMS messages |
| `error_numbers.txt` | List of numbers where sending failed |

---

## 📦 Installation


# Copy main files to Raspberry Pi

-smsbulk.sh<br>
-smsinfo.txt<br>
-smslista.txt<br>

# Make the script executable
chmod +x smsbulk.sh

---
## ⚙️ Configuration

Edit these variables at the top of smsbulk.sh:

dongle="dongle1"             # Asterisk dongle name (dongle0, dongle1, etc.)<br>
message_delay=10             # Delay between messages (in seconds)<br>
smslist="smslist.txt"      # File with phone numbers<br>
smsinfo="smsinfo.txt"        # File with SMS message text<br>
email_recipient="youremail@example.com"   # Email for final report<br>


---
## 🚀 Usage

./smsbulk.sh


The script will:

a. Read all numbers from smslista.txt<br>
b. Send the message from smsinfo.txt to each number<br>
c. Display a real-time progress bar and send status (OK / Error)<br>
d. Save logs to sent_numbers.txt and error_numbers.txt<br>
e. Email a final delivery report<br>


---
## 🧾 Example Output


----------------------------------------
Mini SMS Sender - Asterisk Script
----------------------------------------

Sending to: +447265422558 [██████████]  OK ID:12 21:43:11<br>
Sending to: +447445445477 [██████████]  OK ID:13 21:43:24<br>
Sending to: +447698366422 [██████████]  Error


## Report from SMS Bulk Send

+447265422558 -> ID:12 2025.10.14 21:43:11<br>
+447445445477 -> ID:13 2025.10.14 21:43:24

SMS Sent: 2<br>
SMS Errors: 1


---
## 📂 Example Files

smslist.txt

+447265422558<br>
+447445445477<br>
+447698366422


---
## 📨 Email Report Example

After sending, you’ll receive an automatic report like this:

When sent: 2025.10.14 21:48:22

How many sent: 3<br>
How many failed: 0

## List of SMS numbers:

+447265422558 -> ID:12<br>
+447445445477 -> ID:13<br>
+447698366422 -> ID:14


<hr>

## Prohibited actions and content

🟡 Sending unsolicited messages: This is a primary reason for blockages and violates laws like the TCPA, which requires express written consent for promotional messages.<br> 
🟡 Lack of consent: You cannot send messages to people who have not explicitly agreed to receive them. <br>
🟡 Missing or unclear opt-out options: Every marketing message must include a way for recipients to easily opt out (e.g., "Reply STOP"). <br>
🟡 Inappropriate or illegal content: This includes anything fraudulent, harassing, abusive, discriminatory, or that violates laws related to things like violence, drugs, or gambling. <br>
🟡 Violating privacy: Sharing or selling contact information without consent is prohibited. <br>
🟡 High volume or frequency: Carriers can throttle or block senders who appear to be sending too many messages too quickly, often related to spam. 

## How to ensure compliance

🟡 Get consent: Always get explicit, informed consent before sending messages, such as through a "text-to-join" or website form. <br>
🟡 Include opt-out: Make it easy to unsubscribe with a clear call to action in every message. <br>
🟡 Comply with laws: Stay informed about and follow all applicable regulations, such as the TCPA in the United States or GDPR in Europe. <br>
🟡 Adhere to carrier limits: Be mindful of carrier-specific limitations on message volume per minute and per day. <br>
🟡 Avoid prohibited content: Do not send messages that are illegal, fraudulent, or otherwise harmful. Be careful with topics like firearms, alcohol, or tobacco, and watch out for "banned words" that can trigger spam filters. <br>
🟡 Maintain records: Keep records of consent and opt-out requests. 



---

License
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


---

