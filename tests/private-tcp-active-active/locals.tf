locals {
  common_tags = {
    Terraform   = "cloud"
    Environment = "${local.friendly_name_prefix}-test-private-tcp-active-active"
    Description = "Private TCP Active/Active"
    Repository  = "hashicorp/terraform-azurerm-terraform-enterprise"
    Team        = "Terraform Enterprise on Prem"
    OkToDelete  = "True"
  }

  proxy_script = templatefile(
    "${path.module}/templates/mitm.sh.tpl",
    {
      ca_certificate  = data.azurerm_key_vault_certificate_data.ca.pem
      ca_private_key  = data.azurerm_key_vault_certificate_data.ca.key
      http_proxy_port = local.proxy_port
    }
  )

  friendly_name_prefix = random_string.friendly_name.id
  resource_group_name  = module.private_tcp_active_active.resource_group_name
  proxy_user           = "proxyuser"
  proxy_port           = "3128"
}
