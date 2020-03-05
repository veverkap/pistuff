job "nextcloud" {
  datacenters = ["alpha"]
  type        = "service"

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

  group "nextcloud" {
    count = 1

    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    ephemeral_disk {
      size = 300
    }

    task "nextcloud" {
      driver = "docker"

      config {
        image        = "linuxserver/nextcloud"
        network_mode = "bridge"

        volumes = [
          "/mnt/movies:/mnt/movies",
          "/mnt/tv:/mnt/tv",
          "/mnt/configs/nextcloud:/config",
        ]

        port_map {
          nextcloud = 443
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
          port  "nextcloud"{}
        }
      }

      service {
        name = "nextcloud"
        port = "nextcloud"

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
