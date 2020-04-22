job "calibreweb" {
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

  group "calibreweb" {
    count = 1

    volume "calibrebooks" {
      type      = "host"
      read_only = false
      source    = "calibrebooks"
    }

    volume "calibrewebconfig" {
      type      = "host"
      read_only = false
      source    = "calibrewebconfig"
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

    task "calibreweb" {
      driver = "docker"

      volume_mount {
        volume      = "calibrebooks"
        destination = "/books"
        read_only   = false
      }

      volume_mount {
        volume      = "calibrewebconfig"
        destination = "/config"
        read_only   = false
      }

      config {
        image        = "linuxserver/calibre-web"
        network_mode = "bridge"

        port_map {
          calibreweb = 8083
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
          port  "calibreweb"{}
        }
      }

      service {
        name = "calibreweb"
        port = "calibreweb"

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
