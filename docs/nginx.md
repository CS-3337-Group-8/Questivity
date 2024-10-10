# Nginx Configuration Documentation

This document provides an overview of the Nginx configuration for the Questivity project. The configuration is set up to handle multiple services and includes essential directives to optimize the server's performance.

## Configuration Overview

```nginx
worker_processes auto;

events {
    worker_connections 1024;
}
```

-   **worker_processes auto;**: Automatically sets the number of worker processes based on available CPU cores, optimizing performance for handling requests.
-   **worker_connections 1024;**: Limits the maximum number of simultaneous connections that can be handled by a single worker process. In this configuration, each worker can handle up to 1024 connections.

## HTTP Block

```nginx
http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
```

-   **include /etc/nginx/mime.types;**: Includes the MIME types configuration file, allowing Nginx to serve files with the correct content type based on their extensions.
-   **default_type application/octet-stream;**: Sets the default MIME type for files that do not have a specific type defined, ensuring they are served as binary data.

### Server Blocks

#### Heimdall Server

```nginx
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://heimdall:80/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

-   **listen 80;**: Specifies that this server block listens for incoming HTTP requests on port 80.
-   **server_name localhost;**: Defines the server name for this block, allowing it to respond to requests made to `localhost`.
-   **proxy_pass http://heimdall:80/;**: Proxies requests to the Heimdall service running on port 80.
-   **proxy_set_header** directives: Forward client information to the proxied server, ensuring it receives the original request details.

#### Logs Server

```nginx
server {
    listen 80;
    server_name logs.localhost;

    location / {
        proxy_pass http://dozzle:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

-   This server block is configured for accessing logs via Dozzle, allowing users to view Docker container logs.

#### API Server

```nginx
server {
    listen 80;
    server_name api.localhost;

    location / {
        alias /usr/share/nginx/html/api/;
    }

    location /db/ {
        proxy_pass http://db-api:3000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

-   **alias /usr/share/nginx/html/api/**: Serves static files located in the specified directory for API-related requests.
-   Proxies requests to the `/db/` path to the DB API service for dynamic interactions.

#### Adminer Server

```nginx
server {
    listen 80;
    server_name adminer.localhost;

    location / {
        proxy_pass http://adminer:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

-   This block facilitates access to the Adminer database management tool.

#### Questivity Server

```nginx
server {
    listen 80;
    server_name questivity.localhost;

    location / {
        alias /usr/share/nginx/html/questivity/;
    }
}
```

-   Serves the main Questivity application from the specified directory.

#### Canvas Server

```nginx
server {
    listen 80;
    server_name canvas.localhost;

    location / {
        proxy_pass http://canvas:3000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

-   Proxies requests to the Canvas service, enabling interaction with the Canvas LMS.
