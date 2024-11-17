
terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  //your api credentials
  pm_api_url      = "https://192.168.48.129:8006/"
  pm_api_token_id = "fra"
  pm_api_token_secret = "6e5138ba-7e12-46dc-b0ee-3ee7d3a4f938"
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
