
# TP Météo API

Ce projet consiste à développer une application qui retourne la météo d'un lieu donné à partir de ses coordonnées géographiques. Le projet est packagé dans une image Docker et publié sur DockerHub.

## Étapes pour réaliser le TP

### 1. Clonage du dépôt GitHub

Pour commencer, clonez le dépôt GitHub où vous allez stocker votre code :

Sur vs code faite la commande CTRL SHIFT P et écrir:
```bash
git:clone 
```
Choisir le repository : https://github.com/efrei-ADDA84/20230405-2.git

### 2. Développement du code

J'ai développer un wrapper qui utilise l'API OpenWeather pour récupérer la météo à partir des coordonnées géographique en python:

```python
import os
import requests


# Juste pour débogage
print(f"LATITUDE: {os.environ.get('LATITUDE')}")
print(f"LONGITUDE: {os.environ.get('LONGITUDE')}")
print(f"OPENWEATHER_API_KEY: {os.environ.get('OPENWEATHER_API_KEY')}")

def get_weather():
    # Récupérer la latitude et la longitude depuis les variables d'environnement
    latitude = os.environ.get('LATITUDE')
    longitude = os.environ.get('LONGITUDE')
    api_key = os.environ.get('OPENWEATHER_API_KEY')

    # Construire l'URL pour la requête à l'API OpenWeather
    url = f"http://api.openweathermap.org/data/2.5/weather?lat={latitude}&lon={longitude}&appid={api_key}&units=metric&lang=fr"

    # Faire la requête à l'API
    response = requests.get(url)

    # Vérifier que la requête a réussi
    if response.status_code == 200:
        # Convertir la réponse en JSON et l'imprimer
        weather_data = response.json()
        print(f"Météo actuelle pour {weather_data['name']}: {weather_data['weather'][0]['description']}. Température: {weather_data['main']['temp']}°C.")    
    else:
        print("Erreur lors de la récupération de la météo. Statut de la réponse :", response.status_code)
        try:
            error_details = response.json()
            print("Détails de l'erreur :", error_details)
        except Exception as e:
            print("Impossible de décoder les détails de l'erreur :", e)




if __name__ == "__main__":
    get_weather()

```

Pour le tester il faut definir des variables d'environnement, par exemple: 


```bash
$env:OPENWEATHER_API_KEY="5a3638a1fe348edbce720562c4d4c0cc"
$env:LATITUDE=12
$env:LONGITUDE=12

```

Puis ecrire run le fichier:

```output
LATITUDE: 12
LONGITUDE: 12
OPENWEATHER_API_KEY: 5a3638a1fe348edbce720562c4d4c0cc
Météo actuelle pour Damaturu: ciel dégagé. Température: 43.11°C.
```

![image](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/3c351b5a-582d-4a2d-a9cf-d9b212bbc855)


### 3. Création du Dockerfile

Création d'un Dockerfile pour construire votre image Docker :

```Dockerfile
# Utiliser une image de base Python officielle.
FROM python:3.9-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier de dépendances et installer les dépendances
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le script Python dans le conteneur
COPY weather_wrapper2.py .

# Commande pour exécuter le script Python
CMD ["python", "./weather_wrapper2.py"]

```

### 4. Construction de l'image Docker

Construisez votre image Docker avec la commande suivante :

```bash
docker build -t magattee/weather-app2 .
```

### 5. Test de l'image

Testez l'image localement :

```bash
docker run -e LATITUDE=40.7128 -e LONGITUDE=-74.0060 -e OPENWEATHER_API_KEY=5a3638a1fe348edbce720562c4d4c0cc weather-app2
```
![image](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/61b3bf61-af6b-429b-97c2-0e2e0f22944c)

### 6. Publication sur DockerHub

Connectez-vous à DockerHub et publiez votre image :

```bash
docker login
docker push magattee/weather-wrapper2
```

### 7. Mise à jour du dépôt GitHub

Commit depuis vscode

## Conclusion

Après avoir suivi ces étapes, votre application devrait être fonctionnelle et accessible sur DockerHub. Assurez-vous de vérifier la validité de l'API Key et des coordonnées passées en variables d'environnement.
