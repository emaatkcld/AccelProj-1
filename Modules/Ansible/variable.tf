variable "ansible-ami" {
    default = "ami-0aaa5410833273cfe"
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
variable "ansible-sg" {
    default = "dummy"
}
variable "docker-priv-ip" {
    default = "dummy"  
}
variable "docker-prod-ip" {
    default = "dummmy"
}
variable "iam-profile" {
    default = "dummy"
  
}
variable "docker-stage-ip" {
    default = "dummmy"
}

variable "docker-image" {
  default = ""

}

variable "docker-stage" {
  default = ""

}

variable "docker-prod" {
  default = ""

}

variable "Dockerfile" {
  default = ""

}