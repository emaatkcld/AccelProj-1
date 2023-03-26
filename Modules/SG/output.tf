output "ansible-sg-id" {
  value = aws_security_group.ACPJ1_Ansible_SG.id
}

output "docker-prod-sg-lb" {
  value = aws_security_group.ACPJ1_Docker_prod_ALB_SG.id
}

output "docker-prod-sg-id" {
  value = aws_security_group.ACPJ1_Docker_Prod_SG.id
}

output "docker-stage-sg-id" {
  value = aws_security_group.ACPJ1_Docker_Stage_SG.id
}

output "docker-stage-sg-lb" {
  value = aws_security_group.ACPJ1_Docker_stage_ALB_SG.id
}

output "jenkins-sg-id" {
  value = aws_security_group.ACPJ1_Jenkins_SG.id
}

output "jenkins-sg-lb" {
  value = aws_security_group.ACPJ1_Jenkins_ALB_SG.id
}

output "sonarqube-sg-id" {
  value = aws_security_group.ACPJ1_Sonarqube_SG.id
}

output "mysql-sg-id" {
  value = aws_security_group.ACPJ1_DB_Backend_SG.id
}

# output "alb-sg-id" {
#   value = aws_security_group.ACPJ1_ALB_SG.id
# }

output "bastion-sg-id" {
  value = aws_security_group.ACPJ1_bastion_SG.id
}

