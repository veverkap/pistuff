
# Configure the Consul provider
provider "consul" {
  address    = "192.168.1.231:8500"
  datacenter = "alpha"

  token      = var.consul_token
}

resource "consul_service" "hass" {
  name    = "hass-service"
  node    = "rpi6"
  port    = 8123

  check {
    check_id                          = "service:hass"
    name                              = "Hass health check"
    status                            = "passing"
    http                              = "192.168.1.152:8123"
    tls_skip_verify                   = false
    method                            = "GET"
    interval                          = "5s"
    timeout                           = "1s"
  }
}

resource "consul_service" "radarr" {
  name    = "radarr-service"
  node    = "rpi2"
  port    = 7878

  check {
    check_id                          = "service:radarr"
    name                              = "radarr health check"
    status                            = "passing"
    http                              = "192.168.1.224:7878"
    tls_skip_verify                   = false
    method                            = "GET"
    interval                          = "5s"
    timeout                           = "1s"
  }
}

resource "consul_service" "sonarr" {
  name    = "sonarr-service"
  node    = "rpi2"
  port    = 8989

  check {
    check_id                          = "service:sonarr"
    name                              = "sonarr health check"
    status                            = "passing"
    http                              = "192.168.1.224:8989"
    tls_skip_verify                   = false
    method                            = "GET"
    interval                          = "5s"
    timeout                           = "1s"
  }
}
