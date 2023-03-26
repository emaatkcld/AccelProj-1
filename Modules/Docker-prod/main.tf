#Create Docker Host
resource "aws_instance" "Docker-Prod-Server" {
  ami                    = var.docker-ami
  instance_type          = var.inst-type
  vpc_security_group_ids = [var.docker-prod-sg]
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
    Name = "Docker-Prod"
  }
}

data "aws_secretsmanager_secret_version" "mycred" {
  secret_id = "dre-pass"
}

locals {
  ec2_creds =jsondecode(data.aws_secretsmanager_secret_version.mycred.secret_string)
}

### Creating Application Load Balancer for Docker lb
resource "aws_lb" "docker-prod-alb" {
  name               = var.docker-prod-lb-name
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [var.lb-prod-sg-id]
  subnets            = [var.pubsubnet_id1, var.pubsubnet_id2]
  enable_deletion_protection = false
  tags = {
    Name = var.docker-prod-lb-name
  }

}

# Creating the target group - Docker lb
resource "aws_lb_target_group" "docker-prod-tg" {
  name        = var.TG_name
  port        = var.port
  protocol    = var.tcp
  vpc_id      = var.vpc_id
  target_type = var.TG_type
  health_check {
    healthy_threshold   = 4
    unhealthy_threshold = 4
    timeout             = 5
    interval            = 45
  }
}
# Create Docker-PROD listener
resource "aws_lb_listener" "docker_prod_lb_listener" {
  load_balancer_arn = aws_lb.docker-prod-alb.arn
  port              = var.lb_listener-port
  protocol          = var.tcp
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = "${var.acm-certificate}"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.docker-prod-tg.arn
  }
}

# Create Docker Load balance target group attachement
resource "aws_lb_target_group_attachment" "PEP_attachmenet_TG" {
  target_group_arn = aws_lb_target_group.docker-prod-tg.arn
  target_id        = aws_instance.Docker-Prod-Server.id
  port             = var.port
}


