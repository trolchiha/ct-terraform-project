data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "table_authors" {
  name               = module.label_table_authors.id
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role" "table_courses" {
  name               = module.label_table_courses.id
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role" "get_course" {
  name               = module.label_get_course.id
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role" "create_course" {
  name               = module.label_create_course.id
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role" "update_course" {
  name               = module.label_update_course.id
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role" "delete_course" {
  name               = module.label_delete_course.id
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
