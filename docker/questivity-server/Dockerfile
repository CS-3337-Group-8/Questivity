# Use the official Python image from the Docker Hub
FROM python:3.10-slim

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the requirements file from the project root
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code from the src directory
COPY src/ .

# Set the environment variable for Flask
ENV FLASK_APP=app.py

# Expose the port that Flask runs on
EXPOSE 5000

# Command to run the Flask application
CMD ["flask", "run", "--host=0.0.0.0"]
