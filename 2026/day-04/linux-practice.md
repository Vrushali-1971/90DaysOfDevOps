## Day-04 -  Linux practice - Processes and Services.

Goal - To inspect running processes systemd services, logs, and understand a basic troubleshooting flow. 

## Process Commnads

ps 
observation - Displays the Processes running in the current termial session with basic details like PID, TTY, TIME, and CMD

ps aux 
Observation - Shows all running processes along with CPU usage, memory usage, and commnad name.

top
Observation - Shows live CPU and memory usage, 'sshd' and 'systemd' are commonly running background services.

pgrep ssh 
Observation - Displays the process, IDs of running SSH-related processes, helping confirm that the SSH service is running.

## Service Commands 
Choosen service : ssh

systemctl status ssh 
Observation - Shows whether the SSH service is active or inactive. Displays service status, main PID and recent logs. Confirms SSH is managed by systemd.

systemctl list - units --type = service
Observation - Displays the SSH service in the list of active systemd services, confirming that SSH  is currently running.

## Log commands

journalctl -u ssh
Observation - Displays all logs related to the SSH service, including service start events, authentication attempts, and connection activity.

journalctl -u ssh | tail -n 50 
Observation - Shows the most recent 50 log entries for the SSH service, helping to quickly analyze recent login attempts or errors.

## Troubleshooting flow - SSH Service Issue 

Scenario: Unable to connect via SSH 

Steps: 1. Check SSH service status using 'systemctl status ssh'
       2. Verify SSH process is running using 'ps aux | grep sshd'
       3. Check recent SSH logs using 'journalctl -u ssh | tail -n 50'
       4. Confirm SSH is listening on port 22 using 'ss -tuln | grep : 22'

  Observation - SSH Service was running and listening on port 22. Logs showed successful connections, including no service failure.     
