resource "aws_key_pair" "ACPJ1_Key" {
  key_name   = var.key_name
  public_key = file(var.path_to_public_key)
}

