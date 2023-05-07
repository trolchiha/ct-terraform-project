data "aws_iam_policy_document" "table_authors" {
  statement {
    actions = [
      "dynamodb:Scan",
    ]

    resources = [
      var.table_authors_arn
    ]
  }
}

resource "aws_iam_policy" "table_authors" {
  name   = module.label_table_authors.id
  path   = "/"
  policy = data.aws_iam_policy_document.table_authors.json

}

data "aws_iam_policy_document" "table_courses" {
  statement {
    actions = [
      "dynamodb:Scan",
    ]

    resources = [
      var.table_courses_arn
    ]
  }
}

resource "aws_iam_policy" "table_courses" {
  name   = module.label_table_courses.id
  path   = "/"
  policy = data.aws_iam_policy_document.table_courses.json

}

data "aws_iam_policy_document" "get_course" {
  statement {
    actions = [
        "dynamodb:GetItem",
    ]

    resources = [
      var.table_courses_arn
    ]
  }
}

resource "aws_iam_policy" "get_course" {
  name   = module.label_get_course.id
  path   = "/"
  policy = data.aws_iam_policy_document.get_course.json

}

data "aws_iam_policy_document" "create_course" {
  statement {
    actions = [
        "dynamodb:PutItem",
    ]

    resources = [
      var.table_courses_arn
    ]
  }
}

resource "aws_iam_policy" "create_course" {
  name   = module.label_create_course.id
  path   = "/"
  policy = data.aws_iam_policy_document.create_course.json

}

data "aws_iam_policy_document" "update_course" {
  statement {
    actions = [
        "dynamodb:PutItem",
    ]

    resources = [
      var.table_courses_arn
    ]
  }
}

resource "aws_iam_policy" "update_course" {
  name   = module.label_update_course.id
  path   = "/"
  policy = data.aws_iam_policy_document.update_course.json

}

data "aws_iam_policy_document" "delete_course" {
  statement {
    actions = [
        "dynamodb:DeleteItem",
    ]

    resources = [
      var.table_courses_arn
    ]
  }
}

resource "aws_iam_policy" "delete_course" {
  name   = module.label_delete_course.id
  path   = "/"
  policy = data.aws_iam_policy_document.delete_course.json

}
