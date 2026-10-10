variable "email_providers" {
  description = <<EOT
Map of email_providers, attributes below
Required:
    - default_from_address
    - name
    - credentials (block):
        - access_key_id (optional)
        - api_key (optional)
        - azure_cs_connection_string (optional)
        - domain (optional)
        - ms365_client_id (optional)
        - ms365_client_secret (optional)
        - ms365_tenant_id (optional)
        - region (optional)
        - secret_access_key (optional)
        - smtp_host (optional)
        - smtp_pass (optional)
        - smtp_port (optional)
        - smtp_user (optional)
Optional:
    - enabled
    - settings (block):
        - headers (optional, block):
            - x_mc_view_content_link (optional)
            - x_ses_configuration_set (optional)
        - message (optional, block):
            - configuration_set_name (optional)
            - view_content_link (optional)
EOT

  type = map(object({
    default_from_address = string
    name                 = string
    enabled              = optional(bool)
    credentials = object({
      access_key_id              = optional(string)
      api_key                    = optional(string)
      azure_cs_connection_string = optional(string)
      domain                     = optional(string)
      ms365_client_id            = optional(string)
      ms365_client_secret        = optional(string)
      ms365_tenant_id            = optional(string)
      region                     = optional(string)
      secret_access_key          = optional(string)
      smtp_host                  = optional(string)
      smtp_pass                  = optional(string)
      smtp_port                  = optional(number)
      smtp_user                  = optional(string)
    })
    settings = optional(object({
      headers = optional(object({
        x_mc_view_content_link  = optional(string)
        x_ses_configuration_set = optional(string)
      }))
      message = optional(object({
        configuration_set_name = optional(string)
        view_content_link      = optional(bool)
      }))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        contains(["azure_cs", "custom", "mailgun", "mandrill", "ms365", "sendgrid", "ses", "smtp", "sparkpost"], v.name)
      )
    ])
    error_message = "must be one of: \"azure_cs\", \"custom\", \"mailgun\", \"mandrill\", \"ms365\", \"sendgrid\", \"ses\", \"smtp\", \"sparkpost\""
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.api_key == null || (length(v.credentials.api_key) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.access_key_id == null || (length(v.credentials.access_key_id) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.secret_access_key == null || (length(v.credentials.secret_access_key) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.region == null || (length(v.credentials.region) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.smtp_host == null || (length(v.credentials.smtp_host) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.smtp_user == null || (length(v.credentials.smtp_user) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.smtp_pass == null || (length(v.credentials.smtp_pass) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.azure_cs_connection_string == null || (length(v.credentials.azure_cs_connection_string) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.ms365_tenant_id == null || (length(v.credentials.ms365_tenant_id) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.ms365_client_id == null || (length(v.credentials.ms365_client_id) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.credentials.ms365_client_secret == null || (length(v.credentials.ms365_client_secret) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.email_providers : (
        v.settings == null || (v.settings.headers == null || (v.settings.headers.x_mc_view_content_link == null || (contains(["true", "false"], v.settings.headers.x_mc_view_content_link))))
      )
    ])
    error_message = "must be one of: \"true\", \"false\""
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

