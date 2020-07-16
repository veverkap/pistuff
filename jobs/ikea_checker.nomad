job "ikea-checker" {

  datacenters = ["alpha"]

  type = "batch"

  constraint {
    attribute = "${attr.unique.hostname}"
    regexp = ".*rpi2.*"
  }

  periodic {
    // Launch every hour
    cron = "0 * * * * *"

    // Do not allow overlapping runs.
    prohibit_overlap = true
  }

  task "run-ikea-checker" {
    driver = "raw_exec"

    config {
      # When running a binary that exists on the host, the path must be absolute
      command = "/usr/local/bin/ikea_checker"
    }

    resources {
      # defaults
    }
  }
}
