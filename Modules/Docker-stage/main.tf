#Create Docker Host
resource "aws_instance" "Docker-Stage-Server" {
  ami                    = var.docker-ami
  instance_type          = var.inst-type
  vpc_security_group_ids = [var.docker-stage-sg]
  subnet_id              = var.prvsubnet
  key_name               = var.kp
  user_data              = <<-EOF
#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum install -y yum-utils
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
#Start docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
sudo hostnamectl set-hostname docker-prod-server
echo "${local.ec2_creds.surething}" >> /home/ec2-user/only.txt
sudo bash -c "echo 'strictHostKeyChecking No' >> /etc/ssh/ssh_config"
#Install New relic
echo "license_key: 19934c8af59dee4336ee880bff8a7f28c60cNRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/9/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
EOF
 tags = {
    Name = "Docker-Stage"
  }
}

data "aws_secretsmanager_secret_version" "mycred" {
  secret_id = "dre-pass"
}

locals {
  ec2_creds =jsondecode(data.aws_secretsmanager_secret_version.mycred.secret_string)
}

resource "aws_elb" "docker-stage-lb" {
  name            = var.docker-stage-lb-name
  subnets         = [var.pubsubnet_id]
  security_groups = [var.lb-stage-sg-id]

  listener {
    instance_port     = var.lb_instance_port
    instance_protocol = var.instance-lb_protocol
    lb_port           = var.lb_port
    lb_protocol       = var.instance-lb_protocol
  }

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    target              = "TCP:8080"
    interval            = var.interval
  }

  instances                   = [aws_instance.Docker-Stage-Server.id]
  cross_zone_load_balancing   = true
  idle_timeout                = var.idle_timeout
  connection_draining         = true
  connection_draining_timeout = var.connection_draining_timeout

  tags = {
    Name = var.docker-stage-lb-name
  }
}

