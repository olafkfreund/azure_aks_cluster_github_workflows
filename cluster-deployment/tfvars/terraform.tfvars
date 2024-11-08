resource_group_name = "rg-fc-aks"
location            = "uksouth"
tags = {
  environment = "dev"
  owner       = "olafkfreund"
  application = "fcaks"
}
user_assigned_identity_name  = "dev-uai"
acr_name                     = "devacrfcaks"
vm_size                      = "Standard_D2s_v3"
aks_username                 = "olafkfreund"
aks_name                     = "dev-fcaks"
azure_monitor_workspace_name = "dev-amw-fcaks"
grafana_name                 = "dev-grafana-fcaks"
azure_object_id              = "7f5748a3-8cdb-40dc-a9cf-cc4bb1a61c35"

