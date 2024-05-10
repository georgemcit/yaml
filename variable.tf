locals{
  linux_app=[for f in fileset("${path.module}/linuxappconfiguration", "[^_]*.yaml") : yamldecode(file("${path.module}/linuxappconfiguration/${f}"))]
  linux_app_list = flatten([
    for app in local.linux_app : [
      for linuxapps in try(linuxapp.yaml, []) :{
        name=linuxapps.name
        os_type=linuxapps.os_type
        sku_name=linuxapps.sku_name     
      }
    ]
])
}
resource "azurerm_service_plan" "george" {
  for_each            ={for sp in local.linux_app_list: "${sp.name}"=>sp }
  name                = each.value.name
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_resource_group.azureresourcegroup.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}
