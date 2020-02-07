job "bazarr" {
  datacenters = ["alpha"]
  type = "service"
  update {
    max_parallel = 2
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }
  migrate {
    max_parallel = 2
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }
  group "bazarr" {
    count = 1
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }
    ephemeral_disk {
      size = 300
    }
    task "bazarr" {
      driver = "docker"
      config {
        image = "linuxserver/bazarr"
        network_mode = "bridge"
        volumes = [
            "/mnt/movies:/mnt/movies",
            "/mnt/tv:/mnt/tv"
        ]
        port_map {
          bazarr = 6767
        }
        labels {
        }
      }
      resources {
        cpu    = 500 # 500 MHz
        memory = 1024 # 1G
        network {
          mbits = 100
          port "bazarr" {}
        }
      }
      service {
        name = "bazarr"
        port = "bazarr"
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
