terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.99.0"
    }
  }
}



provider "azurerm" {
  features {}

  subscription_id = "Add here" #Your Azure Subscription ID
  tenant_id       = "Add Here" # Your Tenant ID 
  client_id       = "Add Here" # Your APP (Client) IDv
  client_secret   = "Add here " # Value of  your App Secret
}
