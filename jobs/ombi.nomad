job "ombi" {
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
  group "ombi" {
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
    task "ombi" {
      driver = "docker"
      config {
        image = "linuxserver/ombi"
        network_mode = "bridge"
        port_map {
          ombi = 3579
        }
        labels {
        }
      }
      resources {
        cpu    = 500 # 500 MHz
        memory = 1024 # 1G
        network {
          mbits = 100
          port "ombi" {}
        }
      }
      service {
        name = "ombi"
        tags = [
          "traefik.http.routers.registryrouter.rule=Host(`ombi.veverka.net`)",
          "traefik.http.routers.registryrouter.service=ombi@consulcatalog",
          "traefik.http.routers.registryrouter.tls.certResolver=le",
          "traefik.http.routers.registryrouter.tls.domains[0].main=ombi.veverka.net"
        ]
        port = "ombi"
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
