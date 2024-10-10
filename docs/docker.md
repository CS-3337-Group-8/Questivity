# Docker Networking Documentation

## Overview

In this Docker Compose setup, we define three bridge networks: `database`, `proxy`, and `canvas`. Each network serves a specific purpose, allowing services to communicate within their designated contexts while isolating them from others as necessary. This document outlines the configuration and purpose of each network and how the services interact within them.

## Network Definitions

### 1. Database Network

```yaml
database:
    driver: bridge
```

-   **Purpose**: The `database` network is designed to facilitate communication between database-related services, ensuring that they can access each other securely and efficiently.
-   **Services Connected**:
    -   `db`: This service runs a MySQL database, exposing its port to other services in the `database` network. It initializes with provided environment variables, such as database name and user credentials.
    -   `db-api`: This service acts as an API layer for the database, allowing other services to interact with it programmatically. It depends on the `db` service and can access it through the hostname `db`.
    -   `adminer`: This service provides a web-based interface for managing the MySQL database, allowing users to easily interact with the database schema and data.

### 2. Proxy Network

```yaml
proxy:
    driver: bridge
```

-   **Purpose**: The `proxy` network serves as a communication layer for services that need to handle web traffic and provide reverse proxy capabilities.

-   **Services Connected**:
    -   `web`: This service uses Nginx to serve static content and proxy requests to other services. It depends on several other services to ensure all required functionalities are available.
    -   `dozzle`: This service provides a web-based interface to monitor Docker logs in real-time. It can connect to the `web` service through the `proxy` network, allowing seamless monitoring.
    -   `heimdall`: This service provides a customizable dashboard to manage applications and services. It can interact with the `web` service through the `proxy` network.

### 3. Canvas Network

```yaml
canvas:
    driver: bridge
```

-   **Purpose**: The `canvas` network is designated for services related to the Canvas Learning Management System (LMS), allowing them to communicate securely.

-   **Services Connected**:
    -   `canvas`: This service runs a Canvas LMS instance. It is isolated in its network but can still communicate with other services if necessary. The network configuration allows for easy scaling and management of Canvas-related functionalities.

## Service Configuration and Interactions

### Web Service

```yaml
web:
    container_name: web
    image: nginx:latest
    restart: unless-stopped
    ports:
        - "80:80"
    volumes:
        - ./web/html:/usr/share/nginx/html
        - ./web/nginx.conf:/etc/nginx/nginx.conf
    depends_on:
        - heimdall
        - db-api
        - gd-export
        - adminer
    networks:
        - database
        - proxy
        - canvas
```

-   **Role**: Serves as the entry point for HTTP traffic, exposing port 80 to the host and routing requests to appropriate services.
-   **Connections**: The `web` service connects to all three networks (`database`, `proxy`, and `canvas`), enabling it to interact with various services across different contexts.

### Database Service

```yaml
db:
    container_name: db
    image: mysql
    restart: unless-stopped
    expose:
        - "3306"
    volumes:
        - ./db:/docker-entrypoint-initdb.d
    environment:
        MYSQL_DATABASE: database
        MYSQL_USER: user
        MYSQL_PASSWORD: password
        MYSQL_ROOT_PASSWORD: rootpassword
        TZ: "America/Los_Angeles"
    networks:
        - database
    depends_on:
        - dozzle
```

-   **Role**: Hosts a MySQL database instance, initialized with specified environment variables.
-   **Connections**: Only connected to the `database` network, providing secure access to database-related services.

### API Service

```yaml
db-api:
    container_name: db-api
    build: ./db-api
    restart: unless-stopped
    expose:
        - "3000"
    environment:
        DB_HOST: db
        DB_USER: user
        DB_PASSWORD: password
        DB_NAME: database
        TZ: "America/Los_Angeles"
        PORT: "3000"
        API_KEY: 9a1442ec-0d0a-4b76-9b1a-38a526d51f2a
    depends_on:
        - db
    networks:
        - database
```

-   **Role**: Acts as an intermediary for applications to communicate with the MySQL database.
-   **Connections**: Connected to the `database` network for direct communication with the `db` service.

### Canvas Service

```yaml
canvas:
    container_name: canvas
    image: lbjay/canvas-docker
    restart: unless-stopped
    expose:
        - "3000"
    networks:
        - canvas
```

-   **Role**: Runs the Canvas LMS application.
-   **Connections**: Isolated in its own network (`canvas`), promoting security and performance.

### Monitoring and Management Services

#### Dozzle

```yaml
dozzle:
    container_name: dozzle
    restart: unless-stopped
    image: amir20/dozzle:latest
    volumes:
        - /var/run/docker.sock:/var/run/docker.sock
    expose:
        - "8080"
    networks:
        - proxy
```

-   **Role**: Provides a UI for monitoring Docker logs.
-   **Connections**: Part of the `proxy` network to interact with the `web` service and other services requiring log access.

#### Adminer

```yaml
adminer:
    container_name: adminer
    restart: unless-stopped
    image: adminer
    expose:
        - "8080"
    networks:
        - database
```

-   **Role**: Web-based database management tool.
-   **Connections**: Connected solely to the `database` network for secure access to the MySQL instance.

#### Heimdall

```yaml
heimdall:
    container_name: heimdall
    image: linuxserver/heimdall
    restart: unless-stopped
    environment:
        PUID: 1000
        PGID: 1000
    volumes:
        - ./heimdall/app.sqlite:/config/www/app.sqlite
        - ./heimdall/backgrounds:/config/www/backgrounds
        - ./heimdall/icons:/config/www/icons
    expose:
        - "80"
    networks:
        - proxy
```

-   **Role**: Customizable dashboard for managing links to applications.
-   **Connections**: Part of the `proxy` network to facilitate communication with the `web` service.

### Godot Export Service

```yaml
gd-export:
    container_name: gd-export
    build:
        context: .
        dockerfile: ./gd-export/Dockerfile
        args:
            GODOT_VERSION: 3.6-stable
            GODOT_VERSION_DIR: 3.6.stable
            EXPORT_NAME: HTML5
            OUTPUT_FILENAME: index.html
    restart: no
    volumes:
        - ../godot:/build/src
        - ./web/html/questivity:/build/output
```

-   **Role**: Builds and exports Godot projects to HTML5 format.
-   **Connections**: Not explicitly connected to any network; however, it can interact with other services via volume mounts and shared file access.
