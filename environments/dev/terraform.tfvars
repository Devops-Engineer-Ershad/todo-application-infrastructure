rgs = {
    rg1 = {
        name        = "rg-todo"
        location    = "Central India"
        managed_by  = " managed by dev team"
    tags = {
        environment = "dev"
        project     = "project-x"
        owner       = "dev-team"
        project_cost = "$10"
        

    }
    }
    rg2 = {
        name        = "rg-prod"
        location    = "central us"
        managed_by  = " managed by prod team"
    tags = {
        environment = "prod"
        project     = "project-y"
        owner       = "prod-team"
        project_cost = "$10"
    }
    
}
}

stgs = {
    stg1 = {
        name                     = "stgdevaccount61"
        resource_group_name      = "rg-todo"
        location                 = "Central India"
        account_tier             = "Standard"
        account_replication_type = "LRS"
        
        # Optional parameters
        account_kind                        = "StorageV2"
        access_tier                         = "Hot"
        https_traffic_only_enabled          = true
        min_tls_version                     = "TLS1_2"
        tags = {
            environment = "dev"
            project     = "project-x"
            owner       = "dev-team"
            project_cost = "$10"
        }
        network_rules = [
        {
          default_action = "Deny"
          bypass         = ["AzureServices"]
          ip_rules       = [ "152.58.134.176"]
        }
        ]
    }
    stg2 = {
        name                     = "stgprodaccount59"
        resource_group_name      = "rg-prod"
        location                 = "East US"
        account_tier             = "Standard"
        account_replication_type = "LRS"
        access_tier              = "Cold"
        
        # Optional parameters
        tags = {
            environment = "prod"
            project     = "project-y"
            owner       = "prod-team"
            project_cost = "$10"
        }
        network_rules = []
        
    }
}

vnets = {
    vnet1 = {
        name                = "vnet-todo"
        location            = "Central India"
        resource_group_name = "rg-todo"
        address_space       = ["10.0.0.0/16"]
        tags = {
            environment = "dev"
            project     = "project-x"
            owner       = "dev-team"
            project_cost = "$10"
    }
   subnets = [
  {
        name           = "frontend-subnet"
        address_prefix = ["10.0.1.0/24"] 
}
,
{
        name           = "backend-subnet"
        address_prefix = ["10.0.2.0/24"] 
}
]  
}
}

pips = {
  pip1 = {
    name                        = "pip-frontend"
    location                    = "Central India"
    resource_group_name         = "rg-todo"
    allocation_method           = "Static"
    tags = {
      environment = "dev"
      project     = "project-x"
      owner       = "dev-team"
      project_cost = "$10"
    }
  }

  pip2 = {
    name                        = "pip-backend"
    location                    = "Central India"
    resource_group_name         = "rg-todo"
    allocation_method           = "Static"
    sku                         = "Standard"
    idle_timeout_in_minutes     = 15
    tags = {
      environment = "prod"
      project     = "project-y"
      owner       = "prod-team"
      project_cost = "$10"
    }
  }
}

nsgs = {
  nsg1 = {
    name                = "nsg-frontend"
    location            = "Central India"
    resource_group_name = "rg-todo"
    tags = { 
      environment = "dev" 
      }

    security_rules = [
      {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "22"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
      }
    ]
  }

  nsg2 = {
    name                = "nsg-backend"
    location            = "Central India"
    resource_group_name = "rg-todo"
    tags = { 
      environment = "dev" 
      }

    security_rules = [
      {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "80"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
      }
    ]
  }
}

nics = {
  nic1 = {
    vnet_name          = "vnet-todo"
    subnet_name        = "frontend-subnet"
    pip_name           = "pip-frontend"
    name                = "nic-frontend"
    location            = "Central India"
    resource_group_name = "rg-todo"
    enable_ip_forwarding          = false
    enable_accelerated_networking = false
    tags = { environment = "dev" }

    ip_configurations = [
      {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = true
      }
    ]
  }
  nic2 = {
    vnet_name          = "vnet-todo"
    subnet_name        = "backend-subnet"
    pip_name           = "pip-backend"
    name                = "nic-backend"
    location            = "Central India"
    resource_group_name = "rg-todo"
    enable_ip_forwarding          = false
    enable_accelerated_networking = false
    tags = { environment = "dev" }

    ip_configurations = [
      {
        name                          = "ipconfig2"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = true
      }
    ]
  }
}

nic_nsg_association = {
  assoc1 = {
    nic_name                  = "nic-frontend"
    nsg_name                  = "nsg-frontend"
    resource_group_name       = "rg-todo"
  }
  assoc2 = {
    nic_name                  = "nic-backend"
    nsg_name                  = "nsg-backend"
    resource_group_name       = "rg-todo"
}
}

vms = {
  vm1 = {
    name                            = "vm-todo-frontend"
    location                        = "Central India"
    resource_group_name             = "rg-todo"
    size                            = "Standard_B1s"
    disable_password_authentication = false
    nic_name                        = "nic-frontend"
    kv_name                         = "kv-todo-apps"
    username_secret_name            = "adminusername"
    password_secret_name            = "adminpassword"
    provision_vm_agent              = true

    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }

    os_disk = [
      {
      name                 = "vm-todo-frontend-osdisk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }
    ]

    admin_ssh_key   = []
    boot_diagnostics = []
    tags = { 
      environment = "dev"
       }
  }
  vm2 = {
    name                            = "vm-todo-backend"
    location                        = "Central India"
    resource_group_name             = "rg-todo"
    size                            = "Standard_B1s"
    disable_password_authentication = false
    nic_name                        = "nic-backend"
    kv_name                         = "kv-todo-apps"
    username_secret_name            = "adminusername"
    password_secret_name            = "adminpassword"
    provision_vm_agent              = true

    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }

    os_disk = [{
      name                 = "vm-todo-backend-osdisk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }]

    admin_ssh_key   = []
    boot_diagnostics = []
    tags = { 
      environment = "dev"
       }
  }
}

key_vaults = {
  kv-dev = {
    name                = "kv-todo-apps"
    resource_group_name = "rg-todo"
    location            = "eastus"
    sku_name            = "standard"
    enabled_for_deployment          = true
    enabled_for_disk_encryption     = true
    enabled_for_template_deployment = false
    purge_protection_enabled        = true
    soft_delete_retention_days      = 7

    access_policies = [
      {
        
        key_permissions    = ["Get", "List", "Create", "Delete"]
        secret_permissions = ["Get", "List", "Set", "Delete"]
        certificate_permissions = ["Get", "List", "Create"]
        storage_permissions     = ["Get", "List"]
      }
    ]

    tags = {
      environment = "dev"
      owner       = "ershad"
      project     = "terraform-modular-demo"
      costcenter  = "cc001"
    }
  }
}

kv_secrets = {
  secret1 = {
    kv_name = "kv-todo-apps"
    rg_name = "rg-todo"
    secret_name  = "adminusername"
    secret_value = "azureuser"
    
  },
  secret2 = {
    kv_name = "kv-todo-apps"
    rg_name = "rg-todo"
    secret_name  = "adminpassword"
    secret_value = "P@ssword123!"    
}
}