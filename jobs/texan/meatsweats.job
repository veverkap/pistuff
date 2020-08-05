job "meatsweatweb" {
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

  group "meatsweatweb" {
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

    task "meatsweatweb" {
      driver = "docker"

      config {
        image        = "registry.veverka.net/meatsweatweb"

        auth {
          username = "test"
          password = "test"
        }

        network_mode = "bridge"

        volumes = [
          "/mnt/configs/yolo:/config"
        ]

        port_map {
          meatsweatweb = 80
        }

        labels {}
      }

      env {
        PUID = "1000"
        PGID = "995"
        TZ   = "America/New_York"
      }

      resources {
        cpu    = 1500
        memory = 2048

        network {
          mbits = 100
          port  "meatsweatweb"{}
        }
      }

      service {
        name = "meatsweatweb"
        port = "meatsweatweb"

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
