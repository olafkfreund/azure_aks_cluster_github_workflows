gh_uai_name                = "uai-gh"
github_organization_target = "olafkfreund"
container_name             = "tfstate"
# automatic_container_name   = "tfstate-aks-automatic"
storage_account_name       = "fcdevfstate"
tf_state_rg_name           = "rg-fcaks-tfstate"
identity_rg_name           = "rg-fcaks-identity"
location                   = "uksouth"
tags = {
  environment = "dev"
  owner       = "olafkfreund"
}
