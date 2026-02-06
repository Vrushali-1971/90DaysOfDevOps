## Day 02 – Linux Architecture, Processes, and systemd
- Today’s goal is to understand how Linux works under the hood.
Here I will create a short note that explains:
The core components of Linux (kernel, user space, init/systemd)
How processes are created and managed
What systemd does and why it matters

## Core Components of Linux

### Kernel
The kernel is the core of Linux that directly interacts with hardware and manages CPU, memory, processes, and devices.

### User Space
User space is the area where users and applications run and interact with the operating system.

### init / systemd
init/systemd is the first process started at boot (PID 1).  
It initializes the system and manages services.

## Processes

### What is a Process
A process is a running instance of a program, identified by a Process ID (PID).

### Process Creation and Management
Processes are created using `fork()` and `exec()` and are managed by the kernel using scheduling, priorities, and signals.

## systemd
systemd manages system startup and services by starting, stopping, and monitoring them efficiently.  
It matters because it enables faster boot time, better service control, and reliable system management.

## Process States

Process status shows the current state of a running program:
- **Running** – Process is executing on the CPU
- **Sleeping** – Waiting for input or a resource
- **Stopped** – Paused by a signal
- **Zombie** – Finished execution but not cleaned up by its parent
- 
## Daily Use Commands

- `ps aux` – Shows all running processes
- `top` – Displays live CPU and memory usage
- `systemctl` – Manages services (start, stop, status)
- `journalctl` – Views system and service logs
- `ls` – Lists files and directories

## Note
These commands help monitor processes, manage services, view logs, and navigate the system.  
They are daily tasks for a DevOps engineer.
