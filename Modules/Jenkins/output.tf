output "jenkins_privateip" {
    value = aws_instance.Jenkins-Server.private_ip
  
}

output "jenkins_id" {
    value = aws_instance.Jenkins-Server.id
  
}

output "jenkins-lb" {
    value = aws_elb.jenkins-lb.dns_name
}
