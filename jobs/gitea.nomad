job "gitea" {
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

  group "gitea" {
    count = 1

    volume "giteaconfig" {
      type      = "host"
      read_only = false
      source    = "giteaconfig"
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

    task "gitea" {
      driver = "docker"

      volume_mount {
        volume      = "giteaconfig"
        destination = "/data"
        read_only   = false
      }

      config {
        image        = "registry.veverka.net/gitea:latest"

        auth {
          username = "test"
          password = "test"
        }
        network_mode = "bridge"

        port_map {
          gitea = 3000
          openssh = 22
        }

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
          port  "gitea"{}
        }
      }

      service {
        name = "gitea"
        port = "gitea"

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
