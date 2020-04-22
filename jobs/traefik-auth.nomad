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
        PROVIDERS_GOOGLE_CLIENT_ID = "310000938070-b9m4jj7opmjft2u9bqmop1tu1rpcvc4m.apps.googleusercontent.com"
        PROVIDERS_GOOGLE_CLIENT_SECRET = "oE9Gww2z33zcM5CX61fREiVG"
        SECRET = "486d011f89107c79459d3df2982450fc"
        COOKIE_DOMAIN = "veverka.net"
        INSECURE_COOKIE = "false"
        AUTH_HOST = "oauth.veverka.net"
        URL_PATH = "/_oauth"
        WHITELIST = "patrick.veverka@gmail.com"
        LOG_LEVEL = "info"
        LIFETIME = "2592000"
      }

      config {
        image        = "thomseddon/traefik-forward-auth"
        network_mode = "bridge"

        # I mount the traefikforwardauth folder to /var/lib/registry
        # so that I can persist the images on my NAS through
        # deploys and restarts
        volumes = [
          "/mnt/configs/traefikforwardauth:/var/lib/registry"
        ]

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
