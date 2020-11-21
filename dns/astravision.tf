resource "cloudflare_zone" "astral" {
    zone = "astral.vision"
}

resource "cloudflare_record" "astral_webmail" {
  zone_id  = cloudflare_zone.astral.id
  name     = "webmail"
  value    = "ghs.googlehosted.com"
  type     = "CNAME"
  proxied  = false
  ttl      = 120
}
