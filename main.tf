terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.68.0"
      
    }
  }
}

provider "azurerm" {

    features {}
  
}


resource "azurerm_resource_group" "Lab" {
    name = "harrods"
    location = "uksouth"
    tags = {
      "terraform" = "lab"
    }
  
}


resource "azurerm_eventhub_namespace" "harrods" {
  name                = "harrods-eventhub"
  location            = azurerm_resource_group.Lab.location
  resource_group_name = azurerm_resource_group.Lab.name
  sku                 = "Standard"
  capacity            = 2

  tags = {
    environment = "Lab"
  }
}

resource "azurerm_eventhub" "HarrodsHub" {
  name                = "Harrods-event-hub"
  namespace_name      = azurerm_eventhub_namespace.harrods.name
  resource_group_name = azurerm_resource_group.Lab.name
  partition_count     = 2
  message_retention   = 1
}