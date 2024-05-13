output "azure_linux_app" {
  value = local.linux_app_list
}
output "names_linux_app" {
  value=[for app in local.linux_app_list : app.name]
}
