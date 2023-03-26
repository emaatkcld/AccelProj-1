#Create Bastian Server
resource "aws_instance" "ACPJ1-Bastion" {
  ami                         = var.bastion-ami
  instance_type               = var.inst-type
  vpc_security_group_ids      = [var.bastion-sg]
  subnet_id                   = var.pubsubnet
  key_name                    = var.key_name
  associate_public_ip_address = true
  # user_data = <<-EOF
  # #!/bin/bash
  # echo "${var.keypair}" >> /home/ubuntu/acpj1-kp
  # sudo hostnamectl set-hostname bastion
  # sudo chmod 400 /home/ubuntu/acpj1-kp
  # EOF

  provisioner "file" {
    source      = "~/keypair/acpj1-kp"
    destination = "/home/ubuntu/acpj1-kp"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname bastion",
      "sudo chmod 400 /home/ubuntu/acpj1-kp"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/keypair/acpj1-kp")
    host        = self.public_ip
  }


  tags = {
    Name = "Bastion"
  }

  }