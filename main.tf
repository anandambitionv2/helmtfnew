module "helm" {
    source = "./modules"
    releases = var.releases
  
}


module "helm_aksjenkinsnative" {
    source = "./modules"
    releases = var.release_jenkinsnative  
}