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
