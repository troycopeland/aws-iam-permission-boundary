provider "aws" {
  region = "us-east-1"
}


resource "aws_iam_policy" "boundary_policy" {
  name        = "iam-permission-boundary"
  description = "Prevents privilege escalation and S3 policy tampering"
  policy      = file("${path.module}/boundary-policy.json")
}

resource "aws_iam_role" "restricted_role" {
  name = "test-restricted-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  permissions_boundary = aws_iam_policy.boundary_policy.arn
}