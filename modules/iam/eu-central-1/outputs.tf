output "table_courses_role_arn" {
    value = aws_iam_role.table_courses.arn
}

output "table_authors_role_arn" {
    value = aws_iam_role.table_authors.arn
}

output "get_course_role_arn" {
    value = aws_iam_role.get_course.arn
}

output "create_course_role_arn" {
    value = aws_iam_role.create_course.arn
}

output "update_course_role_arn" {
    value = aws_iam_role.update_course.arn
}

output "delete_course_role_arn" {
    value = aws_iam_role.delete_course.arn
}
