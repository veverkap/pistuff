job "traefikforwardauth" {
  datacenters = ["alpha"]
  type        = "service"

  group "traefikforwardauth" {
    # I only want one of these running at a time
    count = 1

    task "traefikforwardauth" {
      # gotta use the docker driver
      driver = "docker"

      env {
        # this are not real

      }

      config {
        image        = "thomseddon/traefik-forward-auth:2-arm"
        network_mode = "bridge"


        port_map {
          traefikforwardauth = 4181
        }

        labels {}
      }

      resources {
        cpu    = 500  # 500 MHz
        memory = 1024 # 1G

        network {
          mbits = 100
          port  "traefikforwardauth"{}
        }
      }

      service {
        name = "traefikforwardauth"
        port = "traefikforwardauth"

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
