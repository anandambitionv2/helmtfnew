import {
 for_each = {for k,v in var.releases : k=>v if v.import ==true }
 to = module.helm.helm_release[k].id
 id = each.value.namespace/each.value.name
}