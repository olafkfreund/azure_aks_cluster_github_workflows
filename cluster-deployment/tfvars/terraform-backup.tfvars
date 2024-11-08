resource_group_name = "rg-fc-aks"
location            = "uksouth"
tags = {
  environment = "dev"
  owner       = "olafkfreund"
  application = "freundcloudaks"
}
user_assigned_identity_name  = "uai-dev"
acr_name                     = "devfcacr"
vm_size                      = "Standard_D2s_v3"
aks_username                 = "olafkfreund"
aks_name                     = "fcaks"
azure_monitor_workspace_name = "dev-amw-fcaks"
grafana_name                 = "dev-grafana-fcaks"