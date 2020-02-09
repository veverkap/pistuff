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
  zone_id = cloudflare_zone.veverka.id
  name    = "lan.veverka.net"
  value   = "71.120.237.171"
  type    = "A"
  ttl     = 120
}

resource "cloudflare_record" "unifi" {
  zone_id = cloudflare_zone.veverka.id
  name    = "unifi.veverka.net"
  value   = "192.168.1.6"
  type    = "A"
  ttl     = 120
}
resource "cloudflare_record" "veverkanet" {
  zone_id = cloudflare_zone.veverka.id
  name    = "veverka.net"
  value   = "71.120.237.171"
  type    = "A"
  ttl     = 120
}
resource "cloudflare_record" "windows" {
  zone_id = cloudflare_zone.veverka.id
  name    = "windows.veverka.net"
  value   = "192.168.1.43"
  type    = "A"
  ttl     = 120
}
resource "cloudflare_record" "bazarr" {
  zone_id = cloudflare_zone.veverka.id
  name    = "bazarr.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "consul" {
  zone_id = cloudflare_zone.veverka.id
  name    = "consul.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "couchpotato" {
  zone_id = cloudflare_zone.veverka.id
  name    = "couchpotato.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "emailmg" {
  zone_id = cloudflare_zone.veverka.id
  name    = "email.mg.veverka.net"
  value   = "mailgun.org"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "homeassistant" {
  zone_id = cloudflare_zone.veverka.id
  name    = "homeassistant.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "jackett" {
  zone_id = cloudflare_zone.veverka.id
  name    = "jackett.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "nomad" {
  zone_id = cloudflare_zone.veverka.id
  name    = "nomad.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "ombi" {
  zone_id = cloudflare_zone.veverka.id
  name    = "ombi.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "patrick" {
  zone_id = cloudflare_zone.veverka.id
  name    = "patrick.veverka.net"
  value   = "veverkap.github.io"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "radarr" {
  zone_id = cloudflare_zone.veverka.id
  name    = "radarr.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "registry" {
  zone_id = cloudflare_zone.veverka.id
  name    = "registry.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "sonarr" {
  zone_id = cloudflare_zone.veverka.id
  name    = "sonarr.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "traefik" {
  zone_id = cloudflare_zone.veverka.id
  name    = "traefik.veverka.net"
  value   = "lan.veverka.net"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "warez" {
  zone_id = cloudflare_zone.veverka.id
  name    = "warez.veverka.net"
  value   = "f001.backblazeb2.com"
  type    = "CNAME"
  ttl     = 120
}
resource "cloudflare_record" "webmail" {
  zone_id = cloudflare_zone.veverka.id
  name    = "webmail.veverka.net"
  value   = "ghs.googlehosted.com"
  type    = "CNAME"
  ttl     = 120
}
