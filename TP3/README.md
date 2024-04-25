
# TP 3

Ce projet consiste à prendre l'image docker de l'api du tp2 en la mettant dans un conteneur sur azure, via un workflow
## Étapes pour réaliser le TP

### 1. Clonage du dépôt GitHub

Pour commencer, clonez le dépôt GitHub où vous allez stocker votre code :

Sur vs code faite la commande CTRL SHIFT P et écrir:
```bash
git:clone 
```
Choisir le repository : https://github.com/efrei-ADDA84/20230405-2.git

### 2. Développement du flux

J'ai développer un flux github pour créer ma vm:

```python
name: docker build azure

on: 
  push: 
    branches: 
      - main 

jobs: 
  build-and-push: 
    runs-on: ubuntu-latest 
    steps: 
    - uses: actions/checkout@v2 

    - name: Set up Docker Buildx  
      uses: docker/setup-buildx-action@v1

    - name: Log in to Azure Container Registry 
      uses: docker/login-action@v1
      with: 
        registry: ${{ secrets.REGISTRY_LOGIN_SERVER }}
        username: ${{ secrets.REGISTRY_USERNAME }}
        password: ${{ secrets.REGISTRY_PASSWORD }}

    - name: Build and push Docker image to ACR
      uses: docker/build-push-action@v2
      with: 
        context: . 
        file: ./TP2/Dockerfile 
        push: true 
        tags: ${{ secrets.REGISTRY_LOGIN_SERVER }}/weather-wrapper-api:latest
    # - name: Run Hadolint 
    #   uses: hadolint/hadolint-action@v1.6.0
    #   with:
    #     dockerfile: Dockerfile
        
  deploy: 
    needs: build-and-push 
    runs-on: ubuntu-latest 
    steps: 
    - name: Checkout code 
      uses: actions/checkout@v2

    - name: 'Login via Azure CLI' 
      uses: azure/login@v1
      with: 
        creds: ${{ secrets.AZURE_CREDENTIALS }}

    - name: 'Deploy to Azure Container Instance' 
      uses: azure/aci-deploy@v1
      with: 
        resource-group: "ADDA84-CTP" 
        dns-name-label: "devops-20230405"
        image: ${{ secrets.REGISTRY_LOGIN_SERVER }}/weather-wrapper-api:latest
        name: "20230405"
        location: "germanynorth" 
        registry-login-server: ${{ secrets.REGISTRY_LOGIN_SERVER }} 
        registry-username: ${{ secrets.REGISTRY_USERNAME }} 
        registry-password: ${{ secrets.REGISTRY_PASSWORD }} 
        secure-environment-variables: API_KEY=${{ secrets.API_KEY }}

```

![Capture d'écran 2024-04-24 174902](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/bce4b242-6644-47e1-8950-f4ee078e654b)






### 3. Difficultés rencontrées

J'ai essayé de curl pour tester le conteneur mais j'ai toujours eu ces erreurs, maklgré les changements effectuées:

![WhatsApp Image 2024-04-24 à 22 41 10_ff9e8bfc](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/f59322a4-bc43-447a-9904-907d13fd80cb)

Pourtant le ping fonctionnait:

  
  ![WhatsApp Image 2024-04-24 à 22 38 23_bf8fb004](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/4e7c55a3-af23-419b-92d3-590f514846d4)

je n'ai pas pu trouver l'origine du problème.
