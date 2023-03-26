output "ACPJ1-docker-prod-ami" {
    value = aws_ami_from_instance.ACPJ1-ami.id
  
}