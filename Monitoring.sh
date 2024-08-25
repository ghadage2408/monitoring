#!/bin/bash

# Function to display top 10 CPU/memory consuming applications
show_top_apps() {
    echo "Top 10 Applications by CPU Usage:"
    top -b -o +%CPU | head -n 17 | tail -n 10
}

# Function to display network monitoring details
show_network() {
    echo "Network Monitoring:"
    echo "Concurrent Connections: $(ss -s | grep 'TCP:' | awk '{print $2}')"
    echo "Packet Drops:"
    netstat -i | grep -vE '^Kernel|Iface|lo' | awk '{if ($4 > 0) print $1, $4}'
    echo "Data In/Out:"
    ifconfig eth0 | grep 'RX packets' -A 1
}

# Function to display disk usage
show_disk_usage() {
    echo "Disk Usage:"
    df -h | awk '{ if($5 >= 80) print $0; }'
}

# Function to display system load
show_system_load() {
    echo "System Load:"
    echo "Load Average: $(uptime | awk '{print $8,$9,$10}')"
    echo "CPU Usage Breakdown:"
    mpstat | awk '$3 ~ /[0-9.]+/ { print "User: "$4"% System: "$6"% Idle: "$13"%"}'
}

# Function to display memory usage
show_memory_usage() {
    echo "Memory Usage:"
    free -h | awk '/^Mem/ {print "Total: "$2, "Used: "$3, "Free: "$4}'
    echo "Swap Usage:"
    free -h | awk '/^Swap/ {print "Total: "$2, "Used: "$3, "Free: "$4}'
}

# Function to display process monitoring details
show_processes() {
    echo "Active Processes: $(ps -e | wc -l)"
    echo "Top 5 Processes by CPU/Memory Usage:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
}

# Function to monitor essential services
show_service_status() {
    echo "Service Status:"
    for service in sshd nginx iptables; do
        systemctl is-active $service
    done
}

# Custom dashboard based on command-line switches
while [[ $# -gt 0 ]]; do
    case $1 in
        -cpu)
            show_top_apps
            ;;
        -network)
            show_network
            ;;
        -disk)
            show_disk_usage
            ;;
        -load)
            show_system_load
            ;;
        -memory)
            show_memory_usage
            ;;
        -process)
            show_processes
            ;;
        -service)
            show_service_status
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
    shift
done
