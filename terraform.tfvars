releases = {
  "r1" = {
    
    name             = "argo-server-release"
    repository       = "https://argoproj.github.io/argo-helm"
    chart            = "argo-cd"
    version          = "10.0.0"
    values           = ["./values/values.yml"]
    namespace        = "argocd"
    create_namespace = true
  
  }


  "r2" = {
    
    name             = "argo-app-release"
    repository       = "https://argoproj.github.io/argo-helm"
    chart            = "argocd-apps"
    version          = "2.0.5"
    values           = ["./values/argocdapps.yml"]
    namespace        = "argocd"
    create_namespace = false
  
  }

  "r3" = {
    
    name             = "mycustomnginx"
    repository       = "oci://acrwinter.azurecr.io/helm"
    chart            = "helm-nginx"
    version          = "0.30.0"
    # values           = ["./values/customnginx.yml"]
    namespace        = "default"
    create_namespace = false
  
  }
}