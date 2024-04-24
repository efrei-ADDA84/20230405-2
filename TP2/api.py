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

