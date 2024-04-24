# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8081 available to the world outside this container
EXPOSE 8081

# Define environment variable
ENV OPENWEATHER_API_KEY=Your_OpenWeather_API_Key_Here

# Run app.py when the container launches
CMD ["flask", "run", "--host=0.0.0.0", "--port=8081"]
