output "ansible_privateip" {
    value = aws_instance.ansible-server.private_ip
  
}

output "ansible_id" {
    value = aws_instance.ansible-server.id
  
}