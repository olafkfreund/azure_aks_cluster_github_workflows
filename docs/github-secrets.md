# Github Secrets that need to be set

## How to set Github secrets

You can set the secrets by using:

```sh
gh secret set SECRET
```

or collecting secrets from a file

```sh
gh secret set -f - < myfile.txt
```

That is it.


1. ACR_LOGIN_SERVER
    - the full FQDN for the ACR

2. ACR_NAME
    - ACR name as set in you variables

3. ACR_PASSWORD
    - ACR admin password

4. ACR_USERNAME
    - ACR admin unsername

5. AKS_CLUSTER_NAME
    - AKS cluster name as set in you variables

6. AKS_RESOURCE_GROUP
    - AKS resource group as set in you variables

7. AZURE_CLIENT_ID
    - Client ID from the github user managed id

8. AZURE_OBJECT_ID
    - Your users Object_id that will be user to add access to Grafana

9. AZURE_SUBSCRIPTION_ID
    - Azure subsription id

10. AZURE_TENANT_ID
    - Azure Tenant Id

11. BACKEND_AZURE_RESOURCE_GROUP_NAME
    - Resource group name for tfstate storage account

12. BACKEND_AZURE_STORAGE_ACCOUNT_CONTAINER_NAME
    - tfstate storage account container name

13. BACKEND_AZURE_STORAGE_ACCOUNT_NAME
    - tfstate storage account name

14. EMAIL
    - You email for TLS certificate

15. MYSQL_DATABASE
    - Name for the DB

16. MYSQL_PASSWORD
    - Password for the mysql db

17. MYSQL_ROOT_PASSWORD
    - Root password for the mysql server

18. MYSQL_USER 
    - Username for the mysql server