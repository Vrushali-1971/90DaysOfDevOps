## Day 14 – Networking Fundamentals & Hands-on Checks

### Goal:
To get comfortable with core networking concepts and commonly used networking troubleshooting commands.
- Map the OSI vs TCP/IP models in your own words
- Run essential connectivity commands
- Capture a mini network check for a target host/service

## Quick Concepts

### OSI Layers (L1-L7) vs TCP/IP Stack

**OSI model** has **7 layers**: Physical, Data Link, Network, Transport, Session, Presentation, Application.

and is mainly used for understanding how networking works conceptually.

**TCP/IP model** is simpler with **4 layers**: Link, Internet, Transport, Application.

**Mapping:**

| TCP/IP Layer | OSI Layers |
|---------------|-------------|
| Application | L7 Application, L6 Presentation, L5 Session |
| Transport | L4 Transport |
| Internet | L3 Network |
| Link | L2 Data Link + L1 Physical |

### Where Common Protocols Sit

- **IP** → Network layer (L3) / Internet layer in TCP/IP  
- **TCP / UDP** → Transport layer (L4)  
- **HTTP / HTTPS** → Application layer (L7)  
- **DNS** → Application layer (L7)

### One real example:

**Example:**
```bash
curl https://github.com
```
This command sends an HTTPS request to GitHub.

Flow through the layers:

**Application Layer (L7) :** HTTPS request sent by curl.

**Transport Layer (L4) :** TCP establishes a reliable connection.

**Network Layer (L3) :** IP routes packets to GitHub servers.

**Link Layer (L2-L1) :**  Data is transmitted through Ethernet or Wi-Fi.

## Hands-on Checklist:

**Identity**
`hostname -I`

**Observation:**

The command `hostname -I` displays the IP address assigned to the system's network interfaces.

**Reachability**
`ping github.com`

**Observation:** 

Ping to github.com transmitted 41 packets with 0% packet loss and average latency around 5.75 ms, confirming stable
network connectivity.

**Path**
`traceroute github.com`

**Observation:**

The traceroute command showed multiple hops to reach github.com. Some intermediate routers did not respond 
(* * *), which is normal in many networks.

**Ports**
`ss -tulpn`

**Observation:** 
Shows listening network ports and services on the system. Ports like 22 (SSH) and 53 (DNS resolver) are listening on localhost.

**Name resolution** 
`dig github.com`

**Observation:**

DNS lookup successfully resolved github.com to the IP address 140.82.116.4, confirming that domain name resolution is working.

**HTTP check**
`curl -I https://github.com`

**Observation:**

The server returned an HTTP 200 OK response, confirming that the GitHub web service is reachable and responding correctly.

**Connections snapshot**
`netstat -an | head`

**Observation:** 

Shows a snapshot of current network connections. The Output includes LISTEN and ESTABLISHED states, indicating active services and network connections.

## Mini Task: Port Probe & Interpret

**Listening Port Identified**

Port 22 (SSH) was found listening from the `ss -tulpn` output
`nc -zv localhost 22`
**Result:**

Connection to localhost port 22 succeeded, confirming the SSH service is reachable.

**Interpretation**

The port is reachable. If it were not reachable, the next checks would be `systemctl status`

`ssh` and firewall rules (`ufw status` or `iptables -L`).

### Reflection

1. Which command gives you the fastest signal when something is broken?

systemctl status <service> gives the fastest signal because it immediately shows whether the service is active, inactive, or failed along with recent logs.

2. What layer would you inspect next?

If DNS fails:

Check the Application layer (DNS) in OSI / Application layer in TCP/IP stack.

If HTTP 500 appears:

Check the Application layer (web server or application) because HTTP errors originate from the server application.

3. Two follow-up checks in a real incident

Check service status:

`systemctl status <service>`

Check logs for errors:

`journalctl -u <service>`

## What I Learned 
- Learned how networking models work, including the relationship between the **OSI model ( 7 layers)**
   and the **TCP/IP** stack (4 layers)**
- Practiced important networking troubleshooting commands such as `ping`, `traceroute`, `ss`, `dig`, `curl`, and `netstat`.
- Understood how to check **service reachability, DNS resolution, open ports, and HTTP responses** when diagnosing network issues. 


