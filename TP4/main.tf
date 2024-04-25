# Declaration of the Terraform version and required providers
terraform {
  required_providers {
    # Azure Provider
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    # TLS Provider
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1"
    }
  }
  # Configuration of the backend to store Terraform state locally
  backend "local" {
    path = "terraform.tfstate" # Path where Terraform state will be stored locally
  }
}

# Configuration of the Azure provider
provider "azurerm" {
  features {}                       # Enable additional features of the Azure provider
  skip_provider_registration = true # Skip automatic registration of the Azure provider
}