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
