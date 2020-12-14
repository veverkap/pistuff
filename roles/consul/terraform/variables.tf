
variable "consul_address" {
  description = "Consul Address"
  default     = "consul.veverka.net"
}

variable "consul_datacenter" {
  description = "Consul Datacenter"
  default     = "alpha"
}

variable "consul_token" {
  description = "consul token"
}

variable "consul_http_auth" {
}
