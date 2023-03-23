resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = aws_iam_role.ec2_role.id

  policy = "${file("../Modules/ec2_iam/ec2-policy.json")}"
  
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = "${file("../Modules/ec2_iam/ec2-assume.json")}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}