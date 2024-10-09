const express = require("express")
const mysql = require("mysql2")
const bodyParser = require("body-parser")
const cors = require("cors")

const app = express()
const port = 3000

// Middleware
app.use(cors())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

// Database connection
const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
})

connection.connect((err) => {
    if (err) throw err
    console.log("Connected to MySQL Database")
})

// Root endpoint
app.get("/", (req, res) => {
    res.send("Welcome to the API! Use the endpoints to interact with the database.")
})

// Accounts endpoints
app.get("/accounts", (req, res) => {
    connection.query("SELECT * FROM Accounts", (error, results) => {
        if (error) return res.status(500).send(error)
        res.json(results)
    })
})

app.post("/accounts", (req, res) => {
    const { username, password_hash, is_instructor } = req.body
    connection.query(
        "INSERT INTO Accounts (username, password_hash, is_instructor) VALUES (?, ?, ?)",
        [username, password_hash, is_instructor],
        (error) => {
            if (error) return res.status(500).send(error)
            res.status(201).send("Account created")
        }
    )
})

app.put("/accounts/:user_id", (req, res) => {
    const { user_id } = req.params
    const { username, password_hash, is_instructor } = req.body
    connection.query(
        "UPDATE Accounts SET username = ?, password_hash = ?, is_instructor = ? WHERE user_id = ?",
        [username, password_hash, is_instructor, user_id],
        (error) => {
            if (error) return res.status(500).send(error)
            res.send("Account updated")
        }
    )
})

app.delete("/accounts/:user_id", (req, res) => {
    const { user_id } = req.params
    connection.query("DELETE FROM Accounts WHERE user_id = ?", [user_id], (error) => {
        if (error) return res.status(500).send(error)
        res.send("Account deleted")
    })
})

// Courses endpoints
app.get("/courses", (req, res) => {
    connection.query("SELECT * FROM Courses", (error, results) => {
        if (error) return res.status(500).send(error)
        res.json(results)
    })
})

app.post("/courses", (req, res) => {
    const { name, temporary_course_code } = req.body
    connection.query(
        "INSERT INTO Courses (name, temporary_course_code) VALUES (?, ?)",
        [name, temporary_course_code],
        (error) => {
            if (error) return res.status(500).send(error)
            res.status(201).send("Course created")
        }
    )
})

app.put("/courses/:course_id", (req, res) => {
    const { course_id } = req.params
    const { name, temporary_course_code } = req.body
    connection.query(
        "UPDATE Courses SET name = ?, temporary_course_code = ? WHERE course_id = ?",
        [name, temporary_course_code, course_id],
        (error) => {
            if (error) return res.status(500).send(error)
            res.send("Course updated")
        }
    )
})

app.delete("/courses/:course_id", (req, res) => {
    const { course_id } = req.params
    connection.query("DELETE FROM Courses WHERE course_id = ?", [course_id], (error) => {
        if (error) return res.status(500).send(error)
        res.send("Course deleted")
    })
})

// Achievements endpoints
app.get("/achievements", (req, res) => {
    connection.query("SELECT * FROM Achievements", (error, results) => {
        if (error) return res.status(500).send(error)
        res.json(results)
    })
})

app.post("/achievements", (req, res) => {
    const { achievement_image, name, description } = req.body
    connection.query(
        "INSERT INTO Achievements (achievement_image, name, description) VALUES (?, ?, ?)",
        [achievement_image, name, description],
        (error) => {
            if (error) return res.status(500).send(error)
            res.status(201).send("Achievement created")
        }
    )
})

app.put("/achievements/:achievement_id", (req, res) => {
    const { achievement_id } = req.params
    const { achievement_image, name, description } = req.body
    connection.query(
        "UPDATE Achievements SET achievement_image = ?, name = ?, description = ? WHERE achievement_id = ?",
        [achievement_image, name, description, achievement_id],
        (error) => {
            if (error) return res.status(500).send(error)
            res.send("Achievement updated")
        }
    )
})

app.delete("/achievements/:achievement_id", (req, res) => {
    const { achievement_id } = req.params
    connection.query(
        "DELETE FROM Achievements WHERE achievement_id = ?",
        [achievement_id],
        (error) => {
            if (error) return res.status(500).send(error)
            res.send("Achievement deleted")
        }
    )
})

// Game Scores endpoints
app.get("/game_scores", (req, res) => {
    connection.query("SELECT * FROM Game_Scores", (error, results) => {
        if (error) return res.status(500).send(error)
        res.json(results)
    })
})

app.post("/game_scores", (req, res) => {
    const { course_id, user_id, game_id } = req.body
    connection.query(
        "INSERT INTO Game_Scores (course_id, user_id, game_id) VALUES (?, ?, ?)",
        [course_id, user_id, game_id],
        (error) => {
            if (error) return res.status(500).send(error)
            res.status(201).send("Game score created")
        }
    )
})

app.put("/game_scores/:score_id", (req, res) => {
    const { score_id } = req.params
    const { course_id, user_id, game_id } = req.body
    connection.query(
        "UPDATE Game_Scores SET course_id = ?, user_id = ?, game_id = ? WHERE score_id = ?",
        [course_id, user_id, game_id, score_id],
        (error) => {
            if (error) return res.status(500).send(error)
            res.send("Game score updated")
        }
    )
})

app.delete("/game_scores/:score_id", (req, res) => {
    const { score_id } = req.params
    connection.query("DELETE FROM Game_Scores WHERE score_id = ?", [score_id], (error) => {
        if (error) return res.status(500).send(error)
        res.send("Game score deleted")
    })
})

// Starting the server
app.listen(port, () => {
    console.log(`API running at http://localhost:${port}`)
})
