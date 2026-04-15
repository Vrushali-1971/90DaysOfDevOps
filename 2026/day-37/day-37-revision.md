# Day 37: Docker Revision & Self-Assessment

## Goal
The goal of today was to consolidate learning from Days 29–36, ensuring a deep understanding of Docker architecture, multi-stage builds, and container lifecycles.

---

## ✅ Self-Assessment Checklist

| Task | Status |
| :--- | :--- |
| Run a container (Interactive + Detached) | **Can do** |
| List, stop, remove containers and images | **Can do** |
| Explain image layers and how caching works | **Can do** |
| Write a Dockerfile from scratch | **Can do** |
| Explain CMD vs ENTRYPOINT | **Revised** (Understand it as Destination vs Engine) |
| Build and tag a custom image | **Can do** |
| Create and use named volumes | **Revised** |
| Use bind mounts | **Can do** |
| Create custom networks and connect containers | **Revised** |
| Write a docker-compose.yml for a multi-container app | **Revised** |
| Use environment variables and .env files in Compose | **Revised**|
| Write a multi-stage Dockerfile | **Revised** |
| Push an image to Docker Hub | **Can do** |
| Use healthchecks and depends_on | **Revised** |

---

## ⚡ Quick-Fire Questions

**1. What is the difference between an image and a container?**
An image is a read-only blueprint (a snapshot), while a container is a running instance of that image.

**2. What happens to data inside a container when you remove it?**
The data is lost permanently unless it is stored in a Docker Volume or a Bind Mount.

**3. How do two containers on the same custom network communicate?**
They can communicate using their **Container Names** as hostnames. Docker’s internal DNS handles the IP resolution.

**4. What does `docker compose down -v` do differently from `docker compose down`?**
Regular `down` removes containers and networks; adding `-v` also deletes the **named volumes** associated with the services.

**5. Why are multi-stage builds useful?**
They allow us to use heavy tools in the build stage but only keep the necessary binaries/files in the final image, drastically reducing the final image size.

**6. What is the difference between COPY and ADD?**
`COPY` simply copies local files. `ADD` can also download files from URLs and automatically extract `.tar.gz` files.

**7. What does `-p 8080:80` mean?**
It maps port **8080** on the Host (EC2/Local) to port **80** inside the Container.

**8. How do you check how much disk space Docker is using?**
Use the command: `docker system df`.


## 🛠️ Revised Topics (Deep Dive)
I picked the two most challenging topics to revisit through hands-on practice:

### 1. Multi-stage Dockerfile Optimization
**Problem:** My initial container builds were carrying unnecessary weight from the build environment.
**Action:** I built a 2-stage `hello-world` app. 
- **Stage 1 (Builder):** Used `python:3.9` to prepare the environment.
- **Stage 2 (Final):** Used `python:3.9-slim` and the `COPY --from=builder` instruction to bring over only the required script.
**Learning:** I successfully debugged a "Process Lifecycle" issue where the container would exit immediately after printing. I learned that a container stays alive only as long as its foreground process is running.

### 2. Multi-container Orchestration (docker-compose.yml)
**Action:** I revisited the configurations for the Day 35 and 36 projects.
**Key Insights:**
- **Service Networking:** Confirmed that services use their names (e.g., `db` or `web`) as hostnames to communicate, eliminating the need for hardcoded IP addresses.
- **Volume Persistence:** Practiced using `docker compose down -v` to understand how to completely wipe a development environment versus a standard `down` that preserves data.
- **Environment Mapping:** Practiced mapping `.env` variables inside the YAML to keep sensitive data out of the main configuration file.


**Final Multi-Stage Dockerfile wrote for practice:**
```dockerfile
# Stage 1: Build
FROM python:3.9 AS builder
WORKDIR /app
COPY hello.py .

# Stage 2: Final Production
FROM python:3.9-slim
WORKDIR /app
COPY --from=builder /app .
EXPOSE 8080
CMD ["python", "hello.py"]
```

### 📚 Resources
- [View my Docker Cheat Sheet](./docker-cheatsheet.md)
