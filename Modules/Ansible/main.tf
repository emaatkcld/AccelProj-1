resource "aws_instance" "ansible-server" {
  ami                         = var.ansible-ami
  instance_type               = var.inst-type
  key_name                    = var.kp
  vpc_security_group_ids      = [var.ansible-sg]
  subnet_id                   = var.prvsubnet
  associate_public_ip_address = true
  iam_instance_profile        = var.iam-profile
  user_data                   = <<-EOF
#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt-get update -y
sudo apt install docker.io -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y
echo "pubkeyAcceptKeyTypes=+ssh-rsa" >> /etc/ssh/sshd_config.d/10-insecure-rsa-keysig.conf
sudo systemctl reload sshd
sudo bash -c 'echo "strictHostKeyChecking No" >> /etc/sshd_config'
echo "${local.ec2_creds.surething}" >> /home/ubuntu/only.txt
sudo chmod 400 SSKEU1_prv
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/acpj1-kp
sudo chgrp ubuntu:ubuntu /home/ubuntu/.ssh/acpj1-kp
sudo chmod 400 /home/ubuntu/.ssh/acpj1-kp
sudo echo "localhost ansible_connection=local" > /etc/ansible/hosts
sudo echo "[docker_prod]" >> /etc/ansible/hosts
sudo echo "${var.docker-stage-ip} ansible_ssh_private_key_file=/home/ubuntu/.ssh/acpj1-kp" >> /etc/ansible/hosts
sudo echo "[docker_stage]" >> /etc/ansible/hosts
sudo echo "${var.docker-prod-ip} ansible_ssh_private_key_file=/home/ubuntu/.ssh/acpj1-kp" >> /etc/ansible/hosts
sudo chown -R ubuntu:ubuntu /etc/ansible
echo "${file(var.docker-image)}" >> /etc/ansible/docker-image.yml
echo "${file(var.docker-stage)}" >> /etc/ansible/docker-stage.yml
echo "${file(var.docker-prod)}" >> /etc/ansible/docker-prod.yml
echo "${file(var.Dockerfile)}" >> /etc/ansible/Dockerfile
sudo hostnamectl set-hostname Ansible
EOF

}


data "aws_secretsmanager_secret_version" "mycred" {
  secret_id = "dre-pass"
}

locals {
  ec2_creds =jsondecode(data.aws_secretsmanager_secret_version.mycred.secret_string)
}

# sudo yum update -y
# sudo dnf install python3 -y
# sudo yum install python3-pip -y
# sudo pip3 install boto boto3 botocore
# sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
# sudo yum install ansible -y
# sudo chown ec2-user:ec2-user /etc/ansible/hosts
# sudo chown -R ec2-user:ec2-user /etc/ansible && chmod +x /etc/ansible
# sudo hostnamectl set-hostname ansible
# sudo chmod 777 /etc/ansible/hosts
# sudo su echo "ec2-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# sudo bash -c 'echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
# sudo echo "[QA_Server]" >> /etc/ansible/hosts
# sudo echo "${var.QA_Server_prub_ip} ansible_user=ec2-user  ansible_ssh_private_key_file=/home/ec2-user/padeu2-kp" >> /etc/ansible/hosts
# sudo echo "[docker_host]" >> /etc/ansible/hosts
# sudo echo "${var.docker_priv_ip} ansible_user=ec2-user  ansible_ssh_private_key_file=/home/ec2-user/padeu2-kp" >> /etc/ansible/hosts
# echo "license_key: eu01xxbca018499adedd74cacda9d3d13e7dNRAL" | sudo tee -a /etc/newrelic-infra.yml
# sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/9/x86_64/newrelic-infra.repo
# sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
# sudo yum install newrelic-infra -y