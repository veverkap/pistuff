job "dockerregistry" {
  datacenters = ["alpha"]
  type = "service"
  update {
    max_parallel = 2
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }
  migrate {
    max_parallel = 2
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }
  group "dockerregistry" {
    count = 1
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }
    ephemeral_disk {
      size = 300
    }
    task "dockerregistry" {
      driver = "docker"
      config {
        image = "registry:2"
        network_mode = "bridge"
        port_map {
          dockerregistry = 5000
        }
        labels {
        }
      }
      resources {
        cpu    = 500 # 500 MHz
        memory = 1024 # 1G
        network {
          mbits = 100
          port "dockerregistry" {}
        }
      }
      service {
        name = "dockerregistry"
        tags = [
          "traefik.http.routers.registryrouter.rule=Host(`registry.veverka.net`)",
          "traefik.http.routers.registryrouter.service=dockerregistry@consulcatalog",
          "traefik.http.routers.registryrouter.tls.certResolver=le",
          "traefik.http.routers.registryrouter.tls.domains[0].main=registry.veverka.net",
          "traefik.http.routers.registryrouter.entryPoints[0]=registry"
        ]
        port = "dockerregistry"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
