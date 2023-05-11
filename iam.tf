# data "aws_iam_policy_document" "example" {
#   statement {
#     sid = "1"

#     actions = [
#       "s3:ListAllMyBuckets",
#       "s3:GetBucketLocation",
#     ]

#     resources = [
#       "arn:aws:s3:::*",
#     ]
#   }

#   statement {
#     actions = [
#       "s3:ListBucket",
#     ]

#     resources = [
#       aws_s3_bucket.this.arn
#     ]

#     condition {
#       test     = "StringLike"
#       variable = "s3:prefix"

#       values = [
#         "",
#         "home/",
#         "home/&{aws:username}/",
#       ]
#     }
#   }

#   statement {
#     actions = [
#       "s3:*",
#     ]

#     resources = [
#       "${aws_s3_bucket.this.arn}/home/&{aws:username}",
#       "${aws_s3_bucket.this.arn}/home/&{aws:username}/*",
#     ]
#   }
# }

# resource "aws_iam_policy" "example" {
# #   name   = module.label.id
#   name   = "${module.label.id}-s3"
#   path   = "/"
#   policy = data.aws_iam_policy_document.example.json

# }



# data "aws_iam_policy_document" "instance_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "instance" {
#   count = var.instance_role_enabled ? 1 : 0
#   name               = "instance_role-${count.index}"
#   path               = "/system/"
#   assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
# }

# resource "aws_iam_role_policy_attachment" "test-attach" {
#   role       = aws_iam_role.instance.name
#   policy_arn = aws_iam_policy.example.arn
# }

# resource "aws_lambda_permission" "allow_api_gateway_get_all_authors" {
#   statement_id  = "AllowExecutionFromAPIGateWay"
#   action        = "lambda:InvokeFunction"
#   function_name = module.lambda.lambda_authors_function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/GET${aws_api_gateway_resource.authors.path}"
#   # qualifier     = aws_lambda_alias.test_alias.name
# }

# resource "aws_lambda_permission" "allow_api_gateway_get_all_courses" {
#   statement_id  = "AllowExecutionFromAPIGateWay"
#   action        = "lambda:InvokeFunction"
#   function_name = module.lambda.lambda_courses_function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/POST${aws_api_gateway_resource.courses.path}"
#   # qualifier     = aws_lambda_alias.test_alias.name
# }

# resource "aws_lambda_permission" "allow_api_gateway_get_course" {
#   statement_id  = "AllowExecutionFromAPIGateWay"
#   action        = "lambda:InvokeFunction"
#   function_name = module.lambda.lambda_get_course_function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/GET${aws_api_gateway_resource.courses.path}"
#   # qualifier     = aws_lambda_alias.test_alias.name
# }

# resource "aws_lambda_permission" "allow_api_gateway_create_course" {
#   statement_id  = "AllowExecutionFromAPIGateWay"
#   action        = "lambda:InvokeFunction"
#   function_name = module.lambda.lambda_create_course_function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/POST${aws_api_gateway_resource.courses.path}"
#   # qualifier     = aws_lambda_alias.test_alias.name
# }

# resource "aws_lambda_permission" "allow_api_gateway_update_course" {
#   statement_id  = "AllowExecutionFromAPIGateWay"
#   action        = "lambda:InvokeFunction"
#   function_name = module.lambda.lambda_update_course_function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/GET${aws_api_gateway_resource.courses.path}"
#   # qualifier     = aws_lambda_alias.test_alias.name
# }

# resource "aws_lambda_permission" "allow_api_gateway_delete_course" {
#   statement_id  = "AllowExecutionFromAPIGateWay"
#   action        = "lambda:InvokeFunction"
#   function_name = module.lambda.lambda_delete_course_function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/GET${aws_api_gateway_resource.courses.path}"
#   # qualifier     = aws_lambda_alias.test_alias.name
# }