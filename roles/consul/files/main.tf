
# Configure the Consul provider
provider "consul" {
  address    = "192.168.1.231:8500"
  datacenter = "alpha"

  # SecretID from the previous step
  token      = "570107c2-01db-ab45-3f8b-37bb50c9c4ca"
}

resource "consul_node" "hass" {
  name    = "hass"
  address = "192.168.1.152"

  meta = {
    "external-node"  = "true"
    "external-probe" = "true"
  }
}


resource "consul_service" "hass" {
  name    = "hass-service"
  node    = consul_node.hass.name
  port    = 8123
  tags    = ["counting"]

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
