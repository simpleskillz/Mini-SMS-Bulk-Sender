#!/bin/bash
echo -e "\e[32m----------------------------------------"
echo ""
echo "Mini SMS Sender - Asterisk Script"
echo ""
echo Start: $(date '+%Y.%m.%d %H:%M:%S')
echo ""
echo -e "----------------------------------------\e[0m"
echo ""



dongle="dongle1"        # Dongle name 1,2,3,4 ...
message_delay=10         # Message delay in sec 
smslista="smslist.txt"  # SMS list file - per 1 line only 1 number with full country code 
smsinfo="smsinfo.txt"   # SMS text content file 160 ch.
log_file="sms_log.txt"   # Log file
sent_file="sent_numbers.txt"  # Sent sms number file
error_file="error_numbers.txt"  # Error sent sms number file
email_recipient="YOUR_EMAIL@YOUR_EMAIL"  # E-mail 
email_subject="Raport SMS Bulk"

send_sms() {
    local dongle=$1
    local number=$2
    local message=$3

    result=$(asterisk -rx "dongle sms $dongle +$number $message")

    if [[ $result == *"Error"* ]]; then
        echo -e "Error\n"
        echo "$(date '+%Y-%m-%d %H:%M:%S') --> +$number (Error)" >> "$error_file"
    else
        id=$(echo "$result" | grep -oP "(?<=id\s)\S+" | head -n 1)
        echo -e " OK $id $(date '+%H:%M:%S')\n" 
        echo "+$number -> ID:$id $(date '+%Y.%m.%d %H:%M:%S')" >> "$sent_file"
    fi
}

send_email() {
    local recipient=$1
    local subject=$2
    local body=$3

    echo -e "$body" | mail -s "$subject" "$recipient"
}

main() {
    if [ ! -f "$smsinfo" ]; then
        echo "No file smsinfo.txt with text content."
        exit 1
    fi

    if [ ! -f "$smslista" ]; then
        echo "No file  smslist.txt with numbers."
        exit 1
    fi

    sent_count=0
    error_count=0

    while IFS= read -r number || [ -n "$number" ]; do
        number=$(echo "$number" | tr -cd '0-9')  # Clean numbers

        if [ -z "$number" ]; then
            echo "Empty number. Skip"
            continue  # Skip
        fi

        echo -n "Sending to: +$number ["
        for remaining_time in $(seq "$message_delay" -1 1); do
            echo -n "██"
            sleep 1
        done

        echo -n "] "
        message=$(cat "$smsinfo")  # Read content each time
        send_sms "$dongle" "$number" "$message"

        if [[ $result == *"Error"* ]]; then
            ((error_count++))
        else
            ((sent_count++))
        fi

        sleep 1
    done < "$smslist"

    # Raport details
    echo -e "\e[32m----------------------------------------"
	echo -e "Raport from SMS Bulk send"
    echo ""
    cat "$sent_file" | column -t
    echo -e "\nSMS Send: $sent_count"
    echo -e "SMS Error: $error_count\n"

    
    if [ "$error_count" -gt 0 ]; then
        echo -e "List numbers with Errors:"
        echo ""
        cat "$error_file" | column -t
        echo -e "\nCount SMS with Errors: $error_count"
    fi
	echo ""
	echo -e "----------------------------------------\e[0m"
    # Send email with confirmation
    current_datetime=$(date '+%Y.%m.%d %H:%M:%S')
    email_report="When send: $current_datetime\nHow many send: $sent_count\nHow many not send: $error_count\n\nList of SMS numbers:\n\n$(cat "$sent_file" | column -t)\n\nList SMS errrors:\n\n$(cat "$error_file" | column -t)"
    sleep 2
    send_email "$email_recipient" "Raport SMS" "$email_report"

    # Clean logs
    > "$sent_file"
    > "$error_file"
}

main
