job "dockerregistry" {
  datacenters = ["alpha"]
  type        = "service"

  group "dockerregistry" {
    # I only want one of these running at a time
    count = 1

    task "dockerregistry" {
      # gotta use the docker driver
      driver = "docker"

      config {
        image        = "registry:2"
        network_mode = "bridge"

        # I mount the dockerregistry folder to /var/lib/registry
        # so that I can persist the images on my NAS through
        # deploys and restarts
        volumes = [
          "/mnt/configs/dockerregistry:/var/lib/registry"
        ]

        port_map {
          dockerregistry = 5000
        }

        labels {}
      }

      resources {
        cpu    = 500  # 500 MHz
        memory = 1024 # 1G

        network {
          mbits = 100
          port  "dockerregistry"{}
        }
      }

      service {
        name = "dockerregistry"
        port = "dockerregistry"

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
