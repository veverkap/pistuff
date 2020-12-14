provider "consul" {
  address    = var.consul_address
  datacenter = var.consul_datacenter

  # SecretID from the previous step
  token      = var.consul_token
  http_auth  = var.consul_http_auth
}

# Register external node - dashboard
resource "consul_node" "windows" {
  name    = "windows"
  address = "192.168.1.32"

  meta = {
    "external-node"  = "true"
    "external-probe" = "true"
  }
}

# Register Counting Service
resource "consul_service" "radarrwin" {
  name    = "radarrwin-service"
  node    = consul_node.windows.name
  port    = 7878
  tags    = ["radarr"]

  check {
    check_id                          = "service:radarrwin"
    name                              = "radarrwin health check"
    status                            = "passing"
    http                              = "192.168.1.32:7878"
    tls_skip_verify                   = false
    method                            = "GET"
    interval                          = "5s"
    timeout                           = "1s"
  }
}
