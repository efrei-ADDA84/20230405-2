
# TP Météo API

Ce projet consiste à développer une application qui retourne la météo d'un lieu donné à partir de ses coordonnées géographiques. Le projet est packagé dans une image Docker et publié sur DockerHub.

## Étapes pour réaliser le TP

### 1. Clonage du dépôt GitHub

Pour commencer, clonez le dépôt GitHub où vous allez stocker votre code :

```bash
git clone https://github.com/votre_username/tp-meteo.git
cd tp-meteo
```

### 2. Développement du code

Développez un wrapper qui utilise l'API OpenWeather pour récupérer la météo à partir des coordonnées géographiques. Le langage de programmation est à votre choix. Voici un exemple de structure du code :

```python
import requests
import os

def get_weather(lat, lon, api_key):
    url = f"http://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={api_key}"
    response = requests.get(url)
    return response.json()

if __name__ == "__main__":
    lat = os.getenv("LAT")
    lon = os.getenv("LONG")
    api_key = os.getenv("API_KEY")
    weather_data = get_weather(lat, lon, api_key)
    print(weather_data)
```

### 3. Création du Dockerfile

Créez un Dockerfile pour construire votre image Docker :

```Dockerfile
FROM python:3.8-slim
WORKDIR /app
COPY . /app
RUN pip install requests
CMD ["python", "app.py"]
```

### 4. Construction de l'image Docker

Construisez votre image Docker avec la commande suivante :

```bash
docker build -t votre_username_dockerhub/tp-meteo .
```

### 5. Test de l'image

Testez l'image localement :

```bash
docker run --env LAT="48.8566" --env LONG="2.3522" --env API_KEY="votre_cle_api" votre_username_dockerhub/tp-meteo
```

### 6. Publication sur DockerHub

Connectez-vous à DockerHub et publiez votre image :

```bash
docker login
docker push votre_username_dockerhub/tp-meteo
```

### 7. Mise à jour du dépôt GitHub

Publiez votre code sur GitHub :

```bash
git add .
git commit -m "Initial commit"
git push origin master
```

## Conclusion

Après avoir suivi ces étapes, votre application devrait être fonctionnelle et accessible sur DockerHub. Assurez-vous de vérifier la validité de l'API Key et des coordonnées passées en variables d'environnement.
