document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("greetingForm")
    const greetingsList = document.getElementById("greetingsList")

    // Function to fetch greetings
    async function fetchGreetings() {
        const response = await fetch("http://localhost:4000/greetings")
        const greetings = await response.json()
        greetingsList.innerHTML = ""
        greetings.forEach((greeting) => {
            const li = document.createElement("li")
            li.textContent = greeting.message
            greetingsList.appendChild(li)
        })
    }

    // Fetch greetings on page load
    fetchGreetings()

    // Handle form submission
    form.addEventListener("submit", async function (event) {
        event.preventDefault()
        const message = document.getElementById("message").value
        await fetch("http://localhost:4000/greetings", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ message }),
        })
        document.getElementById("message").value = ""
        fetchGreetings() // Refresh greetings
    })
})
