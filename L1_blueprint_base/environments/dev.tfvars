tags = {
  "classification"    = "pbmm"
  "contact"           = "bernard.maltais@canada.ca; john.nephin@canada.ca; louis-eric.tremblay@canada.ca"
  "costcentre"        = "566811"
  "env"               = "dev"
  "owner"             = "bernard.maltais@canada.ca; john.nephin@canada.ca; louis-eric.tremblay@canada.ca"
  "cloudusageprofile" = "3"
  "branch"            = "CIO"
}

env     = "ScDc"
group   = "CIO"
project = "ESLZ"

location = "canadacentral"

deployOptionalFeatures = {
  ddos_protection_plan       = false
  recovery_services_vault    = false
  security_center            = true
  sentinel                   = false
  deny_publicip_subscription = true
  deny_publicips_on_nics     = true
  jumpServer                 = false
}

## Optional Features variables ##

optionalFeaturesConfig = {
  recovery_services_vault = {
    sku                 = "Standard" # Sets the vault's SKU. Possible values include: Standard, RS0
    soft_delete_enabled = true       # Is soft delete enable for this Vault?
  }
  security_center = {
    email = "some@test.com"
    phone = "123-456-7890"
  }
}

Subscription_AADGroup_Owners_ids = [
  "446fe20e-1b5c-45fc-a04e-5ae7cfb66684", # Bernard Maltais
  "d4decfde-8300-4fa4-aa36-7c22bf22a868", # John Nephin
  "aea74c39-1a88-47f5-8c31-a6d0c1173aa3"  # Louis-Eric Tremblay
]

network = {
  vnet = ["10.101.240.0/24"]
  subnets = {
    PAZ = ["10.101.240.0/27"]
    OZ  = ["10.101.240.32/27"]
    RZ  = ["10.101.240.64/27"]
    MAZ = ["10.101.240.96/27"]
  }
}
Landing-Zone-Next-Hop = "172.168.3.22"
RDS-Gateway           = "10.101.16.4"

domain = {
  public = {
    name = "eslz.dev.ciso.ssc-spc.gc.ca"
  }
  private = {
    name                 = "eslz.dev.local"
    registration_enabled = true # Set to true if auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled?
  }
}

L1_RBAC = {
  contributorNames = [
    "john.nephin@163dev.onmicrosoft.com",
    "bernard.maltais@163dev.onmicrosoft.com",
    "louis-eric.tremblay@163dev.onmicrosoft.com",
    "test-bernard.maltais@163dev.onmicrosoft.com"
  ]

  readerNames = []
}

vmConfigs = {
  /*
  # Template for Linux server variables

  Server-Name = {
    deploy = bool # Optional. Default is true
    admin_username       = string # Optional. Default is "azureadmin" 
    admin_password       = string # Required
    os_managed_disk_type = string # Optional. Default is "StandardSSD_LRS"
    vm_size              = string # Required. Example: "Standard_D2s_v3"
    priority             = string # Optional. Default is "Regular". possible values are "Regular" or "Spot"
  }
  */

  SWJ-01 = {
    admin_password = "tmp-Canada123!"
    vm_size        = "Standard_D2s_v3"
    priority       = "Spot"
  }
}

