output "private_ip" {
  value       = azurerm_linux_virtual_machine.proxy.private_ip_address
  description = "The private IP address of the proxy server"
}
