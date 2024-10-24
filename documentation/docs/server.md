# Questivity Server

This is a Django-based project designed to manage user interactions and functionalities for the Questivity application. This documentation will guide you through the project structure, including an explanation of the core components and how to extend its functionality.

---

## Questivity API

### Base URL

```
http://localhost/server/
```

### Authentication

For endpoints requiring authentication, a JWT (JSON Web Token) is used. The token should be included in the `Authorization` header as follows:

```
Authorization: Bearer <your-jwt-token>
```

---

## Endpoints

### User Registration

-   **Endpoint**: `/users/register/`
-   **Method**: `POST`
-   **Request Data**:

    ```json
    {
        "username": "string",
        "password": "string"
    }
    ```

    -   **Parameters**:
        -   `username` (string, required): A unique identifier for the user.
        -   `password` (string, required): The password for the user account.

-   **Response**:

    -   **Success** (HTTP 201 Created):

        ```json
        {
            "message": "User created successfully",
            "data": {
                "id": 1,
                "username": "string",
                "is_instructor": false,
                "games_played": 0,
                "experience_level": 0
            }
        }
        ```

    -   **Error** (HTTP 400 Bad Request):
        ```json
        {
            "detail": "This field may not be blank."
        }
        ```
        -   Possible error messages may include:
            -   `{"detail": "A user with that username already exists."}`
            -   `{"detail": "Invalid data."}`

---

### User Login

-   **Endpoint**: `/users/login/`
-   **Method**: `POST`
-   **Request Data**:

    ```json
    {
        "username": "string",
        "password": "string"
    }
    ```

    -   **Parameters**:
        -   `username` (string, required): The user's username.
        -   `password` (string, required): The user's password.

-   **Response**:

    -   **Success** (HTTP 200 OK):

        ```json
        {
            "message": "User logged in successfully",
            "jwt": "your-jwt-token",
            "data": {
                "id": 1,
                "username": "string",
                "is_instructor": false,
                "games_played": 0,
                "experience_level": 0
            }
        }
        ```

    -   **Error** (HTTP 401 Unauthorized):
        ```json
        {
            "detail": "User not found!" // or "Incorrect password!"
        }
        ```

---

### Get User Details

-   **Endpoint**: `/users/user/`
-   **Method**: `GET`
-   **Authorization**: Required (Bearer token in header).

-   **Response**:

    -   **Success** (HTTP 200 OK):

        ```json
        {
            "id": 1,
            "username": "string",
            "is_instructor": false,
            "games_played": 0,
            "experience_level": 0
        }
        ```

    -   **Error** (HTTP 401 Unauthorized):
        ```json
        {
            "detail": "Unauthenticated!"
        }
        ```

---

### Delete User Account

-   **Endpoint**: `/users/user/`
-   **Method**: `DELETE`
-   **Authorization**: Required (Bearer token in header).

-   **Response**:

    -   **Success** (HTTP 200 OK):

        ```json
        {
            "message": "User deleted successfully"
        }
        ```

    -   **Error** (HTTP 401 Unauthorized):
        ```json
        {
            "detail": "Unauthenticated!"
        }
        ```

---

### User Logout

-   **Endpoint**: `/users/logout/`
-   **Method**: `POST`
-   **Authorization**: Required (Bearer token in header).

-   **Response**:

    -   **Success** (HTTP 200 OK):

        ```json
        {
            "message": "Success"
        }
        ```

    -   **Error** (HTTP 401 Unauthorized):
        ```json
        {
            "detail": "Unauthenticated!"
        }
        ```

---

### Server Version

-   **Endpoint**: `/`
-   **Method**: `GET`

-   **Response**:

    -   **Success** (HTTP 200 OK):

        ```json
        {
            "message": "Questivity Server Version 1.2"
        }
        ```

    -   **Error** (HTTP 500 Internal Server Error):
        ```json
        {
            "detail": "An unexpected error occurred."
        }
        ```

---

### Notes

-   All responses are returned in JSON format.
-   Ensure that the `Authorization` header is included in requests for endpoints that require authentication.
-   The JWT token can be stored in the browser cookies, allowing requests to be made without having to include the token in the header.
-   The API can return generic or specific error messages based on the type of error encountered, helping with debugging and user feedback.

This structured documentation provides clear and organized information about the API endpoints available in the Questivity application, including the data formats for both requests and responses, enhancing usability and understanding for developers.

---

## Overview

The Questivity Server is built using Django, a high-level Python web framework that encourages rapid development and clean, pragmatic design. The main components of the project include:

-   **Main Application (`server`)**: Contains the core functionality and settings of the Django project.
-   **User Management Application (`users`)**: Handles user-related functionalities such as registration, authentication, and profile management.

---

## Project Structure

Here's a breakdown of the main components and their responsibilities within the project:

### `server/`

This directory serves as the main application area containing the core settings and configurations for the Django project. It defines how the application behaves, its routing, and the logic behind handling requests.

---

#### `server/settings.py`

The `settings.py` file is crucial as it houses all the configurations for your Django project. It governs various aspects of the application, ensuring it operates correctly.

-   **DEBUG**: This is a Boolean setting that, when set to `True`, activates debug mode. In production, it should be set to `False` to prevent detailed error messages from being displayed to users, enhancing security.
-   **ALLOWED_HOSTS**: This is a list of strings that specifies which host/domain names the Django application can serve. It prevents HTTP Host header attacks by ensuring that requests are only accepted from authorized domains.

-   **INSTALLED_APPS**: This list includes all the Django applications enabled in this instance, such as built-in applications like the admin interface and external libraries like `jazzmin` (for enhanced admin UI) and `rest_framework` (for building RESTful APIs). Each app here integrates its functionalities into the main project.

-   **DATABASES**: This section contains the configuration for connecting to the MySQL database, detailing parameters like the database name, user credentials, and host. It ensures the application can interact with the database to store and retrieve data.

-   **AUTH_USER_MODEL**: This setting specifies the custom user model to use, which is set to the `User` model defined in the `users` app. This allows the application to leverage the custom attributes and behaviors defined for user management.

-   **CORS settings**: These configurations manage Cross-Origin Resource Sharing (CORS) policies, determining how resources on the server can be accessed by web pages from different origins. Proper CORS settings are essential for allowing safe interactions between different domains.

---

#### `server/urls.py`

The `urls.py` file in the `server` directory is critical for defining the URL routing for the Django application. It connects specific URL paths to their corresponding view functions or classes, effectively mapping incoming requests to the correct handler.

-   **Admin Interface**: The line `path('admin/', admin.site.urls)` establishes the URL path for the Django admin interface. This allows administrators to manage the application’s data and user accounts through a secure, web-based dashboard.

-   **User Management**: The line `path('users/', include('users.urls'))` integrates all URL patterns defined in the `users` application. This modular approach organizes the routing, keeping user-related functionalities separate from other parts of the application. It promotes cleaner code and easier maintenance.

-   **Server View**: The line `path('', ServerView.as_view(), name="Server")` defines the root URL (`/`) of the application, routing it to the `ServerView`. This view responds to requests made to the main URL of the server, providing essential information about the server’s version.

---

#### `server/views.py`

The `views.py` file in the `server` directory encapsulates the view logic for the Questivity application. It defines how the application responds to HTTP requests, particularly those directed to the server root.

-   **APIView**: The `ServerView` class extends `APIView`, a class from Django REST Framework (DRF) that streamlines the process of creating API views. By using this class, developers can easily define how to handle different types of HTTP methods (like GET and POST).

-   **GET Request Handling**: The `get` method in the `ServerView` class is overridden to specify the action taken when a GET request is received at the server’s root URL. Upon receiving a GET request, the method returns a JSON response that includes a simple message indicating the current version of the Questivity server, providing a quick overview of the server's state.

---

### `users/`

This application is dedicated to managing user-related functionalities.

-   **`models.py`**: This file defines the database models related to user data. You can customize the user model here.
-   **`views.py`**: Contains the logic for handling user requests, such as registration and login functionalities.
-   **`urls.py`**: Defines the URL routes for the user-related views.
-   **`forms.py`**: Contains forms for user registration and authentication, making it easy to handle user input.

Sure! Here’s a detailed explanation of each file in the `users` directory, focusing on what the code does without displaying the actual code:

---

#### `users/models.py`

The `models.py` file defines the data structure for the user within the application by creating a custom user model that extends Django's built-in user functionalities.

-   **Custom User Model**: This file defines a class called `User`, which inherits from Django's `AbstractUser`. This inheritance allows for the customization of the user model while retaining all default behaviors of Django's authentication system.
-   **Attributes**:
    -   `username`: A character field that must be unique, which identifies the user.
    -   `password`: A character field to store the user's password.
    -   `is_instructor`: A boolean field that indicates whether the user has instructor privileges. By default, this is set to `False`.
    -   `games_played`: A positive integer field that keeps track of how many games the user has played, starting at `0`.
    -   `experience_level`: Another positive integer that represents the user’s experience level, also starting at `0`.
-   **REQUIRED_FIELDS**: This is an empty list that can be used to specify additional required fields when creating a user via the admin interface.

---

#### `users/serializers.py`

The `serializers.py` file is responsible for transforming complex data types, like the `User` model, into JSON format so it can be easily consumed by clients, as well as validating input data for creating or updating users.

-   **UserSerializer**: This serializer class is defined to handle the serialization of the `User` model. It ensures that user data is converted to and from a format suitable for APIs.
-   **Meta Class**: Within the serializer, the `Meta` class specifies which model to serialize and which fields to include. In this case, fields such as `id`, `username`, `password`, `is_instructor`, `games_played`, and `experience_level` are included.
-   **Password Handling**: The `password` field is marked as `write_only`, meaning it will not be returned in API responses for security reasons. The `create` method in the serializer handles the creation of a new user instance, ensuring that the password is hashed (securely stored) before saving it to the database.

---

#### `users/views.py`

The `views.py` file contains the logic for handling HTTP requests related to user actions like registration, login, viewing user data, and logging out.

-   **RegisterView**: This view manages user registration. When a POST request is made to register a new user, it uses the `UserSerializer` to validate the input data and create a new user in the database. If the registration is successful, it returns a success message and the user data.
-   **LoginView**: This view handles user authentication. When a user attempts to log in, it checks the provided username and password against the database. If the user exists and the password is correct, a JSON Web Token (JWT) is generated. This token serves as an authentication mechanism, and it's sent back to the client as an HTTP-only cookie, enhancing security.

-   **UserView**: This view retrieves the authenticated user's profile information. It decodes the JWT from the cookie to get the user’s ID and fetches their data from the database. This data is then serialized and returned as a response.

-   **LogoutView**: This view handles user logout by deleting the JWT cookie, effectively ending the user's session.

---

#### `users/urls.py`

The `urls.py` file maps URL paths to the corresponding views defined in `views.py`. It establishes the routing of incoming requests.

-   **URL Patterns**: Each path in the `urlpatterns` list corresponds to a specific API endpoint:
    -   `/register/` for user registration.
    -   `/login/` for user login.
    -   `/user/` for retrieving user data.
    -   `/logout/` for logging out the user.

This structure allows the application to handle user-related actions cleanly and efficiently.

---

#### `users/admin.py`

The `admin.py` file customizes how the `User` model appears and behaves in the Django admin interface, making it easier for administrators to manage users.

-   **Custom UserAdmin**: This class extends Django's default user administration interface. It defines which fields are displayed in the user list, what fields can be searched, and how users can be filtered.
-   **Fieldsets**: It organizes the fields into sections, allowing for clear categorization of user attributes. The password field is hashed before being saved, ensuring secure storage.
