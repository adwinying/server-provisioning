terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "~>2.3.3"
    }
  }
}

variable "api_key" {
  description = "Vultr API key"
  type = string
  sensitive = true
}

provider "vultr" {
  api_key = var.api_key
  rate_limit = 700
  retry_limit = 3
}

resource "vultr_instance" "tunnel" {
  label="tunnel"
  plan = "vc2-1c-1gb"
  region = "nrt"
  os_id = 387
  activation_email = true
  ddos_protection = false
  enable_ipv6 = false
  private_network_ids = []
  backups = "disabled"
}
