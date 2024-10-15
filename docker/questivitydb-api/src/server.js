const express = require("express")
const cors = require("cors")
const routes = require("./routes")
const connection = require("./db")

const app = express()
const port = process.env.PORT || 4000

const validApiKeys = new Set([process.env.API_KEY])

const apiKeyAuth = (req, res, next) => {
    const apiKey = req.headers["x-api-key"]
    if (!apiKey || !validApiKeys.has(apiKey)) {
        return res.status(401).json({ message: "Unauthorized" })
    }
    next()
}

const requestLogger = (req, res, next) => {
    const now = new Date()
    console.log(`${now.toISOString()} - ${req.method} ${req.url}`)
    next()
}

app.use(cors())
app.use(express.json())
//app.use(apiKeyAuth)
app.use(requestLogger)
app.use("/", routes)

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`)
})
