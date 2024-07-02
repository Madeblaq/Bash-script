# User Management Script

## Overview

This repository contains a Bash script, `create_users.sh`, designed to automate the process of creating users and groups on a Linux system. The script reads user information from a specified input file and performs the following actions:
- Creates users with home directories.
- Assigns users to specified groups.
- Generates random passwords for the users.
- Logs all actions to `/var/log/user_management.log`.
- Stores generated passwords securely in `/var/secure/user_passwords.txt`.

## Features

- **Automated User and Group Creation**: Easily manage user accounts and their group memberships.
- **Secure Password Handling**: Randomly generated passwords are stored securely.
- **Logging**: Actions are logged for audit and troubleshooting purposes.
- **Error Handling**: Handles common errors such as existing users or groups.

## Prerequisites

- Linux-based system (e.g., Ubuntu, Amazon Linux)
- Bash shell
- Mobaxterm for SSH operations
- `dos2unix` (for converting line endings if necessary)

## Getting Started

### 1. Clone the Repository
```sh

git clone https://github.com/your-username/your-repository.git
cd your-repository
```

### 2. Prepare the Input File 

Create an input file named `input_file.txt` with the following format:

```sh
username1; group1, group2, group3
username2; group1, group2
username3; group3
```

#### Example

```sh
chukwu; sudo, dev, www-data
tolani; sudo
hassan; dev, www-data
```

### 3. Upload Script and Input File to Mobaxterm

Upload the `create_users.sh` script and `input_file.txt` using the upload feature of MobaXterm:

- Open MobaXterm.
- Navigate to the directory where your repository is cloned.
- Use the upload feature to upload `create_users.sh` and `input_file.txt` to the current directory in MobaXterm.

### 4. Convert Line Endings and Make the Script Executable

Connect to your remote server using MobaXterm SSH session and navigate to the repository directory:

```sh
dos2unix create_users.sh
chmod +x create_users.sh
```

### 5. Run the Script

Execute the script with sudo on your remote server:

```sh
sudo ./create_users.sh input_file.txt
```

## Logs and Passwords

- **Logs File**: `/var/log/user_management.log`
- **Passwords File**: `/var/secure/user_passwords.txt`

## Learn More About HNG Internship

This project is part of the HNG Internship, a program designed to develop and mentor software developers. You can learn more about hiring from the HNG Internship [here](https://hng.tech) or explore the premium services [here](https://hng.tech/services).

## Contributing

Contributions are welcome! Please fork this repository and submit pull requests for any improvements or fixes.

## Contact

For any questions or suggestions, please open an issue or contact us at [madeblaq@gmail.com].

This project was created by Orisadare Damilola Racheal as part of the HNG Internship program.
```
