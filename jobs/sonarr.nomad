job "sonarr" {
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

  group "sonarr" {
    count = 1

    volume "sonarrconfig" {
      type      = "host"
      read_only = false
      source    = "sonarrconfig"
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

    task "sonarr" {
      driver = "docker"

      volume_mount {
        volume      = "sonarrconfig"
        destination = "/config"
        read_only   = false
      }

      config {
        image        = "linuxserver/sonarr:latest"
        network_mode = "bridge"

        port_map {
          sonarr = 8989
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
          port  "sonarr"{}
        }
      }

      service {
        name = "sonarr"
        port = "sonarr"

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
