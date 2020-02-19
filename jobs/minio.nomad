job "minio" {
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

  group "minio" {
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

    task "minio" {
      driver = "docker"

      env {
        MINIO_ACCESS_KEY = "NOTAREALKEY"
        MINIO_SECRET_KEY = "NOTAREALKEY"
      }

      config {
        image        = "jessestuart/minio:RELEASE.2020-01-25T02-50-51Z"

        args = [
          "server",
          "/data"
        ]
        network_mode = "bridge"

        volumes = [
          "/mnt/configs/minio:/data/",
        ]

        port_map {
          minio = 9000
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
          port  "minio"{}
        }
      }

      service {
        name = "minio"
        port = "minio"

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
