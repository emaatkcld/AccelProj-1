variable "bastion-ami" {
    default = "ami-0aaa5410833273cfe"
}

variable "inst-type" {
    default = "t2.micro"
  
}

variable "pubsubnet" {
    default = "dummy"
  
}

variable "key_name" {
    default = "dummy"
  
}
variable "bastion-sg" {
    default = "dummy"
  
}

variable "keypair" {
  default = "~/keypair/acpj1-kp"

}



