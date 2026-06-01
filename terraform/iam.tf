# Developer IAM user
resource "aws_iam_user" "dev_view" {
  name = "bedrock-dev-view"
  tags = { Project = "karatu-2025-capstone" }
}

resource "aws_iam_user_policy_attachment" "readonly" {
  user       = aws_iam_user.dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_access_key" "dev_view" {
  user = aws_iam_user.dev_view.name
}

# Console login profile
resource "aws_iam_user_login_profile" "dev_view" {
  user                    = aws_iam_user.dev_view.name
  password_reset_required = false
}

# S3 PutObject permission for the assets bucket
resource "aws_iam_user_policy" "dev_s3" {
  name = "bedrock-dev-s3-putobject"
  user = aws_iam_user.dev_view.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:PutObject"]
      Resource = "arn:aws:s3:::bedrock-assets-${var.student_id}/*"
    }]
  })
}

# OIDC provider for service accounts (needed for LB Controller)
data "tls_certificate" "eks" {
  url = module.eks.cluster_oidc_issuer_url
}
resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = module.eks.cluster_oidc_issuer_url
}