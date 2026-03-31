# Day 31 – Dockerfile: Build Your Own Images

### Task
Today's goal is to write Dockerfiles and build custom images.


## Task 1: My First Dockerfile
- **Goal:** Create a custom Ubuntu image with `curl` installed.

- **Process:** Used `FROM ubuntu:latest`, RUN `apt-get update && apt-get install -y curl`, and `CMD` to print a welcome message.

- **Result:** Successfully built my-ubuntu:v1. Running the container displays: `Hello from my custom image!`.

## Task 2: Dockerfile Instructions Toolkit
I created a comprehensive Dockerfile using the following instructions:

- **FROM:** Set the base OS (Ubuntu).

- **RUN:** Installed `iputils-ping` during the build phase.

- **WORKDIR:** Set `/app` as the active directory for all subsequent commands.

- **COPY:** Transferred `task2.txt` from my host machine into the container.

- **EXPOSE:** Documented port 80 for web traffic.

- **CMD:** Set the default runtime command to `ls -la`.

## Task 3: CMD vs ENTRYPOINT
- **CMD** `["echo", "Hello"]`: When I ran `docker run img-cmd World`, it failed because "World" tried to replace the entire executable command. CMD is a default that is easily overridden.

- **ENTRYPOINT**`["echo"]`: When I ran `docker run img-ep World`, it printed "World". ENTRYPOINT is permanent; any arguments passed are appended to it.

- **Conclusion:** Use **ENTRYPOINT** for the main executable and **CMD** for default arguments.

## Task 4: Custom Nginx Web Server
- **Action:** Created a custom `index.html` and copied it into `/usr/share/nginx/html/` inside an `nginx:alpine` image.

- **Command:** `docker run -d -p 8080:80 my-website:v1`

- **Verification:** Successfully accessed the custom website via the server's IP on port 8080.

## Task 5: Using .dockerignore
- **Goal:** Prevent "trash" or sensitive files from entering the image.

- **Setup:** Created a `.dockerignore` file containing `.env`, `node_modules`, and `*.md`.

- **Result:** Even when using `COPY . .`, the final image did not contain the ignored files, keeping the image small and secure.

## Task 6: Build Optimization (Layer Caching)
This task demonstrated how the order of instructions impacts build speed.

| Dockerfile Version           | Change Made        |  Build Time |  Cache Status                             |
|------------------------------|--------------------|-------------|-------------------------------------------|   
| Dockerfile.slow (COPY at top)| Changed index.html |  14.167s    |  Cache Broken (Re-installed all packages) |
| Dockerfile.fast (RUN at top) | Changed index.html |  0.087s     |  Cache Hit (Reused previous layers)       |


## Why does order matter?
Docker builds in layers from top to bottom. If a layer changes (like a file copy), Docker invalidates the cache for every layer below it. By putting stable, heavy tasks (like apt-get install) at the top and frequently changing tasks (like COPY code) at the bottom, I achieved a 160x speed improvement.

## Final Reflections
Writing efficient Dockerfiles is about more than just making things work—it's about optimizing the Developer Experience (DX). Understanding layer caching and the difference between instructions allows for faster CI/CD pipelines and leaner images.

