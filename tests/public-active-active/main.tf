# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "random_string" "friendly_name" {
  length  = 4
  upper   = false
  number  = false
  special = false
}

module "public_active_active" {
  source = "../../"

  domain_name             = var.domain_name
  friendly_name_prefix    = local.friendly_name_prefix
  location                = var.location
  resource_group_name_dns = var.resource_group_name_dns

  # Bootstrapping resources
  load_balancer_certificate   = data.azurerm_key_vault_certificate.load_balancer
  tfe_license_secret_id       = "https://azure-modules-test-kv.vault.azure.net/secrets/rc-license/df75a33fe82449b583c0ebe799c24e73"  
  vm_certificate_secret       = data.azurerm_key_vault_secret.vm_certificate
  vm_key_secret               = data.azurerm_key_vault_secret.vm_key
  tls_bootstrap_cert_pathname = "/var/lib/terraform-enterprise/certificate.pem"
  tls_bootstrap_key_pathname  = "/var/lib/terraform-enterprise/key.pem"

  # Public Active / Active Scenario
  consolidated_services   = var.consolidated_services
  distribution            = "rhel"
  production_type         = "external"
  iact_subnet_list        = ["0.0.0.0/0"]
  vm_node_count           = 2
  vm_sku                  = "Standard_D32a_v4"
  vm_image_id             = "ubuntu"
  load_balancer_public    = true
  load_balancer_type      = "application_gateway"
  redis_use_password_auth = false
  redis_use_tls           = false
  release_sequence           = 713
  create_bastion = true  
  tags = local.common_tags
}

