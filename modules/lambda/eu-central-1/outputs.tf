output "lambda_courses_invoke_arn" {
    value = module.get_all_courses_lambda.lambda_function_invoke_arn
}

output "lambda_authors_invoke_arn" {
    value = module.get_all_authors_lambda.lambda_function_invoke_arn
}

output "lambda_authors_function_name" {
    value = module.get_all_authors_lambda.lambda_function_name
}

output "lambda_courses_function_name" {
    value = module.get_all_courses_lambda.lambda_function_name
}

output "lambda_get_course_function_name" {
    value = module.get_course_lambda.lambda_function_name
}

output "lambda_create_course_function_name" {
    value = module.create_course_lambda.lambda_function_name
}

output "lambda_update_course_function_name" {
    value = module.update_course_lambda.lambda_function_name
}

output "lambda_delete_course_function_name" {
    value = module.delete_course_lambda.lambda_function_name
}

output "lambda_create_course_invoke_arn" {
    value = module.create_course_lambda.lambda_function_invoke_arn
}

output "lambda_update_course_invoke_arn" {
    value = module.update_course_lambda.lambda_function_invoke_arn
}

output "lambda_delete_course_invoke_arn" {
    value = module.delete_course_lambda.lambda_function_invoke_arn
}

output "lambda_get_course_invoke_arn" {
    value = module.get_course_lambda.lambda_function_invoke_arn
}

