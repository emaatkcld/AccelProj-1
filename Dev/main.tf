module "vpc" {
  source = "../Modules/VPC"
}

module "sg" {
  source   = "../Modules/SG"
  test-vpc = module.vpc.vpc_id
}

module "key-pair" {
  source = "../Modules/key-pair"

}

module "ec2_iam" {
  source = "../Modules/ec2_iam"

}


module "Jenkins" {
  source      = "../Modules/Jenkins"
  ami         = var.ami
  security_id = module.sg.jenkins-sg-id
  prvsubnet   = module.vpc.prvsn1-id
  key_name    = module.key-pair.keypair_id
  pubsubnet_id   = module.vpc.pubsn1-id
  lb-sg-id = module.sg.jenkins-sg-lb

}


module "Bastion" {
  source      = "../Modules/Bastion"
  bastion-sg = module.sg.bastion-sg-id
  pubsubnet   = module.vpc.pubsn1-id
  key_name    = module.key-pair.keypair_id

}

module "Sonarqube" {
  source    = "../Modules/Sonarqube"
  sona-ami  = var.ami
  sona-sg   = module.sg.sonarqube-sg-id
  pubsubnet = module.vpc.pubsn2-id
  kp        = module.key-pair.keypair_id

}


module "Docker-prod" {
  source     = "../Modules/Docker-prod"
  docker-ami = var.ami
  docker-prod-sg  = module.sg.docker-prod-sg-id
  prvsubnet  = module.vpc.prvsn2-id
  kp         = module.key-pair.keypair_id
  pubsubnet_id1   = module.vpc.pubsn1-id
  pubsubnet_id2   = module.vpc.pubsn2-id
  lb-prod-sg-id = module.sg.docker-prod-sg-lb
  vpc_id = module.vpc.vpc_id
  acm-certificate = module.Route53ACM.acm_cert_arn
}

module "Docker-stage" {
  source     = "../Modules/Docker-stage"
  docker-ami = var.ami
  docker-stage-sg  = module.sg.docker-stage-sg-id
  prvsubnet  = module.vpc.prvsn2-id
  kp         = module.key-pair.keypair_id
  pubsubnet_id   = module.vpc.pubsn1-id
  lb-stage-sg-id = module.sg.docker-stage-sg-lb

}



module "Route53ACM" {
  source = "../Modules/Route53"
  docker-prod-lb-dns = module.Docker-prod.docker-prod-lb-name
  docker-prod-lb-zone-id = module.Docker-prod.docker-prod-lb-zone-id
}

module "Ansible" {
  source         = "../Modules/Ansible"
  ansible-sg     = module.sg.ansible-sg-id
  prvsubnet      = module.vpc.prvsn1-id
  kp             = module.key-pair.keypair_id
  docker-prod-ip = module.Docker-prod.Docker_privateip
  docker-stage-ip = module.Docker-stage.Docker_privateip
  iam-profile    = module.ec2_iam.iam-profile-name
  docker-image = "../Modules/Ansible/docker-image.yml"
  docker-stage = "../Modules/Ansible/docker-stage.yml"
  docker-prod = "../Modules/Ansible/docker-prod.yml"
  Dockerfile = "../Modules/Ansible/Dockerfile"
  
}

resource "null_resource" "ansible_configure" {
  connection {
    type                = "ssh"
    host                = module.Ansible.ansible_privateip
    user                = "ubuntu"
    private_key         = file("~/keypair/acpj1-kp")
    bastion_host        = module.Bastion.Bastion_publicip
    bastion_user        = "ubuntu"
    bastion_private_key = file("~/keypair/acpj1-kp")
  }
  # provisioner "file" {
  #   source      = "../Modules/Ansible/docker-image.yml"
  #   destination = "/home/ubuntu/docker-image.yml"
  # }

  # provisioner "file" {
  #   source      = "../Modules/Ansible/docker-prod.yml"
  #   destination = "/home/ubuntu/docker-prod.yml"
  # }

  # provisioner "file" {
  #   source      = "../Modules/Ansible/docker-stage.yml"
  #   destination = "/home/ubuntu/docker-stage.yml"
  # }

  # provisioner "file" {
  #   source      = "../Modules/Ansible/Dockerfile"
  #   destination = "/home/ubuntu/Dockerfile"
  # }

  provisioner "file" {
    source      = "~/keypair/acpj1-kp"
    destination = "/home/ubuntu/.ssh/acpj1-kp"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ansible",
      "sudo chmod 400 /home/ubuntu/.ssh/acpj1-kp"
    ]
  }
}


# module "alb" {
#   source      = "../modules/alb"
#   vpc-id      = module.vpc.vpc_id
#   docker-host = module.docker.Docker_host_id
#   alb-sg      = module.sg.alb-sg-id
#   prvsn1      = module.vpc.prvsn1-id
#   prvsn2      = module.vpc.prvsn2-id


# }

# module "launch-config" {
#   source             = "../modules/launch-config"
#   inst-type          = var.instance_type
#   source-instance-id = module.docker.Docker_host_id
#   lc-sg              = module.sg.docker-sg-id
#   inst-kp            = module.key-pair.keypair_id

# }

# module "asg" {
#   source  = "../modules/asg"
#   lc-name = module.launch-config.lc-name
#   prvsn1  = module.vpc.prvsn1-id
#   prvsn2  = module.vpc.prvsn2-id
#   tg-arn  = module.alb.padeu2-tg-arn

# }





