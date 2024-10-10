# Questivity

Welcome to **Questivity**, a gamification platform designed to seamlessly connect with Canvas LMS networks. Our platform enhances learning experiences by integrating gamified elements into educational environments.

## Overview

Questivity utilizes the Learning Tools Interoperability (LTI) standard, enabling smooth integration with various Learning Management Systems (LMS). With a focus on user engagement, Questivity aims to foster an interactive learning atmosphere through games, quizzes, and other engaging activities.

## Architecture

Questivity is built using a microservices architecture, allowing for scalability and flexibility. Below is an overview of our service architecture:

### Database Services

-   **Database**: A MySQL database service that stores user data, application state, and more.

### Web Services

-   **Web Server**: An Nginx-based web server that serves the frontend application and static files.

### API Services

-   **QuestivityDB API**: A RESTful API that facilitates communication between the frontend and the database, providing access to essential data and operations.

### Export Services

-   **GD Export**: A service responsible for exporting content from Godot to HTML5, enabling seamless access to gamified experiences in a web browser.
