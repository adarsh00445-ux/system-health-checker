#!/bin/bash

LOG_FILE="/tmp/sys_health.log"
EMAIL="adarsh930971@gmail.com"

check_disk_usage() {
    echo "Checking disk usage..."
    df -h
    echo "[$(date)] Checked disk usage" >> "$LOG_FILE" 2>/dev/null
}

monitor_services() {
    echo "Monitoring running services..."
    systemctl list-units --type=service --state=running
    echo "[$(date)] Monitored running services" >> "$LOG_FILE" 2>/dev/null
}

check_memory_usage() {
    echo "Checking memory usage..."
    free -m
    echo "[$(date)] Checked memory usage" >> "$LOG_FILE" 2>/dev/null
}

check_cpu_usage() {
    echo "Checking CPU usage..."
    top -bn1 | grep "Cpu"
    echo "[$(date)] Checked CPU usage" >> "$LOG_FILE" 2>/dev/null
}

send_report() {
    REPORT="/tmp/sys_health_report.txt"
    echo "Generating system health report..."

    {
        echo "=== System Health Report ==="
        echo "Date: $(date)"
        echo -e "\nDisk Usage:"
        df -h
        echo -e "\nRunning Services:"
        systemctl list-units --type=service --state=running
        echo -e "\nMemory Usage:"
        free -m
        echo -e "\nCPU Usage:"
        top -bn1 | grep "Cpu"
    } | tee "$REPORT"

    if command -v mail &>/dev/null; then
        mail -s "System Health Report" "$EMAIL" < "$REPORT"
        echo "Report sent successfully!"
        echo "[$(date)] System health report sent to $EMAIL" >> "$LOG_FILE" 2>/dev/null
    else
        echo "Error: 'mail' command not found. Install mailutils." >&2
    fi
}

if [ "$1" == "--cron" ]; then
    send_report
    exit 0
fi

while true; do
    echo "========================================"
    echo "        System Health Check Menu        "
    echo "========================================"
    echo "1. Check Disk Usage"
    echo "2. Monitor Running Services"
    echo "3. Assess Memory Usage"
    echo "4. Evaluate CPU Usage"
    echo "5. Send Comprehensive Report"
    echo "6. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) check_disk_usage ;;
        2) monitor_services ;;
        3) check_memory_usage ;;
        4) check_cpu_usage ;;
        5) send_report ;;
        6) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac

    echo "Press Enter to continue..."
    read
done


