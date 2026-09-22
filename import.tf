import {
 for_each = var.releases
 to = module.helm.helm_release.example[each.key]
 id = each.value.namespace/each.value.name
}