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


# module "jenkins" {
#   source      = "../modules/Jenkins"
#   ami         = var.ami
#   security_id = module.sg.jenkins-sg-id
#   prvsubnet   = module.vpc.prvsn1-id
#   key_name    = module.key-pair.keypair_id

# }

# module "Bastion" {
#   source      = "../modules/Bastion"
#   ami         = var.ami
#   security_id = module.sg.bastion-sg-id
#   pubsubnet   = module.vpc.pubsn1-id
#   key_name    = module.key-pair.keypair_id

# }

# module "sonarqube" {
#   source    = "../modules/sonarqube"
#   sona-ami  = var.ami
#   sona-sg   = module.sg.sonarqube-sg-id
#   pubsubnet = module.vpc.pubsn2-id
#   kp        = module.key-pair.keypair_id

# }

# module "docker" {
#   source     = "../modules/docker"
#   docker-ami = var.ami
#   docker-sg  = module.sg.docker-sg-id
#   prvsubnet  = module.vpc.prvsn2-id
#   kp         = module.key-pair.keypair_id

# }

# module "ansible" {
#   source         = "../modules/ansible"
#   ansible-ami    = var.ami
#   ansible-sg     = module.sg.ansible-sg-id
#   prvsubnet      = module.vpc.prvsn1-id
#   kp             = module.key-pair.keypair_id
#   docker_priv_ip = module.docker.Docker_privateip
#   iam-profile    = module.ec2_iam.iam-profile-name
#   QA_pubip       = module.QA.QA_publicip


# }

# resource "null_resource" "ansible_configure" {
#   connection {
#     type                = "ssh"
#     host                = module.ansible.ansible_privateip
#     user                = "ec2-user"
#     private_key         = file("~/key-pair/padeu2-kp")
#     bastion_host        = module.Bastion.bastion_publicip
#     bastion_user        = "ec2-user"
#     bastion_private_key = file("~/key-pair/padeu2-kp")
#   }
#   provisioner "file" {
#     source      = "~/09-JAN-Pet-Adoption-Containerisation-Ansible-Auto-discovery-Project---EU-Team-2/Dev/auto-discovery"
#     destination = "/home/ec2-user/auto-discovery"
#   }
#   provisioner "file" {
#     source      = "~/key-pair/padeu2-kp"
#     destination = "/home/ec2-user/padeu2-kp"
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo hostnamectl set-hostname ansible",
#       "sudo chmod 400 /home/ec2-user/padeu2-kp"
#     ]
#   }
# }

# module "jenkins_loadbalancer" {
#   source           = "../modules/jenkins_loadbalancer"
#   subnet_id        = module.vpc.pubsn1-id
#   securitygroup_id = module.sg.alb-sg-id
#   instance_id      = module.jenkins.jenkins_id

# }

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

# module "QA" {
#   source     = "../modules/QA"
#   docker-ami = var.ami
#   docker-sg  = module.sg.docker-sg-id
#   pubsn      = module.vpc.pubsn1-id
#   kp         = module.key-pair.keypair_id

# }

# module "jenkins-slave" {
#   source      = "../modules/jenkins-slave"
#   ami         = var.ami
#   security_id = module.sg.jenkins-sg-id
#   prvsubnet   = module.vpc.prvsn1-id
#   key_name    = module.key-pair.keypair_id

# }



