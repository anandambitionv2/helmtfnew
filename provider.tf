# provider "helm" {
#   kubernetes = {
#     config_path =  abspath("${path.root}/kubeconfig/config")
#     version     = "~> 2.0"
#   }
# }



# 1. Fetch your existing AKS cluster data from Azure
data "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster-argocd"
  resource_group_name = "my-aks-rg"
}

# 2. Grab an Entra ID bearer token explicitly for AKS
data "azurerm_client_config" "current" {}

# 3. Feed the cluster parameters natively into the Helm provider
# provider "helm" {
#   kubernetes = {
#     host                   = data.azurerm_kubernetes_cluster.aks.kube_config[0].host
#     cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
    
#     # Bypasses the need for kubeconfig and kubelogin entirely
#     token                  = data.azurerm_kubernetes_cluster.aks.kube_config[0].password
#   }
# }

provider "azurerm" {
  features {
  }
    
}

output "kubeconfigpw" {
  value = data.azurerm_kubernetes_cluster.aks.kube_config[0].password
  sensitive = true
  
}

output "kubename" {
  value = data.azurerm_kubernetes_cluster.aks.name
}

# 2. Configure the Helm Provider with inline exec authentication
provider "helm" {
  kubernetes =  {
    host                   = data.azurerm_kubernetes_cluster.aks.kube_config[0].host
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)

    # This replaces the local file structure completely
    exec = {
      api_version = "client.authentication.k8s.io/v1"
      command     = "kubelogin"
      
      # Instructs kubelogin to run in non-interactive Service Principal mode
      args = [
        "get-token",
        "--server-id",
        "6dae42f8-4368-4678-94ff-3960e28e3630", # Default AAD client ID for all managed AKS clusters
        "--login",
        "azurecli"
      ]

      # Expose your CI/CD runner secrets as environment variables to the execution process
      
    }
  }
}