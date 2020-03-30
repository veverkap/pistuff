job "tautulli" {
  datacenters = ["alpha"]
  type        = "service"

  constraint {
    attribute = "${attr.unique.hostname}"
    value     = "rpi1.node.consul"
  }

  update {
    max_parallel      = 2
    min_healthy_time  = "10s"
    healthy_deadline  = "3m"
    progress_deadline = "10m"
    auto_revert       = false
    canary            = 0
  }

  migrate {
    max_parallel     = 2
    health_check     = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "tautulli" {
    count = 1

    volume "tautulliconfig" {
      type      = "host"
      read_only = false
      source    = "tautulliconfig"
    }

    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    ephemeral_disk {
      size = 300
    }

    task "tautulli" {
      driver = "docker"

      volume_mount {
        volume      = "tautulliconfig"
        destination = "/config"
        read_only   = false
      }

      config {
        image        = "linuxserver/tautulli"
        network_mode = "bridge"

        port_map {
          tautulli = 8181
        }

        labels {}
      }

      env {
        PUID = "1000"
        PGID = "995"
        TZ   = "America/New_York"
      }

      resources {
        cpu    = 500  # 500 MHz
        memory = 1024 # 1G

        network {
          mbits = 100
          port  "tautulli"{}
        }
      }

      service {
        name = "tautulli"
        port = "tautulli"

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
