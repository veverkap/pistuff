terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "veverkap"

    workspaces {
      name = "veverka-dns"
    }
  }
}

provider "cloudflare" {
  version = "~> 2.0"
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "cloudflare_zone" "veverka" {
    zone = "veverka.net"
}

resource "cloudflare_record" "foobar" {
  zone_id = cloudflare_zone.veverka.id
  name    = "terraform"
  value   = "192.168.0.11"
  type    = "A"
  ttl     = 3600
}
