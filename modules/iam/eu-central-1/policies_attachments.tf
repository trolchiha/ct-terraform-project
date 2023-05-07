resource "aws_iam_role_policy_attachment" "table_authors" {
  role       = aws_iam_role.table_authors.name
  policy_arn = aws_iam_policy.table_authors.arn
}

resource "aws_iam_role_policy_attachment" "table_courses" {
  role       = aws_iam_role.table_courses.name
  policy_arn = aws_iam_policy.table_courses.arn
}

resource "aws_iam_role_policy_attachment" "get_course" {
  role       = aws_iam_role.get_course.name
  policy_arn = aws_iam_policy.get_course.arn
}

resource "aws_iam_role_policy_attachment" "create_course" {
  role       = aws_iam_role.create_course.name
  policy_arn = aws_iam_policy.create_course.arn
}

resource "aws_iam_role_policy_attachment" "update_course" {
  role       = aws_iam_role.update_course.name
  policy_arn = aws_iam_policy.update_course.arn
}

resource "aws_iam_role_policy_attachment" "delete_course" {
  role       = aws_iam_role.delete_course.name
  policy_arn = aws_iam_policy.delete_course.arn
}
