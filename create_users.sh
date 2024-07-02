#!/bin/bash

# Define log and password files
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.txt"

# Function to generate a random password
generate_password() {
  tr -dc A-Za-z0-9 </dev/urandom | head -c 12
}

# Ensure directories for logs and secure files exist
sudo mkdir -p /var/log
sudo mkdir -p /var/secure

# Ensure log and password files exist and have correct permissions
sudo touch "$LOG_FILE"
sudo chmod 600 "$LOG_FILE"
sudo touch "$PASSWORD_FILE"
sudo chmod 600 "$PASSWORD_FILE"

# Check if the input file exists
INPUT_FILE=$1
if [[ ! -f $INPUT_FILE ]]; then
  echo "Input file not found!" | sudo tee -a "$LOG_FILE"
  exit 1
fi

# Process each line in the input file
while IFS=';' read -r username groups; do
  # Trim whitespace
  username=$(echo "$username" | xargs)
  groups=$(echo "$groups" | xargs)

  # Check if the user already exists
  if id "$username" &>/dev/null; then
    echo "User $username already exists." | sudo tee -a "$LOG_FILE"
  else
    # Create the user and their personal group
    sudo useradd -m "$username" | sudo tee -a "$LOG_FILE"
    password=$(generate_password)
    echo "$username:$password" | sudo chpasswd

    # Store the password securely
    echo "$username:$password" | sudo tee -a "$PASSWORD_FILE"

    # Add the user to specified groups
    IFS=',' read -ra group_array <<< "$groups"
    for group in "${group_array[@]}"; do
      group=$(echo "$group" | xargs)
      if ! getent group "$group" > /dev/null; then
        sudo groupadd "$group" | sudo tee -a "$LOG_FILE"
      fi
      sudo usermod -aG "$group" "$username" | sudo tee -a "$LOG_FILE"
    done

    echo "User $username created and added to groups: $groups" | sudo tee -a "$LOG_FILE"
  fi
done < "$INPUT_FILE"
