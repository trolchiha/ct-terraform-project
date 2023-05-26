data "aws_caller_identity" "this" {}

resource "aws_api_gateway_rest_api" "this" {
  name        = module.label_api.id
  description = "Created for educational purspose"
  endpoint_configuration {
    types = ["EDGE"]
  }
}

resource "aws_api_gateway_resource" "authors" {
  rest_api_id = aws_api_gateway_rest_api.this.id              
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id 
  path_part   = var.names[0]
}

# module "api-gateway-enable-cors-authors" {
#   source          = "squidfunk/api-gateway-enable-cors/aws"
#   version         = "0.3.3"
#   api_id          = aws_api_gateway_rest_api.this.id
#   api_resource_id = aws_api_gateway_resource.authors.id //api_resource_id - API resource identifier
# }

//get-all-authors

resource "aws_api_gateway_method" "get_all_authors" {
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.authors.id 
  rest_api_id   = aws_api_gateway_rest_api.this.id 
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_all_authors_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.authors.id
  http_method             = aws_api_gateway_method.get_all_authors.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_authors_invoke_arn
  depends_on = [
    aws_api_gateway_method.get_all_authors
  ]
}

resource "aws_api_gateway_integration_response" "get_all_authors" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_all_authors.http_method
  status_code = aws_api_gateway_method_response.get_all_authors.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_method_response" "get_all_authors" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.authors.id
  http_method     = aws_api_gateway_method.get_all_authors.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_lambda_permission" "get_all_authors" {
  statement_id  = "AllowExecutionFromAPIGatewayForGet${var.names[0]}"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_authors_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:eu-central-1:${data.aws_caller_identity.this.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.get_all_authors.http_method}${aws_api_gateway_resource.authors.path}"
}

resource "aws_api_gateway_resource" "courses" {
  rest_api_id = aws_api_gateway_rest_api.this.id              
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id 
  path_part   = var.names[1]
}

# module "api-gateway-enable-cors-courses" {
#   source          = "squidfunk/api-gateway-enable-cors/aws"
#   version         = "0.3.3"
#   api_id          = aws_api_gateway_rest_api.this.id
#   api_resource_id = aws_api_gateway_resource.courses.id //api_resource_id - API resource identifier
# }

resource "aws_api_gateway_resource" "course" {
  rest_api_id = aws_api_gateway_rest_api.this.id               
  parent_id   = aws_api_gateway_resource.courses.id 
  path_part   = "{id}"
}

# module "api-gateway-enable-cors-course" {
#   source          = "squidfunk/api-gateway-enable-cors/aws"
#   version         = "0.3.3"
#   api_id          = aws_api_gateway_rest_api.this.id
#   api_resource_id = aws_api_gateway_resource.course.id //api_resource_id - API resource identifier
# }

//get-all-courses

resource "aws_api_gateway_method" "get_all_courses" {
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.courses.id 
  rest_api_id   = aws_api_gateway_rest_api.this.id 
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_all_courses_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.courses.id
  http_method             = aws_api_gateway_method.get_all_courses.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_courses_invoke_arn
  depends_on = [
    aws_api_gateway_method.get_all_courses
  ]
}

resource "aws_api_gateway_integration_response" "get_all_courses" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_all_courses.http_method
  status_code = aws_api_gateway_method_response.get_all_courses.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_method_response" "get_all_courses" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.courses.id
  http_method     = aws_api_gateway_method.get_all_courses.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }

   response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_lambda_permission" "get_all_courses" {
  statement_id  = "AllowExecutionFromAPIGatewayForGetAll${var.names[1]}"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_courses_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:eu-central-1:${data.aws_caller_identity.this.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.get_all_courses.http_method}${aws_api_gateway_resource.courses.path}"
}

//get-course

resource "aws_api_gateway_method" "get_course" {
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.course.id 
  rest_api_id   = aws_api_gateway_rest_api.this.id
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_course_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.course.id
  http_method             = aws_api_gateway_method.get_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_get_course_invoke_arn
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = file("./models-in-json/get-course-model.json")
  }

     depends_on = [
    aws_api_gateway_integration.get_course_lambda
  ]
}

resource "aws_api_gateway_integration_response" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.course.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = aws_api_gateway_method_response.get_course.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,OPTIONS,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_method_response" "get_course" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.course.id
  http_method     = aws_api_gateway_method.get_course.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }

   response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_lambda_permission" "get_course" {
  statement_id  = "AllowExecutionFromAPIGatewayForUpdate${title(var.names[2])}"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_get_course_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:eu-central-1:${data.aws_caller_identity.this.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.get_course.http_method}${aws_api_gateway_resource.courses.path}/*"
}

// create-course

resource "aws_api_gateway_method" "create_course" {
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.courses.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "create_course_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.courses.id
  http_method             = aws_api_gateway_method.create_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_create_course_invoke_arn

    depends_on = [
    aws_api_gateway_method.create_course
  ]
}

resource "aws_api_gateway_integration_response" "create_course" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.create_course.http_method
  status_code = aws_api_gateway_method_response.create_course.status_code

  depends_on = [
    aws_api_gateway_integration.create_course_lambda
  ]

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_method_response" "create_course" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.courses.id
  http_method     = aws_api_gateway_method.create_course.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_model" "course_model" {
  rest_api_id  = aws_api_gateway_rest_api.this.id
  name         = "create${var.names[2]}"
  description  = "a JSON schema"
  content_type = "application/json"

  schema = file("./models-in-json/save-course-model.json")
}

resource "aws_lambda_permission" "create_course" {
  statement_id  = "AllowExecutionFromAPIGatewayForSave${title(var.names[2])}"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_create_course_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:eu-central-1:${data.aws_caller_identity.this.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.create_course.http_method}${aws_api_gateway_resource.courses.path}"
}

//update-course

resource "aws_api_gateway_method" "update_course" {
  http_method   = "PUT"
  resource_id   = aws_api_gateway_resource.course.id 
  rest_api_id   = aws_api_gateway_rest_api.this.id 
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "update_course_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.course.id
  http_method             = aws_api_gateway_method.update_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_update_course_invoke_arn
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = file("./models-in-json/update-course-model.json")
  }

    depends_on = [
    aws_api_gateway_method.update_course
  ]
}

resource "aws_api_gateway_integration_response" "update_course" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.course.id
  http_method = aws_api_gateway_method.update_course.http_method
  status_code = aws_api_gateway_method_response.update_course.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,OPTIONS,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_method_response" "update_course" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.course.id
  http_method     = aws_api_gateway_method.update_course.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }

   response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_lambda_permission" "update_course" {
  statement_id  = "AllowExecutionFromAPIGatewayForUpdate${title(var.names[2])}"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_update_course_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:eu-central-1:${data.aws_caller_identity.this.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.update_course.http_method}${aws_api_gateway_resource.courses.path}/*"
}

//delete-course

resource "aws_api_gateway_method" "delete_course" {
  http_method   = "DELETE"
  resource_id   = aws_api_gateway_resource.course.id де 
  rest_api_id   = aws_api_gateway_rest_api.this.id 
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "delete_course_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.course.id
  http_method             = aws_api_gateway_method.delete_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_delete_course_invoke_arn
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = file("./models-in-json/delete-course-model.json")
  }

  depends_on = [
    aws_api_gateway_method.delete_course
  ]
}

resource "aws_api_gateway_integration_response" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.course.id
  http_method = aws_api_gateway_method.delete_course.http_method
  status_code = aws_api_gateway_method_response.delete_course.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,OPTIONS,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_method_response" "delete_course" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.course.id
  http_method     = aws_api_gateway_method.delete_course.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_lambda_permission" "delete_course" {
  statement_id  = "AllowExecutionFromAPIGatewayForDelete${title(var.names[2])}"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_delete_course_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:eu-central-1:${data.aws_caller_identity.this.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.delete_course.http_method}${aws_api_gateway_resource.courses.path}/*"
}

//stage

resource "aws_api_gateway_stage" "this" {
  deployment_id = "iyld4s"
  # aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "${var.environment}-server"
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }
  lifecycle {
    create_before_destroy = true
  }
}

// cors_authors

resource "aws_api_gateway_method" "cors_authors" {
  api_key_required = false
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = aws_api_gateway_resource.authors.id
  rest_api_id      = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_integration" "cors_authors" {
  http_method = "OPTIONS"
  resource_id = aws_api_gateway_resource.authors.id
  rest_api_id = aws_api_gateway_rest_api.this.id
  type        = "MOCK"
  
  connection_type  = "INTERNET"
  content_handling = "CONVERT_TO_TEXT"

  request_templates = {
    "application/json" = jsonencode(
      {
        statusCode = 200
      }
    )
  }
  timeout_milliseconds = 29000

  depends_on = [
    aws_api_gateway_method.cors_authors
  ]
}

resource "aws_api_gateway_method_response" "cors_authors" {
  http_method = "OPTIONS"
  resource_id = aws_api_gateway_resource.authors.id
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false
    "method.response.header.Access-Control-Allow-Methods" = false
    "method.response.header.Access-Control-Allow-Origin"  = false
    "method.response.header.Access-Control-Max-Age"       = true
  }
  rest_api_id = aws_api_gateway_rest_api.this.id
  status_code = "200"

  depends_on = [
    aws_api_gateway_integration.cors_authors
  ]
}

resource "aws_api_gateway_integration_response" "cors_authors" {
  http_method = "OPTIONS"
  resource_id = aws_api_gateway_resource.authors.id
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Max-Age"       = "'7200'"
  }
  rest_api_id = aws_api_gateway_rest_api.this.id
  status_code = "200"

  depends_on = [
    aws_api_gateway_method_response.cors_authors
  ]
}

// cors_courses

resource "aws_api_gateway_method" "cors_courses" {
  api_key_required = false
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = aws_api_gateway_resource.courses.id
  rest_api_id      = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_integration" "cors_courses" {
  http_method = "OPTIONS"
  resource_id = aws_api_gateway_resource.courses.id
  rest_api_id = aws_api_gateway_rest_api.this.id
  type        = "MOCK"

  connection_type  = "INTERNET"
  content_handling = "CONVERT_TO_TEXT"

  request_templates = {
    "application/json" = jsonencode(
      {
        statusCode = 200
      }
    )
  }
  timeout_milliseconds = 29000

  depends_on = [
    aws_api_gateway_method.cors_courses
  ]
}

resource "aws_api_gateway_method_response" "cors_courses" {
  http_method = "OPTIONS"
  resource_id = aws_api_gateway_resource.courses.id
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false
    "method.response.header.Access-Control-Allow-Methods" = false
    "method.response.header.Access-Control-Allow-Origin"  = false
    "method.response.header.Access-Control-Max-Age"       = true
  }
  rest_api_id = aws_api_gateway_rest_api.this.id
  status_code = "200"

  depends_on = [
    aws_api_gateway_integration.cors_courses
  ]
}

resource "aws_api_gateway_integration_response" "cors_courses" {
  http_method = "OPTIONS"
  resource_id = aws_api_gateway_resource.courses.id
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Max-Age"       = "'7200'"
  }
  rest_api_id = aws_api_gateway_rest_api.this.id
  status_code = "200"

  depends_on = [
    aws_api_gateway_method_response.cors_courses
  ]
}

// cors_course

resource "aws_api_gateway_method" "cors_course" {
  api_key_required = false
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = aws_api_gateway_resource.course.id
  rest_api_id      = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_integration" "cors_course" {
  http_method = "OPTIONS"
  resource_id = aws_api_gateway_resource.course.id
  rest_api_id = aws_api_gateway_rest_api.this.id
  type        = "MOCK"

  connection_type  = "INTERNET"
  content_handling = "CONVERT_TO_TEXT"

  request_templates = {
    "application/json" = jsonencode(
      {
        statusCode = 200
      }
    )
  }
  timeout_milliseconds = 29000

  depends_on = [
    aws_api_gateway_method.cors_course
  ]
}

resource "aws_api_gateway_method_response" "cors_course" {
  http_method = "OPTIONS"
  resource_id = aws_api_gateway_resource.course.id
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false
    "method.response.header.Access-Control-Allow-Methods" = false
    "method.response.header.Access-Control-Allow-Origin"  = false
    "method.response.header.Access-Control-Max-Age"       = true
  }
  rest_api_id = aws_api_gateway_rest_api.this.id
  status_code = "200"

  depends_on = [
    aws_api_gateway_integration.cors_course
  ]
}

resource "aws_api_gateway_integration_response" "cors_course" {
  http_method = "OPTIONS"
  resource_id = aws_api_gateway_resource.course.id
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,OPTIONS,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Max-Age"       = "'7200'"
  }
  rest_api_id = aws_api_gateway_rest_api.this.id
  status_code = "200"

  depends_on = [
    aws_api_gateway_method_response.cors_course
  ]
}
