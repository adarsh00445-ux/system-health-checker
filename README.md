# System Health Checker

An interactive and automated Bash monitoring suite designed to audit Linux server runtime metrics, display menu-driven health checks, and dispatch system logs.

## Features
- **Interactive TUI Menu:** Provides options to explicitly check Disk space, active system services, Memory allocation, and live CPU analytics.
- **Automated Cron Scheduling:** Supports a standalone `--cron` switch to generate execution reports non-interactively.
- **Reporting & Notifications:** Generates complete audit outputs and routes status logs securely through transactional configurations.

## System Prerequisites
Ensure your local server environment has functional core utilities installed:
```bash
sudo apt update && sudo apt install mailutils -y
```

## Setup & Execution

1. **Run the Interactive Dashboard:**
   ```bash
   ./sys_health.sh
   ```

2. **Automate via Cron Job:**
   To schedule an automated report every morning at 08:00 AM, add the following line to your `crontab -e` configuration:
   ```text
   0 8 * * * /home/adarsh/system-health-checker/sys_health.sh --cron
   ```
