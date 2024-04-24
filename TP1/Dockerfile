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
