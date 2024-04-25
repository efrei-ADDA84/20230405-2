
# TP 2

Ce projet consiste à reprendre le TP1 pour l'utiliser sous forme d'api, puis d'utiliser un workflow github
## Étapes pour réaliser le TP

### 1. Clonage du dépôt GitHub

Pour commencer, clonez le dépôt GitHub où vous allez stocker votre code :

Sur vs code faite la commande CTRL SHIFT P et écrir:
```bash
git:clone 
```
Choisir le repository : https://github.com/efrei-ADDA84/20230405-2.git

### 2. Développement du code

J'ai développer une api qui utilise l'API OpenWeather pour récupérer la météo à partir des coordonnées géographique en python:

```python
from flask import Flask, request, jsonify
import os
from dotenv import load_dotenv
import requests

app = Flask(__name__)
load_dotenv() 

@app.route('/')
def get_weather():
    latitude = request.args.get('latitude')
    longitude = request.args.get('longitude')
    api_key = os.environ.get('OPENWEATHER_API_KEY')

    print("Received latitude:", latitude)
    print("Received longitude:", longitude)
    print("API Key:", api_key)

    if not all([latitude, longitude, api_key]):
        return jsonify({"error": "Missing required parameters"}), 400

    url = f"https://api.openweathermap.org/data/2.5/weather?lat={latitude}&lon={longitude}&appid={api_key}&units=metric&lang=fr"
    print("Requesting URL:", url)
    response = requests.get(url)

    if response.status_code == 200:
        weather_data = response.json()
        return jsonify({
            "location": weather_data['name'],
            "description": weather_data['weather'][0]['description'],
            "temperature": weather_data['main']['temp']
        })
    else:
        return jsonify({"error": "Failed to retrieve weather data"}), response.status_code


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8081)



```

Pour le tester il faut definir des variables d'environnement, par exemple: 


```bash
$env:OPENWEATHER_API_KEY="5a3638a1fe348edbce720562c4d4c0cc"

```

Puis ecrire run le fichier:

![Capture d'écran 2024-04-24 130522](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/b399badf-c503-446f-a64a-886477b2d11f)


on peut ensuite faire un curl ou une recherche sur internet pour tester:

![Capture d'écran 2024-04-24 154421](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/1fd6cf14-aaa3-47b0-81e1-701291e06a6b)


### 3. Création du Dockerfile

Création d'un Dockerfile pour construire votre image Docker :

```Dockerfile
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

```

### 4. Construction de l'image Docker

Construisez votre image Docker avec la commande suivante :

```bash
docker build -t magattee/weather-wrapper-api.
```

### 5. Test de l'image

Testez l'image localement :

```bash
docker run -p 8081:8081 weather-app-api
```
![Capture d'écran 2024-04-24 154433](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/f3edb58d-4139-4ea7-8d64-607ce6057cc2)


### 6. Publication sur DockerHub

Connectez-vous à DockerHub et publiez votre image :

```bash
docker login
docker push magattee/weather-wrapper-api
```

### 7. Créer un workflow pour mettre à jour l'image:

```bash
name: Docker Image CI

on:
  push:
    branches: [ main ]

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
    - name: Check out the repository
      uses: actions/checkout@v2

    - name: Log in to Docker Hub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Build and push Docker image
      uses: docker/build-push-action@v2
      with:
        context: .
        file: ./TP2/Dockerfile
        push: true
        tags: magattee/weather-app-api:latest

```
![image](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/8917829e-dba9-4276-8738-8669e27ee3ee)


### 8. Mise à jour du dépôt GitHub

Commit depuis vscode

## Conclusion

Après avoir suivi ces étapes, votre application devrait être fonctionnelle et accessible sur DockerHub. Assurez-vous de vérifier la validité de l'API Key.
