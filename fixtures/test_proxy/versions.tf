terraform {
  required_version = "~> 1.0.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.2"
    }
  }
}
provider "azurerm" {
  features {}
}