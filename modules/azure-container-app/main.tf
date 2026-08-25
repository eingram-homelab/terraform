resource "azurerm_container_app_environment" "container-app-env" {
  name                = "${var.app_name}-env"
  location            = var.location
  resource_group_name = var.resource_group_name
  public_network_access = var.container_app_environment.public_network_access
  logs_destination = "log-analytics"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  workload_profile {
    name = var.container_app_environment.workload_profile_name
    workload_profile_type = var.container_app_environment.workload_profile_type
  }

  # infrastructure_subnet_id = var.infrastructure_subnet_id
  # internal_load_balancer_enabled = var.container_app_environment.internal_load_balancer_enabled
  tags = var.tags
}

# resource "azurerm_container_app_environment_storage" "share" {
#   for_each                     = var.volume_mounts
#   name                         = each.key
#   container_app_environment_id = azurerm_container_app_environment.container-app-env.id
#   account_name                 = each.value.storage_account_name
#   share_name                   = each.value.share_name
#   access_key                   = each.value.storage_account_key
#   access_mode                  = each.value.access_mode
# }

resource "azurerm_container_app" "container-app" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.container-app-env.id
  revision_mode = var.container_app.revision_mode

  ingress {
    external_enabled = var.container_app.ingress.external_enabled
    target_port      = var.container_app.ingress.target_port
    allow_insecure_connections = var.container_app.ingress.allow_insecure_connections
    client_certificate_mode = "ignore"
    transport = "auto"
    traffic_weight {
      latest_revision = true
      # revision_suffix = ""
      percentage        = 100
    }
    ip_security_restriction {
      name = "AllowAll"
      action = "Allow"
      ip_address_range = "0.0.0.0/0"
    }
  }

  template {
    min_replicas = var.container_app.min_replicas
    max_replicas = var.container_app.max_replicas
    container {
      name   = "${var.app_name}-container"
      image  = var.container_app.image
      cpu    = var.container_app.cpu
      memory = var.container_app.memory

      # dynamic "volume_mounts" {
      #   for_each = var.volume_mounts
      #   content {
      #     name = volume_mounts.key
      #     path = volume_mounts.value.mount_path
      #   }
      # }
    }

    # dynamic "volume" {
    #   for_each = var.volume_mounts
    #   content {
    #     name         = volume.key
    #     storage_name = azurerm_container_app_environment_storage.share[volume.key].name
    #     storage_type = "AzureFile"
    #   }
    # }
  }
  tags = var.tags
}