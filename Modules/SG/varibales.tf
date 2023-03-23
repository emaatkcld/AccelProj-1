variable "name" {
  description = "Name to be associated with all resources for this Project"
  type        = string
  default     = "ACPJ1"

}

variable "test-vpc" {
  default = "myvpc"

}
#Various Ports
variable "http_port" {
  default     = 80
  description = "this port allows http access"
}
variable "proxy_port1" {
  default     = 8080
  description = "this port allows proxy access"
}
variable "ssh_port" {
  default     = 22
  description = "this port allows ssh access"
}
variable "proxy_port2" {
  default     = 9000
  description = "this port allows proxxy access"
}

variable "MYSQL_port" {
  default     = 3306
  description = "this port allows proxy access"
}

variable "all_access" {
  default = "0.0.0.0/0"
}

variable "local_port" {
  default = "172.31.48.1/32"
}
