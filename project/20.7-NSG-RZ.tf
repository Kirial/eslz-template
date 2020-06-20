resource "azurerm_network_security_group" "Project_RZ-nsg" {
  name                = "${var.env}CNR-${var.group}_${var.project}_RZ-nsg"
  location            = data.azurerm_resource_group.Network-rg.location
  resource_group_name = data.azurerm_resource_group.Network-rg.name

  security_rule {
    name                       = "AllowAzureResourceCommIP" # https://docs.microsoft.com/en-us/azure/virtual-network/what-is-ip-address-168-63-129-16
    access                     = "Allow"
    priority                   = "100"
    protocol                   = "*"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "168.63.129.16"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAllFromRDS"
    access                     = "Allow"
    priority                   = "110"
    protocol                   = "*"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = var.RDS-Gateway
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAllOnMAZSubnet"
    access                     = "Allow"
    priority                   = "200"
    protocol                   = "*"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefixes    = data.azurerm_subnet.Project_MAZ-snet.address_prefixes
    destination_port_range     = "*"
    destination_address_prefix = "*" # Implicit local subnet destination
  }
  security_rule {
    name                       = "AllowAllFromPAZSubnet"
    access                     = "Allow"
    priority                   = "201"
    protocol                   = "*"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefixes    = data.azurerm_subnet.Project_PAZ-snet.address_prefixes
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAllFromOZSubnet"
    access                     = "Allow"
    priority                   = "202"
    protocol                   = "*"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefixes    = data.azurerm_subnet.Project_OZ-snet.address_prefixes
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAllFromRZSubnet"
    access                     = "Allow"
    priority                   = "203"
    protocol                   = "*"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefixes    = data.azurerm_subnet.Project_RZ-snet.address_prefixes
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "DenyAllInbound"
    access                     = "Deny"
    priority                   = "4050"
    protocol                   = "*"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  tags = var.tags
}

resource azurerm_subnet_network_security_group_association Project_RZ-nsg-Association {
  subnet_id                 = data.azurerm_subnet.Project_RZ-snet.id
  network_security_group_id = azurerm_network_security_group.Project_RZ-nsg.id
}

resource "azurerm_network_watcher_flow_log" "Network-Project_RZ-flow" {
  network_watcher_name = "NetworkWatcher_canadacentral"
  resource_group_name  = "NetworkWatcherRG"

  network_security_group_id = azurerm_network_security_group.Project_RZ-nsg.id
  storage_account_id        = data.azurerm_storage_account.Project_law-sa.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 7
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = data.azurerm_log_analytics_workspace.Project-law.workspace_id
    workspace_region      = data.azurerm_log_analytics_workspace.Project-law.location
    workspace_resource_id = data.azurerm_log_analytics_workspace.Project-law.id
    interval_in_minutes   = 10
  }
}

resource "azurerm_monitor_diagnostic_setting" "Project_RZ-nsg-logs" {
  name                       = "${var.env}CNR-${var.group}_${var.project}_RZ-nsg-logs"
  target_resource_id         = azurerm_network_security_group.Project_RZ-nsg.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.Project-law.id

  log {
    category = "NetworkSecurityGroupEvent"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "NetworkSecurityGroupRuleCounter"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}
