module "label" {
  source   = "cloudposse/label/null"
  name       = var.name
  context = var.context
}

module "label_courses" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = var.name_courses
}

module "label_authors" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = var.name_authors
}

module "get_all_courses_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = "get-all-courses"
  description = "Get all courses"
  handler = "index.handler"
  runtime = "nodejs12.x"
  source_path = "${path.module}/lambda_src/get_all_courses/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_courses_role_arn

  tags = module.label_courses.tags
}

module "get_all_authors_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = "get-all-authors"
  description = "Get all authors"
  handler = "index.handler"
  runtime = "nodejs12.x"
  source_path = "${path.module}/lambda_src/get_all_authors/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_authors_name
  }

  create_role = false
  lambda_role = var.lambda_authors_role_arn

  tags = module.label_authors.tags
}

module "get_course_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = "get-course"
  description = "Get course"
  handler = "index.handler"
  runtime = "nodejs12.x"
  source_path = "${path.module}/lambda_src/get_course/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_get_course_role_arn

  tags = module.label_courses.tags
}

module "create_course_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = "create-course"
  description = "Create course"
  handler = "index.handler"
  runtime = "nodejs12.x"
  source_path = "${path.module}/lambda_src/create_course/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_create_course_role_arn

  tags = module.label_courses.tags
}

module "update_course_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = "update-course"
  description = "Update course"
  handler = "index.handler"
  runtime = "nodejs12.x"
  source_path = "${path.module}/lambda_src/update_course/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_update_course_role_arn

  tags = module.label_courses.tags
}

module "delete_course_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = "delete-course"
  description = "Delete course"
  handler = "index.handler"
  runtime = "nodejs12.x"
  source_path = "${path.module}/lambda_src/delete_course/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_delete_course_role_arn

  tags = module.label_courses.tags
}
