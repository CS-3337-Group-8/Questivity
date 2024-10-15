# QuestivityDB API Documentation

## Version 1.0

The QuestivityDB API provides endpoints for managing users, courses, achievements, scores, user progress, and relationships between these entities.

---

## Base URL

```
api.{your-domain}/db/

```

## Endpoints Overview

### Users

-   **GET /users** - Retrieve all users
-   **POST /users** - Create a new user
-   **GET /users/instructors** - Retrieve all instructors
-   **GET /users/by-username/:user_name** - Retrieve progress by username
-   **GET /users/students** - Retrieve all students
-   **GET /users/:user_id** - Retrieve a specific user by ID
-   **PUT /users/:user_id** - Update a specific user by ID
-   **DELETE /users/:user_id** - Delete a specific user by ID
-   **GET /users/:user_id/scores** - Retrieve scores for a specific user
-   **GET /users/:user_id/courses** - Retrieve courses for a specific user
-   **GET /users/:user_id/achievements** - Retrieve achievements for a specific user
-   **GET /users/:user_id/progress** - Retrieve progress for a specific user
-   **GET /users/:user_id/progress/:course_id** - Retrieve progress for a specific course for a user

### Courses

-   **GET /courses** - Retrieve all courses
-   **POST /courses** - Create a new course
-   **GET /courses/:course_id** - Retrieve a specific course by ID
-   **PUT /courses/:course_id** - Update a specific course by ID
-   **DELETE /courses/:course_id** - Delete a specific course by ID
-   **GET /courses/:course_id/scores** - Retrieve scores for a specific course
-   **GET /courses/:course_id/students** - Retrieve students enrolled in a specific course
-   **GET /courses/:course_id/students/progress** - Retrieve progress of students in a specific course
-   **GET /courses/:course_id/instructors** - Retrieve instructors for a specific course

### Achievements

-   **GET /achievements** - Retrieve all achievements
-   **POST /achievements** - Create a new achievement
-   **GET /achievements/:achievement_id** - Retrieve a specific achievement by ID
-   **PUT /achievements/:achievement_id** - Update a specific achievement by ID
-   **DELETE /achievements/:achievement_id** - Delete a specific achievement by ID

### Scores

-   **GET /scores** - Retrieve all scores
-   **POST /scores** - Create a new score entry
-   **GET /scores/:score_id** - Retrieve a specific score by ID
-   **PUT /scores/:score_id** - Update a specific score by ID
-   **DELETE /scores/:score_id** - Delete a specific score by ID

### User Progress

-   **GET /user-progress** - Retrieve all user progress entries
-   **POST /user-progress** - Create a new user progress entry
-   **DELETE /user-progress** - Delete a specific user progress entry

### Student Courses

-   **GET /student-courses** - Retrieve all student courses
-   **POST /student-courses** - Enroll a student in a course
-   **DELETE /student-courses** - Unenroll a student from a course

### Instructor Courses

-   **GET /instructor-courses** - Retrieve all instructor courses
-   **POST /instructor-courses** - Assign a course to an instructor
-   **DELETE /instructor-courses** - Remove an instructor from a course

### User-Achievements

-   **GET /user-achievements** - Retrieve all user achievements
-   **POST /user-achievements** - Assign an achievement to a user
-   **DELETE /user-achievements** - Remove an achievement from a user

---

## Request and Response Formats

### Request Format

All requests that modify data (POST, PUT, DELETE) should include the `Content-Type: application/json` header and a JSON body. Example:

```json
{
    "name": "John Doe",
    "username": "johndoe",
    "password_hash": "hashedpassword",
    "is_instructor": false
}
```

### Response Format

Responses will be in JSON format. On success, responses typically include the result of the query. In the event of an error, a JSON object with an error message will be returned.

Example Success Response:

```json
{
    "message": "Record created successfully",
    "id": 1
}
```

Example Error Response:

```json
{
    "error": "No results found"
}
```

---

## Error Handling

The API provides structured error responses based on different types of failures:

-   **503 Service Unavailable** - Database connection issues.
-   **404 Not Found** - No records found for the provided identifier.
-   **400 Bad Request** - No fields provided to update or invalid data.
-   **500 Internal Server Error** - General database query errors.

---

## Example Usage

### Get All Users

**Request:**

```
GET /api/users
```

**Response:**

```json
[
    {
        "user_id": 1,
        "name": "John Doe",
        "username": "johndoe",
        "is_instructor": false
    },
    ...
]
```

### Create a New User

**Request:**

```
POST /api/users
Content-Type: application/json

{
    "name": "Jane Smith",
    "username": "janesmith",
    "password_hash": "hashedpassword",
    "is_instructor": true
}
```

**Response:**

```json
{
    "message": "Record created successfully",
    "id": 2
}
```
