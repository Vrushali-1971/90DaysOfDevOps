# Day 34: Advanced Docker Compose Challenge 🚀

## Project Overview
In this challenge, I moved beyond basic containerization to build a **production-ready 3-tier architecture**. The stack includes a Flask-based Web App, a Redis Cache for hit counting, and a PostgreSQL Database for persistent storage.

## Key Features Implemented

### 1. Service Orchestration & Healthchecks
I implemented a strict dependency rule. The **Web** service only starts once the **Postgres DB** passes its internal healthcheck.
* **Command used:** `pg_isready -U postgres`
* **Result:** No "Connection Refused" errors during startup.

### Does the app wait for the DB?
Yes. By using the `depends_on` parameter with the `condition: service_healthy` attribute, Docker Compose ensures the Web service stays in a "waiting" state until the Database service passes its defined `healthcheck`. This prevents "Connection Refused" errors caused by the application trying to connect to a database that is still initializing its internal engine.

### 2. Self-Healing Infrastructure (Task 3)
I configured `restart: always` and `on-failure` policies. I verified this by manually killing containers and restarting the Docker engine; the stack automatically restored itself to a healthy state.

### When would you use each restart policy?

- `no` (Default): Use during active development when you want to see error logs immediately without the container constantly trying to restart.

- `always`: Use for critical infrastructure services like **Databases (PostgreSQL) or Caches (Redis)**. This ensures they start automatically after a server reboot or a Docker daemon restart.

- `on-failure`: Best for Application Servers **(Flask/Python)**. It restarts the container if it crashes (exit code non-zero), but if you manually stop it for maintenance, it stays stopped.

- `unless-stopped`: Similar to `always`, but it prevents the container from starting at boot if it was manually stopped before the server went down.


### 3. Data Persistence with Named Volumes (Task 5)
To ensure data isn't lost when containers are destroyed, I implemented **Named Volumes**:
* `db_data` for PostgreSQL records.
* `redis_data` for the Redis hit counter.
* **Verification:** My "View Count" persisted even after running `docker compose down`.

### 4. Custom Networking & Labels
* Created a dedicated bridge network (`josh-net`) for isolated service communication.
* Added metadata **Labels** (Project, Owner, Version) to all services for better organization and resource tracking.

### 5. Horizontal Scaling (Task 6)
I tested the scalability of the web tier by spinning up multiple instances.
* **Command:** `docker compose up -d --scale web=3`
* **Outcome:** Docker dynamically allocated unique ports for each instance, allowing the app to handle increased traffic.


### Why doesn't simple scaling work with fixed port mapping?
Port Collision. > On a single host (EC2), a port like 5000 can only be used by one process at a time. If web-1 is using port 5000, web-2 and web-3 will fail to start because the "door" is already taken. To scale, we must use Dynamic Port Mapping, which allows Docker to assign random available ports to each instance.

---

## Technical Stack
- **Frontend/API:** Python Flask
- **Cache:** Redis Alpine
- **Database:** PostgreSQL 15
- **Orchestration:** Docker Compose V2

## How to Run

1. Navigate to the `day-34/advanced-stack` folder.
2. Run `docker compose up -d`.
3. Access the app at `http://<EC2-Public-IP>:5000`.
