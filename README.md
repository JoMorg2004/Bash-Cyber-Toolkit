# Bash Cyber Toolkit
A pack of simple tools using BASH scripting

# Description
This is a pack of simple cybersecurity tools commonly used in analysis, using BASH.

# Explaining What the Code Does

1. Ping Sweep
   
``` ping -c 1 -W 1 $subnet.$ip | grep "64 bytes" ```
- Sends one ping (-c 1) with a 1-second timeout (-W 1) to each host.

- Checks if "64 bytes" appears — a sign of response.

- Runs in the background for speed (&) and waits at the end.

2. Port Scanner

``` echo > /dev/tcp/$target/$port ```
- Opens a TCP connection (using Bash’s /dev/tcp) to each port.

- If there is no error, the port is open.

- Silent success mode, it only prints open ports

3. Reverse Shell Helper
- Generates a one line Bash reverse shell.

- Instructs the user to set up a netcat listener.

4. SSH Login Analyzer
  
``` grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' ```
- Filters failed attempts and extracts IP addresses.

5. Suspicious New Users

``` find /home -type d -ctime -7 ```
- Lists home directories created in the last 7 days.

6. Cron Modifications

``` find /etc/cron* -type f -mtime -2 ```
- Looks for cron job files that have been changed in the last 2 days.

  
