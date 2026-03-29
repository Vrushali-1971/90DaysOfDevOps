# Day 30: Docker Images & Container Lifecycle

## Goal - Today's goal is to understand how images and containers actually work

- To Learn the relationship between images and containers
- To Understand image layers and caching
- To Master the full container lifecycle

## Task 1: Image Management & Comparison
In this task, I pulled various Linux distributions and applications to compare their footprints and metadata.Image 

| Image  | Tag    |  Size   | Key Observation                                       |
|--------|--------|---------|-------------------------------------------------------|
| nginx  | latest | ~161MB  | Contains the OS plus Nginx binaries.                  |
| ubuntu | latest | ~78.1MB | A full standard OS with all common utilities.         |
| alpine | latest | ~8.44MB | Extremely minimalist; missing non-essential libraries.|

### Q: Why is Alpine so much smaller than Ubuntu?
A: Ubuntu is a full-featured OS including the bash shell and apt package manager. Alpine is a minimalist distribution designed for containers; it uses sh instead of bash and a smaller C-library (musl), making it more secure and faster to pull.

## Task 2: Image Layers & Immutability
I analyzed the history of the Nginx image to understand how Docker stacks files.

#### Command Used: `docker image history nginx`

### Q: Why are Docker layers immutable (read-only)?
A: Layers are shared between multiple images. If a base layer (like Debian) was changeable, a single modification could break every other image on the system that relies on it. Immutability ensures consistency and allows for efficient layer caching.

## Task 3: Container Lifecycle States
I manually moved a container through its entire life cycle to observe state changes in docker ps -a.

- Created: `docker create --name life-test alpine sleep 100`

-  Started:`docker start life-test`

- Paused: `docker pause life-test (Freezes the process in RAM).`

- Unpaused: `docker unpause life-test`

- Stopped: `docker stop life-test (Graceful shutdown via SIGTERM).`

- Killed: `docker kill life-test (Immediate shutdown via SIGKILL).`

- Removed: `docker rm life-test`

### Q: What is the difference between stop and kill?
A: Stop sends a signal to the application to save its work and shut down gracefully (usually gives it 10 seconds). Kill is like pulling the power plug; it terminates the process instantly.

## Task 4: Working with Running Containers
I practiced interacting with live containers and extracting specific metadata.

- Viewing Live Logs: `docker logs -f nginx-admin`

- Internal Navigation: `docker exec -it nginx-admin bash`

- Advanced Inspection: `Used the --format flag to filter JSON output.`

#### Command for Metadata:
`docker inspect --format 'IP: {{.NetworkSettings.IPAddress}} | Ports: {{.NetworkSettings.Ports}}' nginx-admin`

### Q: If you exit a bash session started with docker exec, does the container stop?
A: No. The container stays alive as long as its main process (Nginx) is running. The bash session was a secondary process; exiting it does not affect the primary web server.

## Task 5: Cleanup & Disk Management
I performed a "deep clean" to reclaim system resources.

- Stop all: `docker stop $(docker ps -q)`

- System Prune: `docker system prune -a`

### Q: Why was the "Reclaimable" space so high in docker system df?
A: Because I had deleted all containers, the images were no longer "active." Docker marked them as 100% reclaimable because they were taking up disk space without being used by any running instance.     
