job "ombi" {
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

  group "ombi" {
    count = 1

    volume "ombiconfig" {
      type      = "host"
      read_only = false
      source    = "ombiconfig"
    }

    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    ephemeral_disk {
      size    = 200
      sticky  = true
      migrate = true
    }

    task "ombi" {
      driver = "docker"

      volume_mount {
        volume      = "ombiconfig"
        destination = "/config"
        read_only   = false
      }

      config {
        image        = "linuxserver/ombi"
        network_mode = "bridge"

        volumes = [
          "/mnt/movies:/mnt/movies",
          "/mnt/tv:/mnt/tv",
        ]

        port_map {
          ombi = 3579
        }

        labels {}
      }

      env {
        PUID = "1000"
        PGID = "995"
      }

      resources {
        cpu    = 500  # 500 MHz
        memory = 1024 # 1G

        network {
          mbits = 100
          port  "ombi"{}
        }
      }

      service {
        name = "ombi"
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
