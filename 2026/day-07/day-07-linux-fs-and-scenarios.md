## Day 07 – Linux File System Hierarchy & Scenario-Based Practice

Goal - To understand where things live in Linux and practice troubleshooting like a DevOps engineer.

## Part 1: Linux File System Hierarchy

Core Directories 

### /  (root directory) - Top-most directory in Linux.

  All other directories branch from here.

  Contains directories like '/bin', '/etc', '/home', '/root', '/usr', '/var', '/tmp'.

 Command -  ls -l / (root directory) - 
 
 Observation - Displays core system directories.
  
 Example: 1. /mnt - temporary mount point
  
  Use case - I would use this when mounting an external disk or manual filesystem.

   2. /run - Runtime Data

       stores runtime system data(PIDs, sockets)

       Data is cleared on reboot

 Use case - I would use this when checking active services or system state after boot.

### /home - /home directory is the "neighbourhood" where all the users live. It is primary location for personal files and settings  
      
  keep strictly separate from the core system files.
        
Command -  ls -l /home 

Observation - Shows user directories (e.g.,ubuntu).

 Use case- I would use this when logging in as the ubuntu user to store personal files, scripts, and projects.

### /root - The /root directory is the home directory for the Root user(administrator) in linux.

   It stores root user's personal files, configs, and scripts.

Command -  ls -l /root 

Observation - Permission denied for non-root users.

 Use case- I would access this when I have root privileges ( Using sudo or logging in as root)

### /etc - /etc is a system configuration directory in linux.

   It contains configuration files for the OS and installed services(users, networking, services, permissions)

  Command - ls -l /etc 
  
  Observation- It shows many configuration files and folders.

  Example: /etc/apt - configuration for the APT package manager

  Use case -I would use this when installing, updating or managing software using apt.

### /var/log - It stores system and application log files in linux.

   It keeps records of system events, errors and service activity. logs helps in troubleshooting and monitoring system behavior.
           
Command -  ls -l /var/log 

Observation - Shows a detailed list of files and directories inside /var/log

 Example: 1. syslog - general system activity logs 

 Use case - I would use this when troubleshooting system or service problems.

   2. nginx - Stores Ngnix Web Server logs.

  Use case  - I would use this when checking website access (access.log) or fixing server errors (error.log).

### /tmp - /tmp is a temporary storage directory in linux. 

  It is used by the system and applications for short-term files.

 Command - ls -l /tmp
 
 Observation - Shows temporary files and folders. 

 Example: 1. systemd-private - Temporary directories created by services.

 Use case  - I would use this when checking temporary runtime files or services.

### Additional Directories 

### /bin - /bin contains essential command binaries needed for basic system operation.

   Commands like ls, cp, mv, and cat are stored here.

  Command - ls -l /bin  
 
 Observation -  It shows /bin -> /usr/bin
         
  because /bin is a symbolic link to /usr/bin.
  
  Modern Linux systems merged essential binaries into /usr/bin to simplify the filesystem.
  
  So when you access /bin, you are actually using the programs stored in /usr/bin.

Use case - I would use this when running basic commands like ls, cp, or bash.
  
### /usr/bin -  It contains user-level command binaries and utilities. 

  It stores non-essential but commonly used programs like python, git, nano, etc.

Command - ls -l /usr/bin 

Observation - It shows Linux command files (binaries).

  /usr/bin contains most user-level commands.

Example -  1. chown – changes file owner and group

  Use case - I would use this when fixing ownership issues on files or directories.

   2. egrep – searches text using extended regular expressions

 Use case - I would use this when I need advanced pattern matching in logs or command output. 

 /opt - /opt is used for optional or third-party software installations.
 
   Large applications are usually stored in separate folders under /opt.
   
   It helps keep non-system packages isolated from core files.

Command - ls -l /opt 

   Observation - It shows total 0

   because there are no files or folders inside /opt yet.

 Use case  - I would use this when installing large third-party applications that don’t come from the default package manager.
   
### Hands-on task: 

# Find the largest log file in /var/log

Command - du -sh /var/log/* 2>/dev/null | sort -h | tail -5 

Output - Displays the largest log files in /var/log 

# Look at a config file in /etc

 Command - cat /etc/hostname

Output - Shows the hostname of the system 


# Check your home directory

Command - ls -la ~

Output - Shows all files (including hidden files) in the home directory with permissions, ownership, and timestamp.

### Part 2: Scenario-Based Practice

-Understanding How to Approach Scenarios.

Scenario 1: Service Not Starting

Scenario: A web application service called 'nginx' failed to start after a server reboot.
What commands would you run to diagnose the issue?
Write at least 4 commands in order.

Goal - Check whether the service is running, exits, and starts on boot.

Step 1: Check service status

 Command - systemctl status nginx

 Why: Shows whether the service is active, inactive, or failed.

Step 2: If service is not found, list services

Commnad- systemctl list-units --type=service | grep nginx

 Why: Confirms service is installed.

Step 3: Checks if service is enabled on boot

 Commnad- systemctl ls-enabled nginx

Why: Ensures the service starts automatically after reboot.

Step 4: Check service logs

 Command - journalctl -u nginx -n 50

Why: Helps identify errors or reasons for failure.

Observation:

Service status shows whether it is running or failed

Logs provide exact error messages

Enabled services start automatically on reboot 

Conclusion: Service failure after reboot is often due to being disabled of configuration errors.

Scenario 2: High CPU Usage

Scenario: Application server is slow and CPU usage is high.

Goal: Identify which process is consuming high CPU.

Step-by-Step Solution:

Step 1: Check live CPU usage

 Command: top

Why: Shows real-time CPU and memory usage.

Step 2: List processes sorted by CPU

 Command: ps aux --sort=-%cpu | head -10

Why: Identifies top CPU-consuming processes.

Observation:

High CPU processes are visible at the top

conclusion : Helps pinpoint the service or application causing performance issues.

Scenario 3: Finding Service Logs

Scenario : A developer asks where logs for a docker service are stored.

Goal: Locate and inspect logs for a systemd-managed service.

Step-by-Step Solution:

Step 1: Check service status

 Command: systemctl status docker

Why: Confirms service state and recent log entries.

Step 2: View recent logs

 Command: journalctl -u docker -n 50

Why: Displays last 50 log entries.

Step 3: Follow logs in real time

Command: journalctl -u docker -f

Why: Useful during debugging or restarts.

Observation:

systemd services store logs in journalctl.

Logs are crucial for debugging service issues.

Conclusion: journalctl is the primary tool for service-level debugging.

Scenario 4: File Permission Issue

Scenario: A script /home/user/backup.sh gives “Permission denied” when executed.

Goal: Fix file permissions so the script can run.

Step-by-Step Solution:

Step 1: Check current permissions

 Command : ls -l /home/user/backup.sh

Why: Verifies whether execute (x) permission exists.

Step 2: Add execute permission

 Command: chmod +x /home/user/backup.sh

Why: Allows the script to be executed.

Step 3: Verify permissions

Command: ls -l /home/user/backup.sh

Why: Confirms execute permission is added.

Step 4: Run the script

Command: ./backup.sh

Observation:

Scripts require execute permission (x).

Conclusion : chmod is used to fix permission-related execution issues.

### Key Takeaways

Linux follows a clear filesystem hierarchy.

Logs are critical for debugging.

Scenario-based trobleshooting mirrors real Devops work.

Commands + reasoning + Observation = Strong Devops skill.



 
 

  
  

  
 








   
    
 
        
                      
              





    


