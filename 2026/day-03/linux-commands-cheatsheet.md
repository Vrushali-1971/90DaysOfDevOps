## Day 03 – Linux Commands Practice

goal: Build confidence in commonly used Linux commands.

This cheat sheet focuses on:

Process management
File system
Networking troubleshooting

## Process Management
  
 ps aux - Shows all running processes with CPU and memory usage.
 top    - Displays live CPU and memory usage of processes.
 htop   - Interactive process viewer for monitoring and killing processes.
 uptime - Shows system running time and load average.
 Kill <PID>  - Sends a signal(default SIGTERM) to stop a process using PID.
 pkill  - Stops processes using process name.
 nice   - Starts a process with defined CPU priority.
 renice - Changes priority of an already running process.
 atop   - Displays detailed information about process and system resource usage.

 ## File system and Disk

 ls -l  - Lists files with permissions and ownership details.
 ls -a  - Displays hidden files/ folders.
 df -h  - Displays disk space usage in human-readable format.
 du -sh <dir> - Shows size of a directory or file
 chmod  - Changes file or directory permissions.
 chown  - Changes file or directory ownership.
 stat   - Shows detailed information about a file.
 free -h - Displays free and used memory in human-readable format.

 ## Networking troubleshooting

 ping     - Checks if a system is reachable over the network.
 curl     - Tests connectivity and response from a service or API.
 ip addr  - Displays IP addresses and network interface details. 
 ip route - Shows routing table and default gateway.
 ss -tuln - Lists listening TCP/UDP ports and services.
 netstat -tuln - Displays network connections and listening ports.
  dig      -  Performs detailed DNS lookup.
 nslookup - Checks DNS resolution of a domain name.
 telnet <host>   - Tests connectivity to a specific port.
nc <host> <port> - Checks if a port is open and listening.
   hostname -I   - Displays the system's IP address.

