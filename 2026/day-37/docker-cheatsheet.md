#  Docker Commands Cheat Sheet

##  Running Containers
| Task | Command |
| :--- | :--- |
| **Run container** | `docker run nginx` |
| **Run detached (background)** | `docker run -d nginx` |
| **Run with custom name** | `docker run --name my-nginx -d nginx` |
| **Port mapping (Host:Container)** | `docker run -p 8080:80 nginx` |
| **Pass environment variable** | `docker run -e DB_HOST=localhost my-app` |
| **Bind mount volume** | `docker run -v $(pwd):/app my-app` |
| **Named volume** | `docker run -v my-volume:/data my-app` |
| **Interactive shell (bash/sh)** | `docker run -it ubuntu bash` |
| **Auto-remove container on stop** | `docker run --rm nginx` |
| **Set restart policy** | `docker run --restart=always nginx` |
| **Limit container memory** | `docker run -m 512m nginx` |

##  Listing & Inspection
| Task | Command |
| :--- | :--- |
| **Show running containers** | `docker ps` |
| **Show all containers (incl. stopped)** | `docker ps -a` |
| **Show only container IDs** | `docker ps -q` |
| **View container logs** | `docker logs container_id` |
| **Follow live logs** | `docker logs -f container_id` |
| **Inspect container details (JSON)** | `docker inspect container_id` |
| **Show live resource usage** | `docker stats` |

## Stopping & Removing
| Task | Command |
| :--- | :--- |
| **Stop container** | `docker stop container_id` |
| **Start stopped container** | `docker start container_id` |
| **Restart container** | `docker restart container_id` |
| **Kill container immediately** | `docker kill container_id` |
| **Remove stopped container** | `docker rm container_id` |
| **Force remove running container** | `docker rm -f container_id` |
| **Remove all containers** | `docker rm $(docker ps -aq)` |

##  Execution & File Transfer
| Task | Command |
| :--- | :--- |
| **Run command inside container** | `docker exec -it container_id bash` |
| **Copy file: Container → Host** | `docker cp container_id:/app/file.txt .` |
| **Copy file: Host → Container** | `docker cp file.txt container_id:/app/` |

##  Image Management
| Task | Command |
| :--- | :--- |
| **Build image from Dockerfile** | `docker build -t my-app:v1 .` |
| **List local images** | `docker images` |
| **Tag image for Docker Hub** | `docker tag my-app:v1 username/repo:v1` |
| **Push image to registry** | `docker push username/repo:v1` |
| **Pull image from Hub** | `docker pull nginx` |
| **Remove image** | `docker rmi image_id` |
| **Remove all images** | `docker rmi $(docker images -q)` |

##  Volumes & Networking
| Task | Command |
| :--- | :--- |
| **List volumes** | `docker volume ls` |
| **Create named volume** | `docker volume create my-vol` |
| **Remove volume** | `docker volume rm my-vol` |
| **List networks** | `docker network ls` |
| **Create bridge network** | `docker network create my-net` |
| **Connect container to network** | `docker network connect my-net container_id` |

##  Docker Compose
| Task | Command |
| :--- | :--- |
| **Start stack (detached)** | `docker compose up -d` |
| **Stop and remove stack** | `docker compose down` |
| **Stop and wipe volumes (Careful!)** | `docker compose down -v` |
| **Rebuild images and start** | `docker compose up -d --build` |
| **Check service status** | `docker compose ps` |
| **View stack logs** | `docker compose logs -f` |

##  Cleanup Power Commands
| Task | Command |
| :--- | :--- |
| **Check disk usage** | `docker system df` |
| **Remove stopped containers** | `docker container prune` |
| **Deep clean (unused images/nets)** | `docker system prune -a` |
| **Stop & remove all (Bash)** | `docker stop $(docker ps -q) && docker rm $(docker ps -aq)` |

##  Dockerfile Reference
| Instruction | Usage |
| :--- | :--- |
| `FROM` | Sets the base image (e.g., `python:3.9-slim`). |
| `WORKDIR` | Sets the directory for subsequent commands. |
| `COPY` | Moves files from host machine to image. |
| `RUN` | Executes commands during image build time. |
| `AS` | Defines a name for a build stage (Multi-stage). |
| `COPY --from=` | Copies artifacts from a previous build stage. |
| `CMD` | Default command when the container starts. |
| `ENTRYPOINT` | The main executable of the container. |
