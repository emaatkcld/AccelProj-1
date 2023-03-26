output "sonarqube_privateip" {
    value = aws_instance.sonarqube-server.private_ip
  
}

output "sonarqube_publicip" {
    value = aws_instance.sonarqube-server.public_ip
  
}


output "sonarqube_id" {
    value = aws_instance.sonarqube-server.id
  
}