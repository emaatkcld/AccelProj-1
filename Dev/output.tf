output "jenkins_ip" {
  value = module.Jenkins.jenkins_privateip
}
output "ansible-ip" {
  value = module.Ansible.ansible_privateip
}
output "bastion_publicip" {
  value = module.Bastion.Bastion_publicip
}
output "jenkins-lb-dns-name" {
    value = module.Jenkins.jenkins-lb
}
output "sonar_pub_ip" {
  value = module.Sonarqube.sonarqube_publicip
}
output "docker-prod-ip" {
  value = module.Docker-prod.Docker_privateip
}
output "docker-stage-ip" {
  value = module.Docker-stage.Docker_privateip
}
output "docker-prod-lb-dns-name" {
    value = module.Docker-prod.docker-prod-lb-name
}

output "docker-stage-lb-dns-name" {
    value = module.Docker-stage.docker-stage-lb-name
}
