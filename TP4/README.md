
# TP 4

## Étapes pour réaliser le TP

### 1. Clonage du dépôt GitHub

Pour commencer, clonez le dépôt GitHub où vous allez stocker votre code :

Sur vs code faite la commande CTRL SHIFT P et écrir:
```bash
git:clone 
```
Choisir le repository : https://github.com/efrei-ADDA84/20230405-2.git

### 2. Développement du code

J'ai développer 6 fichiers: Main.tf network.tf terraform.tfvars variable.tf docker.yml et vm.tf




### 3. Commandes terraform


```
terraform fmt
```
```
terraform init
```
```
terraform validate
```
```
terraform plan
```
```
terraform apply
```

![Capture d'écran 2024-04-25 161629](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/8a9e5eac-1280-4818-b91d-205e613936f9)

### 4. TEST

Je n'ai pas réussi à executer la commande ssh -i id_rsa devops@{PUBLIC_ADDRESS_IP} cat /etc/os-release car j'avais un problème avec la clé id_rsa j'ai donc rajouter cette partie de code dans vm.tf pour avoir accès à la clé ssh:

```bash
resource "local_file" "private_key" {
  sensitive_content = tls_private_key.ssh_key.private_key_pem
  filename          = "C:/Users/magatte.ba/.ssh/devops_ssh_key.pem"
  file_permission   = "0600"
}

```
puis ensuite: 

```bash
ssh -i C:/Users/magatte.ba/.ssh/devops_ssh_key.pem devops@52.143.182.205 cat /etc/os-release
```

![Capture d'écran 2024-04-25 163257](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/76eab7c4-c2bc-48d5-9a04-578dea3c01ad)

Testez l'installation de docker :

```bash
ssh -v -i C:/Users/magatte.ba/.ssh/devops_ssh_key.pem devops@52.143.182.205 cat /etc/os-release
```
![Capture d'écran 2024-04-25 163444](https://github.com/efrei-ADDA84/20230405-2/assets/154382359/a29691e7-6287-4c93-b734-b59a4b99a2c3)


### 6. Détruire 

```bash
terraform destroy
```
