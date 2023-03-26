#Create Jenkins Server
resource "aws_instance" "Jenkins-Server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.security_id]
  subnet_id                   = var.prvsubnet
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = <<-EOF
#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum update -y
sudo yum install java-11-openjdk-devel git -y
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum update -y
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo su - ec2-user -c "ssh-keygen -t ecdsa -m PEM -f ~/.ssh/id_rsa3 -N ''"
sudo bash -c 'echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins
sudo hostnamectl set-hostname Jenkins
echo "license_key: eu01xxbca018499adedd74cacda9d3d13e7dNRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/9/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y

EOF

tags = {
    Name = "Jenkins"
  }

}


resource "aws_elb" "jenkins-lb" {
  name            = var.jenkins-lb-name
  subnets         = [var.pubsubnet_id]
  security_groups = [var.lb-sg-id]

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

  instances                   = [aws_instance.Jenkins-Server.id]
  cross_zone_load_balancing   = true
  idle_timeout                = var.idle_timeout
  connection_draining         = true
  connection_draining_timeout = var.connection_draining_timeout

  tags = {
    Name = var.jenkins-lb-name
  }
}
    