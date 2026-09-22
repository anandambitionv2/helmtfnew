variable "releases" {
  description = "A map of Helm releases to be deployed"
  type        = map(object({
    name             = string
    repository       = string
    chart            = string
    version          = string
    values           = optional(list(string), [])
    namespace        = string
    create_namespace = optional(bool)
  }))
  
}