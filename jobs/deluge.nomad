job "deluge" {
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

  group "deluge" {
    count = 1

    volume "delugeconfig" {
      type      = "host"
      read_only = false
      source    = "delugeconfig"
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

    task "deluge" {
      driver = "docker"

      volume_mount {
        volume      = "delugeconfig"
        destination = "/config"
        read_only   = false
      }


      config {
        image        = "linuxserver/deluge:latest"
        network_mode = "bridge"

        volumes = [
          "/mnt/movies:/mnt/movies",
          "/mnt/tv:/mnt/tv",
          "/mnt/movies-sync:/mnt/movies-sync",
          "/mnt/tv-sync:/mnt/tv-sync",
        ]

        port_map {
          deluge = 8112
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
          port  "deluge" {}
        }
      }

      service {
        name = "deluge"
        port = "deluge"

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
