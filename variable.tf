locals{
  linux_app=[for f in fileset("${path.module}/linuxappconfiguration", "[^_]*.yaml") : yamldecode(file("${path.module}/linuxappconfiguration/${f}"))]
  linux_app_list = flatten([
    for app in local.linux_app : [
      for linuxapps in try(app.listoflinuxapp, []) :{
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
  resource_group_name = azurerm_resource_group.azureresourcegroup.george_ibrahim_canada_1980
  location            = azurerm_resource_group.azureresourcegroup.canadacentral
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}

resource "azurerm_linux_web_app" "george1980" {
  for_each            = azurerm_service_plan.batcha06sp
  name                = each.value.name
  resource_group_name = azurerm_resource_group.azureresourcegroup.george_ibrahim_canada_1980
  location            = azurerm_resource_group.azureresourcegroup.canadacentral
  service_plan_id     = each.value.id
  enabled             = each.value.enabled

  site_config {}
}

