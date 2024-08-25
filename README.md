# Monitoring System Resources for a Proxy Server

A brief description of what this task does and who it's for

1. Top 10 Most Used Applications
Command: Use ps or top command with sorting options to display the top 10 processes by CPU and memory usage.
Example: ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 11

2. Network Monitoring
Command:
For concurrent connections: ss -s or netstat -an | grep ESTABLISHED | wc -l
For packet drops: netstat -i or ifconfig
For network traffic: ifconfig or sar -n DEV
Example: sar -n DEV 1 1 | grep eth0

3. Disk Usage
Command: Use df -h to display disk space usage.
Example: df -h | awk '$5 > 80 {print}' to highlight partitions using more than 80% of space.

4. System Load
Command: Use uptime for load averages and mpstat or top for CPU breakdown.
Example: uptime and mpstat -P ALL 1 1

5. Memory Usage
Command: Use free -h to display total, used, and free memory, and swap usage.
Example: free -h

6. Process Monitoring
Command: Use ps to display the number of active processes and top 5 processes by CPU and memory.
Example: ps aux | wc -l and ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

7. Service Monitoring
Command: Use systemctl or service commands to check the status of essential services.
Example: systemctl is-active sshd or service nginx status

8. Custom Dashboard
Implementation: Use command-line arguments in the script to trigger specific monitoring sections. 
Example: ./monitor.sh -cpu for CPU monitoring.
Example Implementation:
bash
while getopts ":cpu:memory:network" opt; do
  case $opt in
    cpu)
      # Call function for CPU monitoring
      ;;
    memory)
      # Call function for Memory monitoring
      ;;
    network)
      # Call function for Network monitoring
      ;;
  esac
done

