tags = {
  "contact"           = "s153300@student.dtu.dk"
  "env"               = "prod"
  "owner"             = "s153300@student.dtu.dk"
  "branch"            = "Student"
}

env     = "<IaCP>"
group   = "<DevOps>"
project = "<Infrastructure as Code Project>"

location = "westeurope"

Landing-Zone-Next-Hop = "10.10.20.20"
RDS-Gateways           = ["100.96.185.4", "100.96.185.5"]

domain = {
  public = {
    name = "some.domain.com"
  }
  private = {
    name                 = "some.domain.local"
    registration_enabled = true # Set to true if auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled?
  }
}

L2_RBAC = {
  contributorNames = [
    "some@aad.user.email",
    "some@aad.user.email2"
  ]

  contributorEnterpriseID = [
    "bb294f5d-fece-4d3a-a187-7f98cb64e478", # Some user SP
    "2000c7f5-0f8d-4a45-a65d-d70dc3edcac3"  # Some user2 SP
  ]

  readerNames = [
    "some@aad.user.email",
    "some@aad.user.email2"
  ]
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

  SRV-linux-mgmt = {
    deploy         = false
    admin_password = "tmp-e4d5rtc!"
    vm_size        = "Standard_D2s_v3"
    priority       = "Spot"
  }
}

L1_terraform_remote_state_config = {
    key = "L1_blueprint_base_prod.tfstate" # <------------ Don't forget to set the env name!!!
}