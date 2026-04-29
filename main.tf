resource "aws_s3_bucket" "jenkins_bucket" {
  bucket = var.S3BucketName
}

resource "aws_iam_role" "ec2_role" {
  name = "EC2_AdminRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2_AdminRole_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_Type
  key_name      = var.Key_Name
  vpc_security_group_ids = [aws_security_group.allow_8080.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = templatefile("${path.module}/aws-config.sh", {
    BucketName = aws_s3_bucket.jenkins_bucket.bucket
  })

  tags = var.tag_values
}