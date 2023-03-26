output "Docker_privateip" {
    value = aws_instance.Docker-Prod-Server.private_ip
  
}

output "Docker_host_id" {
    value = aws_instance.Docker-Prod-Server.id
  
}

output "docker-prod-lb-name" {
  value = aws_lb.docker-prod-alb.dns_name
}

output "docker-prod-lb-zone-id" {
  value = aws_lb.docker-prod-alb.zone_id
}

