# import {
# #  for_each = var.releases

#  to = module.helm.helm_release.example[each.key]
#  id = "${each.value.namespace}/${each.value.name}"
# }

import {
  for_each = {
    for k, v in var.releases : k => v
    if v.import
  }

  to = module.helm.helm_release.example[each.key]

  id = "${each.value.namespace}/${each.value.name}"
}