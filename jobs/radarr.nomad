job "radarr" {
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

  group "radarr" {
    count = 1

    volume "radarrconfig" {
      type      = "host"
      read_only = false
      source    = "radarrconfig"
    }

    volume "moviesfolder" {
      type      = "host"
      read_only = false
      source    = "moviesfolder"
    }

    volume "moviessync" {
      type      = "host"
      read_only = false
      source    = "moviessync"
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

    task "radarr" {
      driver = "docker"

      volume_mount {
        volume      = "radarrconfig"
        destination = "/config"
        read_only   = false
      }

      volume_mount {
        volume      = "moviesfolder"
        destination = "/movies"
        read_only   = false
      }

      volume_mount {
        volume      = "moviessync"
        destination = "/downloads"
        read_only   = false
      }

      config {
        image        = "linuxserver/radarr"
        network_mode = "bridge"

        port_map {
          radarr = 7878
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
          port  "radarr"{}
        }
      }

      service {
        name = "radarr"
        port = "radarr"

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
