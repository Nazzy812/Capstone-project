output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "region" {
  value = var.region
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "assets_bucket_name" {
  value = aws_s3_bucket.assets.bucket
}

output "dev_access_key_id" {
  value     = aws_iam_access_key.dev_view.id
  sensitive = true
}

output "dev_secret_access_key" {
  value     = aws_iam_access_key.dev_view.secret
  sensitive = true
}

output "dev_console_password" {
  value     = aws_iam_user_login_profile.dev_view.password
  sensitive = true
}