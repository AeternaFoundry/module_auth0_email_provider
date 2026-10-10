resource "auth0_email_provider" "email_providers" {
  for_each = var.email_providers

  default_from_address = each.value.default_from_address
  name                 = each.value.name
  enabled              = each.value.enabled

  credentials {
    access_key_id              = each.value.credentials.access_key_id
    api_key                    = each.value.credentials.api_key
    azure_cs_connection_string = each.value.credentials.azure_cs_connection_string
    domain                     = each.value.credentials.domain
    ms365_client_id            = each.value.credentials.ms365_client_id
    ms365_client_secret        = each.value.credentials.ms365_client_secret
    ms365_tenant_id            = each.value.credentials.ms365_tenant_id
    region                     = each.value.credentials.region
    secret_access_key          = each.value.credentials.secret_access_key
    smtp_host                  = each.value.credentials.smtp_host
    smtp_pass                  = each.value.credentials.smtp_pass
    smtp_port                  = each.value.credentials.smtp_port
    smtp_user                  = each.value.credentials.smtp_user
  }

  dynamic "settings" {
    for_each = each.value.settings != null ? [each.value.settings] : []
    content {
      dynamic "headers" {
        for_each = settings.value.headers != null ? [settings.value.headers] : []
        content {
          x_mc_view_content_link  = headers.value.x_mc_view_content_link
          x_ses_configuration_set = headers.value.x_ses_configuration_set
        }
      }
      dynamic "message" {
        for_each = settings.value.message != null ? [settings.value.message] : []
        content {
          configuration_set_name = message.value.configuration_set_name
          view_content_link      = message.value.view_content_link
        }
      }
    }
  }
}

