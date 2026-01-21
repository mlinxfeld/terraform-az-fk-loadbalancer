# outputs.tf

output "lb_id" {
  description = "Load Balancer resource ID."
  value       = azurerm_lb.this.id
}

output "lb_name" {
  description = "Load Balancer name."
  value       = azurerm_lb.this.name
}

output "frontend_ip_configuration_name" {
  description = "Frontend IP configuration name."
  value       = var.frontend_name
}

output "public_ip_id" {
  description = "Public IP resource ID (if public_lb=true)."
  value       = var.public_lb ? azurerm_public_ip.this[0].id : null
}

output "public_ip_address" {
  description = "Public IP address (if public_lb=true)."
  value       = var.public_lb ? azurerm_public_ip.this[0].ip_address : null
}

output "backend_pool_id" {
  description = "Backend Address Pool ID. Use this to attach VMSS backends."
  value       = azurerm_lb_backend_address_pool.this.id
}

output "probe_id" {
  description = "Health probe ID."
  value       = azurerm_lb_probe.this.id
}

output "rule_id" {
  description = "LB rule ID."
  value       = azurerm_lb_rule.this.id
}
