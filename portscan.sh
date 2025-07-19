#!/bin/bash

# Step 1: Mention the IP Range:
ip_range="192.168.0.100-110"
report_file="/$HOME/port_audit_report.txt"

#Step 2: Mention the timestamp
echo "============================= Port Scan Audit - $(date)=============================" >> $report_file

#Step 3: Run Port Audit to check how many ports are open
nmap $ip_range | awk '/Nmap scan report/ {print "Target:" ,$5}
		      /open/ {printf " - %s (%s)\n", $1, $3}' >> $report_file

echo "====================================================================================" >> $report_file

# Step 4: Sending the mail
recipient="daamanpatel4@gmail.com"
subject="Port Scan Report Audit - $(date '+%Y-%m-%d %H:%M:%S')"

echo -e "Hi Team, \n\nPlease find attached the latest internal port scan audit.\n\nSummary:\n -Hosts scanned: 192.168.0.100-110\n -Open ports found: See attachment.\n\nRegards,\nDaaman Patel" | s-nail -s "$subject" -a "$report_file" "$recipient"





