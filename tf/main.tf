provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "onpremise-rg" {
  name     = "onpremise-rg"
  location = var.onpremise_location
}

resource "azurerm_resource_group" "hub-rg" {
  name     = "hub-rg"
  location = var.azure_location
}

resource "azurerm_resource_group" "spoke01-rg" {
  name     = "spoke01-rg"
  location = var.azure_location
}

resource "azurerm_resource_group" "spoke02-rg" {
  name     = "spoke02-rg"
  location = var.azure_location
}

resource "azurerm_resource_group" "spoke03-rg" {
  name     = "spoke03-rg"
  location = var.azure_location
}