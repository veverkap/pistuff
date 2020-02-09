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

resource "cloudflare_record" "lan" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "lan"
  value    = "71.120.237.171"
  type     = "A"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "terraform" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "terraform"
  value    = "192.168.0.11"
  type     = "A"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "unifi" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "unifi"
  value    = "192.168.1.6"
  type     = "A"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "veverkanet" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "veverka.net"
  value    = "71.120.237.171"
  type     = "A"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "windows" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "windows"
  value    = "192.168.1.43"
  type     = "A"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "bazarr" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "bazarr"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "consul" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "consul"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "couchpotato" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "couchpotato"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "emailmg" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "email.mg"
  value    = "mailgun.org"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "homeassistant" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "homeassistant"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "jackett" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "jackett"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "nomad" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "nomad"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "ombi" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "ombi"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "patrick" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "patrick"
  value    = "veverkap.github.io"
  type     = "CNAME"
  proxied  = true
  ttl      = 120
}
resource "cloudflare_record" "radarr" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "radarr"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "registry" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "registry"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "sonarr" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "sonarr"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "traefik" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "traefik"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
resource "cloudflare_record" "warez" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "warez"
  value    = "f001.backblazeb2.com"
  type     = "CNAME"
  proxied  = true
  ttl      = 120
}
resource "cloudflare_record" "webmail" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "webmail"
  value    = "ghs.googlehosted.com"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
