# Docker

## Overview

The `compose.yml` file is a crucial component of Docker Compose, a tool used for defining and running multi-container Docker applications. This file allows developers to configure application services, networks, and volumes, enabling seamless orchestration of containerized environments.

In the context of the **Questivity** platform, the `compose.yml` file specifies the various services that make up the application, their configuration, and how they communicate with each other.

## How Docker Uses `compose.yml`

When you run the command `docker-compose up`, Docker Compose reads the `compose.yml` file to create and start all the services defined within it. Each service is essentially a container that runs a specific image or a build command. The following steps outline how Docker utilizes this configuration file:

1. **Parsing the File**: Docker Compose parses the `compose.yml` file to identify services, networks, and volumes.
2. **Creating Networks**: Docker Compose sets up defined networks (e.g., `database`, `proxy`, `canvas`) to facilitate communication between containers.
3. **Building Images**: If a service specifies a `build` directive, Docker Compose builds the image from the specified Dockerfile.
4. **Starting Containers**: Docker Compose launches each container based on the service definitions, applying configurations such as environment variables, volume mounts, and port mappings.
5. **Dependency Management**: Docker Compose ensures that services are started in the correct order based on the `depends_on` attribute and their health checks.

---

## Service Definitions

The `compose.yml` file for the **Questivity** platform defines the following services:

---

### **nginx**

-   **Container Name**: `nginx`
-   **Image**: `nginx:latest`
-   **Restart Policy**: `unless-stopped`
-   **Ports**: Maps port `80` on the host to port `80` in the container, allowing external access to the NGINX service.
-   **Volumes**:
    -   Mounts the Godot export directory to serve the frontend files from the `/usr/share/nginx/html/questivity/` path.
    -   Loads the NGINX configuration file located in the `./nginx/nginx.conf` path.
-   **Dependencies**: This service depends on `godot-export`, `adminer`, `dozzle-logs`, `canvas`, and `questivity-server` to ensure they are running before NGINX starts.
-   **Networks**: Connects to the `proxy` and `canvas` networks, allowing communication with other related services.

---

### **godot-export**

-   **Container Name**: `godot-export`
-   **Image**: `beijingsoftware/godot-export:3.6-stable-html5`
-   **Restart Policy**: `unless-stopped`
-   **Volumes**:
    -   Mounts the `../godot/` directory for building the Godot project.
    -   Mounts the `../godot-export/` directory to store the exported assets.

---

### **mysql**

-   **Container Name**: `mysql`
-   **Image**: `mysql:latest`
-   **Restart Policy**: `unless-stopped`
-   **Expose**: Exposes port `3306` internally, allowing other containers in the `database` network to connect.
-   **Environment Variables**: Configures the database with root and user credentials, as well as the initial database name using environment variables.
-   **Health Check**: Implements a health check to ensure MySQL is ready by executing a simple query.
-   **Networks**: Connects to the `database` network to facilitate database access for other services.

---

### **adminer**

-   **Container Name**: `adminer`
-   **Image**: `adminer`
-   **Restart Policy**: `unless-stopped`
-   **Expose**: Exposes port `8080` for accessing the Adminer web interface, allowing users to manage the MySQL database.
-   **Networks**: Connects to both the `database` and `proxy` networks to facilitate database management and access via the proxy.

---

### **dozzle-logs**

-   **Container Name**: `dozzle-logs`
-   **Image**: `amir20/dozzle:latest`
-   **Restart Policy**: `unless-stopped`
-   **Volumes**: Mounts the Docker socket (`/var/run/docker.sock`) to monitor and display logs from running containers.
-   **Expose**: Exposes port `8080` for accessing the Dozzle log viewer.
-   **Networks**: Connects to the `proxy` network to facilitate access through the NGINX proxy.

---

### **heimdall**

-   **Container Name**: `heimdall`
-   **Image**: `linuxserver/heimdall`
-   **Restart Policy**: `unless-stopped`
-   **Environment Variables**: Configures user ID and group ID for file permissions.
-   **Volumes**: Stores the configuration and assets, including icons and backgrounds.
-   **Expose**: Exposes port `80` for access to the Heimdall dashboard.
-   **Networks**: Connects to the `proxy` network for integration with other services.

---

### **canvas**

-   **Container Name**: `canvas`
-   **Image**: `lbjay/canvas-docker`
-   **Restart Policy**: `unless-stopped`
-   **Expose**: Exposes port `3000` for accessing the Canvas service.
-   **Networks**: Connects to the `canvas` network for service-specific communication.

---

### **questivity-server**

-   **Container Name**: `questivity-server`
-   **Build Context**: Builds the Docker image from the `../questivity-server/` directory.
-   **Restart Policy**: `unless-stopped`
-   **Command**: Executes the command to run database migrations and starts the Django development server.
-   **Volumes**: Mounts the server code directory for live updates during development.
-   **Expose**: Exposes port `8000` for the backend API, allowing other services to interact with it.
-   **Environment Variables**: Configures connection settings for the MySQL database and the Django superuser password.
-   **Dependencies**: Waits for the MySQL service to be healthy before starting, ensuring that the database is ready for connections.
-   **Networks**: Connects to both the `proxy` and `database` networks to facilitate communication with frontend services and the database.

---

## Networks Configuration

The `compose.yml` file defines three networks:

-   **database**: This network allows services related to data storage and management (such as MySQL and Adminer) to communicate with each other securely.
-   **proxy**: This network facilitates communication between frontend services (like NGINX, Heimdall, and Dozzle) and backend services (like the Questivity server), effectively allowing the frontend to access APIs and services.
-   **canvas**: A dedicated network for the Canvas service, ensuring it can operate independently while still being accessible to related services when needed.

---
