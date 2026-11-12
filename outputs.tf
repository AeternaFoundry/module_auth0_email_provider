output "email_providers_id" {
  description = "Map of id values across all email_providers, keyed the same as var.email_providers"
  value       = { for k, v in auth0_email_provider.email_providers : k => v.id }
}
output "email_providers_credentials" {
  description = "Map of credentials values across all email_providers, keyed the same as var.email_providers"
  value       = { for k, v in auth0_email_provider.email_providers : k => one(v.credentials) }
  sensitive   = true
}
output "email_providers_default_from_address" {
  description = "Map of default_from_address values across all email_providers, keyed the same as var.email_providers"
  value       = { for k, v in auth0_email_provider.email_providers : k => v.default_from_address }
}
output "email_providers_enabled" {
  description = "Map of enabled values across all email_providers, keyed the same as var.email_providers"
  value       = { for k, v in auth0_email_provider.email_providers : k => v.enabled }
}
output "email_providers_name" {
  description = "Map of name values across all email_providers, keyed the same as var.email_providers"
  value       = { for k, v in auth0_email_provider.email_providers : k => v.name }
}
output "email_providers_settings" {
  description = "Map of settings values across all email_providers, keyed the same as var.email_providers"
  value       = { for k, v in auth0_email_provider.email_providers : k => one(v.settings) }
}

