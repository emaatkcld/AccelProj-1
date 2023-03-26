#Create Security Group for Ansible
resource "aws_security_group" "ACPJ1_Ansible_SG" {
  name        = "${var.name}-Ansible-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_bastion_SG.id, aws_security_group.ACPJ1_Jenkins_SG.id]
  }

  # ingress {
  #   description = "Allow ssh access"
  #   from_port   = var.ssh_port
  #   to_port     = var.ssh_port
  #   protocol    = "tcp"
  #   security_groups = [aws_security_group.ACPJ1_Jenkins_SG.id]
  # }

   ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.local_port]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Ansible_SG"
  }
}

#Create Security Group for Docker Prod
resource "aws_security_group" "ACPJ1_Docker_Prod_SG" {
  name        = "${var.name}-Docker-Prod-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_bastion_SG.id]
  }

   ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_Ansible_SG.id]
  }

  ingress {
    description = "HTTPS"
    from_port   = var.secure_port
    to_port     = var.secure_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access] 
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_Docker_prod_ALB_SG.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Docker_Prod_SG"
  }
}

#Create Security Group for Docker Stage
resource "aws_security_group" "ACPJ1_Docker_Stage_SG" {
  name        = "${var.name}-Docker-Stage-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_bastion_SG.id]
  }

   ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_Ansible_SG.id]
  }

  ingress {
    description = "HTTP"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_Docker_stage_ALB_SG.id]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_Docker_stage_ALB_SG.id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Docker_Stage_SG"
  }
}

#Create Security Group for Jenkins
resource "aws_security_group" "ACPJ1_Jenkins_SG" {
  name        = "${var.name}-Jenkins-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_bastion_SG.id]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_Jenkins_ALB_SG.id] 
  }

  # ingress {
  #   description = "Allow inbound traffic"
  #   from_port   = var.http_port
  #   to_port     = var.http_port
  #   protocol    = "tcp"
  #   cidr_blocks = [var.all_access]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Jenkins_SG"
  }
}

#Create Security Group for Sonarqube
resource "aws_security_group" "ACPJ1_Sonarqube_SG" {
  name        = "${var.name}-Sonarqube-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.local_port]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port2
    to_port     = var.proxy_port2
    protocol    = "tcp"
    cidr_blocks = [var.local_port]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    security_groups = [aws_security_group.ACPJ1_Jenkins_SG.id]
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Sonarqube_SG"
  }
}

#Create Security Group for Docker Prod LB
resource "aws_security_group" "ACPJ1_Docker_prod_ALB_SG" {
  name        = "${var.name}-Docker-prod-ALB-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Docker-prod-ALB_SG"
  }
}

#Create Security Group for Docker Prod LB
resource "aws_security_group" "ACPJ1_Docker_stage_ALB_SG" {
  name        = "${var.name}-Docker-stage-ALB-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

   ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Docker-stage-ALB_SG"
  }
}

#Create Security Group for Jenkins LB
resource "aws_security_group" "ACPJ1_Jenkins_ALB_SG" {
  name        = "${var.name}-Jenkins-ALB-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Jenkins-LB_SG"
  }
}

#Create Security Group for Bastion
resource "aws_security_group" "ACPJ1_bastion_SG" {
  name        = "${var.name}-bastion-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.local_port]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-bastion_SG"
  }
}

#Backend SG - Database 
resource "aws_security_group" "ACPJ1_DB_Backend_SG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.test-vpc

  ingress {
    description = "MYSQL_port"
    from_port   = var.MYSQL_port
    to_port     = var.MYSQL_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-DB_Backend_SG"
  }
}


