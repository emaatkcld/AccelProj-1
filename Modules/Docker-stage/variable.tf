variable "docker-ami" {
    default = "dummy"
  
}

variable "inst-type" {
    default = "t3.medium"
  
}

variable "prvsubnet" {
    default = "dummy"
  
}

variable "kp" {
    default = "dummy"
  
}
variable "docker-stage-sg" {
    default = "dummy"
  
}

variable "docker-stage-ip" {
    default = "dummy"
  
}

variable "docker-stage-lb-name" {
    default = "docker-stage-lb"
}
variable "pubsubnet_id" {
  type        = string
  default     = "dummy"
  description = "Subnet ID"
}
variable "lb-stage-sg-id" {
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