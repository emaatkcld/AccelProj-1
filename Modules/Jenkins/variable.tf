variable "ami" {
    default = "gfddh"
  
}

variable "instance_type" {
    default = "t3.medium"
  
}

variable "prvsubnet" {
    default = "fgdh"
  
}

variable "key_name" {
    default = "dfsd"
  
}
variable "security_id" {
    default = "ghhdd"
  
}

variable "jenkins-lb-name" {
    default = "jenkins-lb"
}
variable "pubsubnet_id" {
  type        = string
  default     = "dummy"
  description = "Subnet ID"
}
variable "lb-sg-id" {
   type = string
   default="dummy"
}
variable "lb_instance_port" {
    default = 8080
    description = "Jenkins loadbalance listen port"
}
variable "instance-lb_protocol" {
   default = "http"
   description = "Instance and lb protocol"
}
variable "lb_port" {
    default = 80
    description = "lb listening port"
}
variable "healthy_threshold" {
    default = 2
}
variable "unhealthy_threshold" {
    default = 2
}
variable "timeout" {
    default = 3
}
variable "interval" {
    default = 30
  
}
variable "idle_timeout" {
    default = 400
}
variable "connection_draining_timeout" {
    default = 400
}
# variable "instance_id" {
#     default = "dummy"
# }