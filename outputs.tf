# output "id" {
#   value = aws_s3_bucket.this.id
# }

# output "arn" {
#   value = aws_s3_bucket.this.arn
# }

# output "bucket_domain_name" {
#   value = aws_s3_bucket.s3_bucket_frontend.bucket_domain_name
# }

output "gateway_deployment_invoke_url" {
    value = aws_api_gateway_deployment.this.invoke_url
}

output "aws_api_gateway_stage_invoke_url" {
    value = aws_api_gateway_stage.this.invoke_url
}