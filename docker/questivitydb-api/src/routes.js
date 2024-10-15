const express = require("express")
const router = express.Router()
const connection = require("./db")

const query = (res, sql, params = []) => {
    connection.query(sql, params, (error, results) => {
        if (error) {
            console.error("Database query error:", error)
            if (error.code === "ECONNREFUSED") {
                return res
                    .status(503)
                    .json({ error: "Database connection refused. Please try again later." })
            }
            return res
                .status(500)
                .json({ error: `An error occurred while querying the database: ${error.message}` })
        }

        if (sql.trim().toLowerCase().startsWith("select")) {
            if (results.length === 0) {
                return res.status(404).json({ error: "No results found" })
            }
            return res.status(200).json(results)
        }

        if (sql.trim().toLowerCase().startsWith("insert")) {
            return res
                .status(201)
                .json({ message: "Record created successfully", id: results.insertId })
        }

        if (sql.trim().toLowerCase().startsWith("update")) {
            if (results.affectedRows === 0) {
                return res.status(404).json({ error: "No record found to update" })
            }
            return res.status(200).json({ message: "Record updated successfully" })
        }

        if (sql.trim().toLowerCase().startsWith("delete")) {
            if (results.affectedRows === 0) {
                return res.status(404).json({ error: "No record found to delete" })
            }
            return res.status(200).json({ message: "Record deleted successfully" })
        }

        res.status(200).json(results)
    })
}

router.get("/", (req, res) => {
    res.send("QuestivityDB API Version 1.0")
})

// Users
router.get("/users", (req, res) => {
    query(res, "SELECT * FROM users")
})

router.post("/users", (req, res) => {
    const sql =
        "INSERT INTO users (name, username, password_hash, is_instructor) VALUES (?, ?, ?, ?)"
    query(res, sql, [
        req.body.name,
        req.body.username,
        req.body.password_hash,
        req.body.is_instructor,
    ])
})

router.get("/users/by-username/:username", (req, res) => {
    const sql = "SELECT * FROM users WHERE username = ?"
    query(res, sql, [req.params.username])
})

router.get("/users/instructors", (req, res) => {
    query(res, "SELECT * FROM users WHERE is_instructor = 1")
})

router.get("/users/students", (req, res) => {
    query(res, "SELECT * FROM users WHERE is_instructor = 0")
})

router.get("/users/:user_id", (req, res) => {
    query(res, "SELECT * FROM users WHERE user_id = ?", [req.params.user_id])
})

router.put("/users/:user_id", (req, res) => {
    const userId = req.params.user_id
    const updates = {}

    if (req.body.name !== undefined) updates.name = req.body.name
    if (req.body.username !== undefined) updates.username = req.body.username
    if (req.body.password_hash !== undefined) updates.password_hash = req.body.password_hash
    if (req.body.is_instructor !== undefined) updates.is_instructor = req.body.is_instructor
    if (req.body.games_played !== undefined) updates.games_played = req.body.games_played
    if (req.body.experience_level !== undefined)
        updates.experience_level = req.body.experience_level

    if (Object.keys(updates).length === 0) {
        return res.status(400).json({ error: "No fields provided to update" })
    }

    const sql = `UPDATE users SET ${Object.keys(updates)
        .map((key) => `${key} = ?`)
        .join(", ")} WHERE user_id = ?`
    const params = [...Object.values(updates), userId]

    query(res, sql, params)
})

router.delete("/users/:user_id", (req, res) => {
    query(res, "DELETE FROM users WHERE user_id = ?", [req.params.user_id])
})

router.get("/users/:user_id/scores", (req, res) => {
    query(res, "SELECT * FROM scores WHERE user_id = ?", [req.params.user_id])
})

router.get("/users/:user_id/courses", (req, res) => {
    query(
        res,
        `
        SELECT c.* FROM courses c
        JOIN student_courses sc ON c.course_id = sc.course_id
        WHERE sc.user_id = ?;
    `,
        [req.params.user_id]
    )
})

router.get("/users/:user_id/achievements", (req, res) => {
    query(
        res,
        `
        SELECT a.* FROM achievements a
        JOIN user_achievements ua ON a.achievement_id = ua.achievement_id
        WHERE ua.user_id = ?;
    `,
        [req.params.user_id]
    )
})

router.get("/users/:user_id/progress", (req, res) => {
    query(
        res,
        `
        SELECT course_id, progress_score FROM user_progress
        WHERE user_id = ?;
    `,
        [req.params.user_id]
    )
})

router.get("/users/:user_id/progress/:course_id", (req, res) => {
    query(
        res,
        `
        SELECT progress_score FROM user_progress
        WHERE user_id = ? AND course_id = ?;
    `,
        [req.params.user_id, req.params.course_id]
    )
})

// Courses
router.get("/courses", (req, res) => {
    query(res, "SELECT * FROM courses")
})

router.post("/courses", (req, res) => {
    const sql = "INSERT INTO courses (name) VALUES (?)"
    query(res, sql, [req.body.name])
})

router.get("/courses/:course_id", (req, res) => {
    query(res, "SELECT * FROM courses WHERE course_id = ?", [req.params.course_id])
})

router.put("/courses/:course_id", (req, res) => {
    const courseId = req.params.course_id
    const updates = {}

    if (req.body.name !== undefined) {
        updates.name = req.body.name
    }

    if (req.body.code !== undefined) {
        updates.code = req.body.code
    }

    if (Object.keys(updates).length === 0) {
        return res.status(400).json({ error: "No fields provided to update" })
    }

    const sql = `UPDATE courses SET ${Object.keys(updates)
        .map((key) => `${key} = ?`)
        .join(", ")} WHERE course_id = ?`
    const params = [...Object.values(updates), courseId]

    query(res, sql, params)
})

router.delete("/courses/:course_id", (req, res) => {
    query(res, "DELETE FROM courses WHERE course_id = ?", [req.params.course_id])
})

router.get("/courses/:course_id/scores", (req, res) => {
    query(res, "SELECT * FROM scores WHERE course_id = ?", [req.params.course_id])
})

router.get("/courses/:course_id/students", (req, res) => {
    query(
        res,
        `
        SELECT u.* FROM users u
        JOIN student_courses sc ON u.user_id = sc.user_id
        WHERE sc.course_id = ?;
    `,
        [req.params.course_id]
    )
})

router.get("/courses/:course_id/students/progress", (req, res) => {
    query(
        res,
        `
        SELECT u.*, up.* FROM users u
        JOIN user_progress up ON u.user_id = up.user_id
        WHERE up.course_id = ?;
    `,
        [req.params.course_id]
    )
})

router.get("/courses/:course_id/instructors", (req, res) => {
    query(
        res,
        `
        SELECT u.* FROM users u
        JOIN instructor_courses ic ON u.user_id = ic.user_id
        WHERE ic.course_id = ?;
    `,
        [req.params.course_id]
    )
})

// Achievements
router.get("/achievements", (req, res) => {
    query(res, "SELECT * FROM achievements")
})

router.post("/achievements", (req, res) => {
    const sql = "INSERT INTO achievements (name, image, description) VALUES (?, ?, ?)"
    query(res, sql, [req.body.name, req.body.image, req.body.description])
})

router.get("/achievements/:achievement_id", (req, res) => {
    query(res, "SELECT * FROM achievements WHERE achievement_id = ?", [req.params.achievement_id])
})

router.put("/achievements/:achievement_id", (req, res) => {
    const achievementId = req.params.achievement_id
    const updates = {}

    if (req.body.name !== undefined) {
        updates.name = req.body.name
    }
    if (req.body.image !== undefined) {
        updates.image = req.body.image
    }
    if (req.body.description !== undefined) {
        updates.description = req.body.description
    }

    if (Object.keys(updates).length === 0) {
        return res.status(400).json({ error: "No fields provided to update" })
    }

    const sql = `UPDATE achievements SET ${Object.keys(updates)
        .map((key) => `${key} = ?`)
        .join(", ")} WHERE achievement_id = ?`
    const params = [...Object.values(updates), achievementId]

    query(res, sql, params)
})

router.delete("/achievements/:achievement_id", (req, res) => {
    query(res, "DELETE FROM achievements WHERE achievement_id = ?", [req.params.achievement_id])
})

// Scores
router.get("/scores", (req, res) => {
    query(res, "SELECT * FROM scores")
})

router.post("/scores", (req, res) => {
    const sql = "INSERT INTO scores (user_id, course_id , game_id, score) VALUES (?, ?, ?, ?)"
    query(res, sql, [req.body.user_id, req.body.course_id, req.body.game_id, req.body.score])
})

router.get("/scores/:score_id", (req, res) => {
    query(res, "SELECT * FROM scores WHERE score_id = ?", [req.params.score_id])
})

router.put("/scores/:score_id", (req, res) => {
    const scoreId = req.params.score_id
    const updates = {}

    if (req.body.score !== undefined) {
        updates.score = req.body.score
    }

    if (Object.keys(updates).length === 0) {
        return res.status(400).json({ error: "No fields provided to update" })
    }

    const sql = `UPDATE scores SET ${Object.keys(updates)
        .map((key) => `${key} = ?`)
        .join(", ")} WHERE score_id = ?`
    const params = [...Object.values(updates), scoreId]

    query(res, sql, params)
})

router.delete("/scores/:score_id", (req, res) => {
    query(res, "DELETE FROM scores WHERE score_id = ?", [req.params.score_id])
})

// User Progress
router.get("/user-progress", (req, res) => {
    query(res, "SELECT * FROM user_progress")
})

router.post("/user-progress", (req, res) => {
    const sql = "INSERT INTO user_progress (user_id, course_id) VALUES (?, ?)"
    query(res, sql, [req.body.user_id, req.body.course_id])
})

router.delete("/user-progress", (req, res) => {
    query(res, "DELETE FROM user_progress WHERE user_id = ? AND course_id = ?", [
        req.body.user_id,
        req.body.course_id,
    ])
})

// Student Courses
router.get("/student-courses", (req, res) => {
    query(res, "SELECT * FROM student_courses")
})

router.post("/student-courses", (req, res) => {
    const sql = "INSERT INTO student_courses (user_id, course_id) VALUES (?, ?)"
    query(res, sql, [req.body.user_id, req.body.course_id])
})

router.delete("/student-courses", (req, res) => {
    query(res, "DELETE FROM student_courses WHERE user_id = ? AND course_id = ?", [
        req.body.user_id,
        req.body.course_id,
    ])
})

// Instructor Courses
router.get("/instructor-courses", (req, res) => {
    query(res, "SELECT * FROM instructor_courses")
})

router.post("/instructor-courses", (req, res) => {
    const sql = "INSERT INTO instructor_courses (user_id, course_id) VALUES (?, ?)"
    query(res, sql, [req.body.user_id, req.body.course_id])
})

router.delete("/instructor-courses", (req, res) => {
    query(res, "DELETE FROM instructor_courses WHERE user_id = ? AND course_id = ?", [
        req.body.user_id,
        req.body.course_id,
    ])
})

// User-Achievements
router.get("/user-achievements", (req, res) => {
    query(res, "SELECT * FROM user_achievements")
})

router.post("/user-achievements", (req, res) => {
    const sql = "INSERT INTO user_achievements (user_id, achievement_id) VALUES (?, ?)"
    query(res, sql, [req.body.user_id, req.body.achievement_id])
})

router.delete("/user-achievements", (req, res) => {
    query(res, "DELETE FROM user_achievements WHERE user_id = ? AND achievement_id = ?", [
        req.body.user_id,
        req.body.achievement_id,
    ])
})

module.exports = router
