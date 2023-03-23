output "vpc_id" {
    value = aws_vpc.ACPJ1_VPC.id
}

output "pubsn1-id" {
  value = aws_subnet.ACPJ1_Pub_SN1.id
}

output "pubsn2-id" {
  value = aws_subnet.ACPJ1_Pub_SN2.id
}
output "prvsn1-id" {
  value = aws_subnet.ACPJ1_Priv_SN1.id
}

output "prvsn2-id" {
  value = aws_subnet.ACPJ1_Priv_SN2.id
}