output "email_providers_id" {
  description = "Map of id values across all email_providers, keyed the same as var.email_providers except keys with no id are omitted"
  value       = { for k, v in auth0_email_provider.email_providers : k => v.id if v.id != null && length(v.id) > 0 }
}
output "email_providers_credentials" {
  description = "Map of credentials values across all email_providers, keyed the same as var.email_providers except keys with no credentials are omitted"
  value       = { for k, v in auth0_email_provider.email_providers : k => one(v.credentials) if v.credentials != null && length(v.credentials) > 0 }
  sensitive   = true
}
output "email_providers_default_from_address" {
  description = "Map of default_from_address values across all email_providers, keyed the same as var.email_providers except keys with no default_from_address are omitted"
  value       = { for k, v in auth0_email_provider.email_providers : k => v.default_from_address if v.default_from_address != null && length(v.default_from_address) > 0 }
}
output "email_providers_enabled" {
  description = "Map of enabled values across all email_providers, keyed the same as var.email_providers except keys with no enabled are omitted"
  value       = { for k, v in auth0_email_provider.email_providers : k => v.enabled if v.enabled != null }
}
output "email_providers_name" {
  description = "Map of name values across all email_providers, keyed the same as var.email_providers except keys with no name are omitted"
  value       = { for k, v in auth0_email_provider.email_providers : k => v.name if v.name != null && length(v.name) > 0 }
}
output "email_providers_settings" {
  description = "Map of settings values across all email_providers, keyed the same as var.email_providers except keys with no settings are omitted"
  value       = { for k, v in auth0_email_provider.email_providers : k => one(v.settings) if v.settings != null && length(v.settings) > 0 }
}

