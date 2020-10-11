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
  value    = "192.168.1.152"
  type     = "A"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "external" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "external"
  value    = "71.120.230.47"
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
  value    = "192.168.1.32"
  type     = "A"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "qnap" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "qnap"
  value    = "192.168.1.43"
  type     = "A"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "cloud" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "cloud"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "freshrss" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "cloud"
  value    = "freshrss.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "next-ext" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "next"
  value    = "external.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "nextcloud" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "nextcloud"
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

resource "cloudflare_record" "docker" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "docker"
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

resource "cloudflare_record" "git" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "git"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "influxdb" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "influxdb"
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

resource "cloudflare_record" "lazylibrarian" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "lazylibrarian"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "library" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "library"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "meatsweats" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "meatsweats"
  value    = "external.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "minioext" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "minioext"
  value    = "external.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "minio" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "minio"
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
  ttl      = 1
}

resource "cloudflare_record" "radarr" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "radarr"
  value    = "lan.veverka.net"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}

resource "cloudflare_record" "redis" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "redis"
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

resource "cloudflare_record" "tautulli" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "tautulli"
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
  ttl      = 1
}

resource "cloudflare_record" "webmail" {
  zone_id  = cloudflare_zone.veverka.id
  name     = "webmail"
  value    = "ghs.googlehosted.com"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
