# Day 29: Introduction to Docker - Basics & Hands-on

## Task 1: What is Docker?
### What is a container?
A container is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries, and settings. We need them to solve the "It works on my machine" problem.

### Containers vs Virtual Machines
- **VMs:** Virtualize hardware. Each has a full Guest OS. Heavy and slow.
- **Containers:** Virtualize the Operating System. They share the Host OS kernel. Lightweight and fast.

### Docker Architecture
- **Docker Client:** The CLI tool we use to give commands.
- **Docker Daemon:** The background service that manages Docker objects.
- **Images:** Read-only blueprints for containers.
- **Containers:** Runnable instances of images.
- **Registry:** A place to store and share images (e.g., Docker Hub).

---

## Task 2: Installation
I installed Docker on my Ubuntu instance using:
```bash
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo usermod -aG docker $USER
```

### Verification:
Ran `docker run hello-world`. The output confirmed that the Docker client contacted the daemon, pulled the image from the Hub, and created the container successfully.

## Task 3 & 4: Running & Exploring Containers

### 1. Nginx Web Server
Ran Nginx in detached mode with port mapping:
`docker run -d -p 8080:80 --name my-webserver nginx`

**Detached Mode (-d):** The container runs in the background, keeping the terminal free.

**Port Mapping (-p):** Mapped host port 8080 to container port 80.

### 2. Interactive Ubuntu
`docker run -it ubuntu bash`
Explored the container filesystem and exited, which stopped the container.

### 3. Redis Database & Exec Command
`docker run -d --name my-redis -p 6379:6379 redis`
Used docker exec -it my-redis redis-cli to run commands inside the running container without stopping it.

### 4. Cleanup
Used docker container prune to remove all stopped containers 
