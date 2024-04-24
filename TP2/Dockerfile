# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install flask
RUN pip install requests
RUN pip install python-dotenv

# Make port 8081 available to the world outside this container
EXPOSE 8081

# Define the Flask application
ENV FLASK_APP=api.py

# Run app.py when the container launches
CMD ["flask", "run", "--host=0.0.0.0", "--port=8081"]
