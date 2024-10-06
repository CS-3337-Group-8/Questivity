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

// Endpoint to get greetings
app.get("/greetings", (req, res) => {
    connection.query("SELECT message FROM greetings", (error, results) => {
        if (error) return res.status(500).send(error)
        res.json(results)
    })
})

// Endpoint to post a greeting
app.post("/greetings", (req, res) => {
    const message = req.body.message
    connection.query("INSERT INTO greetings (message) VALUES (?)", [message], (error) => {
        if (error) return res.status(500).send(error)
        res.status(201).send("Message added")
    })
})

// Start the server
app.listen(port, () => {
    console.log(`API running at http://localhost:${port}`)
})
