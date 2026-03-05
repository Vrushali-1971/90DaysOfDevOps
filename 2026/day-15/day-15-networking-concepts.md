# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

## Goal
Understand core networking concepts used in DevOps such as DNS resolution, IP addressing, subnetting, and ports.

---

# Task 1: DNS – How Names Become IPs

### What happens when you type google.com in a browser?

1. The browser asks the system DNS resolver for the IP address of google.com.
2. The DNS resolver queries DNS servers to find the IP address.
3. The DNS server returns the IP mapped to the domain.
4. The browser then sends an HTTP/HTTPS request to that IP address.

---

### DNS Record Types

| Record | Purpose |
|------|------|
| A | Maps a domain name to an IPv4 address |
| AAAA | Maps a domain name to an IPv6 address |
| CNAME | Alias of one domain name to another |
| MX | Specifies mail servers for the domain |
| NS | Defines the authoritative DNS servers for the domain |

---

### Command

```bash
dig google.com
```
### output snapshot:

```bash
google.com. 76 IN A 142.251.34.206
Query time: 0 msec
```
- A record: 142.251.34.206
- TTL: 76

### Observation:

The DNS query resolved google.com to an IPv4 address 142.251.34.206 with a TTL of 76 seconds.

TTL shows how long the DNS result can be cached before another lookup is required.

# Task 2: IP Addressing

### 1. What is an IPv4 Address? How is it structured? (e.g., 192.168.1.10)

An IPv4 address is a 32-bit numerical address used to identify devices on a network.

It is written in dotted decimal format such as 192.168.1.10.

### 2. Difference between public and private IPs — give one example of each

- Public vs Private IP

| Type | Description | Example |
|------|-------------|--------|
| Public IP | Accessible over the internet | 8.8.8.8 |
| Private IP | Used inside private networks | 192.168.1.10 |

## 3. What are the private IP ranges?

- Private IP Ranges

10.0.0.0 – 10.255.255.255

172.16.0.0 – 172.31.255.255

192.168.0.0 – 192.168.255.255

### Command

```bash
ip addr show
```
Private IP identified: 172.31.30.185

### Observation:

The instance IP 172.31.30.185 falls within the private IP range 172.16.0.0 - 172.31.255.255. 

# Task 3: CIDR & Subnetting

### What does /24 mean?

/24 means the first 24 bits represent the network portion and the remaining 8 bits represent host addresses.

### Why do we subnet?

Subnetting divides a large network into smaller networks to improve security, efficiency, and traffic management.

**CIDR Table**


| CIDR | Subnet Mask | Total IPs | Usable Hosts |
|------|-------------|-----------|--------------|
| /24 | 255.255.255.0 | 256 | 254 |
| /16 | 255.255.0.0 | 65536 | 65534 |
| /28 | 255.255.255.240 | 16 | 14 |


# Task 4: Ports – The Doors to Services

### What is a Port?

A port is a logical communication endpoint that allows multiple services to run on the same IP address.

**Common Ports**

| Port | Service |
| 22 |	SSH |
| 80 |	HTTP |
| 443 |	HTTPS |
| 53 |	DNS |
| 3306 |	MySQL |
| 6379 |	Redis |
| 27017 |	MongoDB |

### Command

```bash
ss -tulpn
```
Listening Ports Identified:

- Port 22 - SSH service (remote server access)
- Port 53 - DNS resolver service

### Observation:

The system is listening on port 22 for SSH connections and port 53 for DNS queries.

# Task 5: Putting It Together

```bash
curl http://myapp.com:8080
```
### what networking concepts are involved?

When this command runs, DNS first resolves myapp.com to an IP address. 

Then a TCP connection is established to port 8080 on the server.

Finally, the HTTP request is sent to the application running on that port.

## What I Learned

- DNS translates domain names into IP addresses using records like A, AAAA, and CNAME.
- Private IP addresses are used within internal networks and are not routable on the public internet.
- Ports allow multiple services such as SSH and DNS to run on the same machine.
  
