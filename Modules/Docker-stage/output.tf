output "Docker_privateip" {
    value = aws_instance.Docker-Stage-Server.private_ip
}

output "Docker_stage_host_id" {
    value = aws_instance.Docker-Stage-Server.id
  
}

output "docker-stage-lb-name" {
  value = aws_elb.docker-stage-lb.dns_name
}

output "docker-prod-lb-zone-id" {
  value = aws_elb.docker-stage-lb.zone_id
}