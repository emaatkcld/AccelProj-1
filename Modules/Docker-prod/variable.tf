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
variable "docker-prod-sg" {
    default = "dummy"
}

variable "docker-prod-lb-name" {
    default = "docker-prod-lb"
}

variable "lb-prod-sg-id" {
   type = string
   default="dummy"
}
variable "port" {
    default = 8080
    
}
variable "lb_type" {
    default = "application"
}

variable "pubsubnet_id1" {
    default = "application"
}

variable "pubsubnet_id2" {
    default = "application"
}
variable "TG_name" {
    default = "docker-prod-tg"
}

variable "tcp" {
    default = "HTTPS"
}

variable "vpc_id" {
    default = "vpc-0e956f11ebd3cd342"
}

variable "TG_type" {
    default = "instance"
}

variable "lb_listener-port" {
    default = 443
}
variable "acm-certificate" {
    default = "dummy"
}
