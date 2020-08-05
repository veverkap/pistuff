job "redis" {
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

  group "redis" {
    count = 1

    volume "redisconfig" {
      type      = "host"
      read_only = false
      source    = "redisconfig"
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

    task "redis" {
      driver = "docker"

      volume_mount {
        volume      = "redisconfig"
        destination = "/config"
        read_only   = false
      }

      config {
        image        = "redis"
        network_mode = "bridge"

        port_map {
          redis = 6379
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
          port  "redis"{}
        }
      }

      service {
        name = "redis"
        port = "redis"

        tags = [
          "traefik.enable=true",
          "traefik.tcp.routers.redisrouter.entrypoints=redis",
          "traefik.tcp.routers.redisrouter.rule=HostSNI(`*`)",
          "traefik.tcp.routers.redisrouter.service=redis"
        ]

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
