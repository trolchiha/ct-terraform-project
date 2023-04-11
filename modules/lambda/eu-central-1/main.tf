module "label" {
  source   = "cloudposse/label/null"
  name       = var.name
  context = var.context
}

module "get-all-authors" {
  source = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = "get-all-authors"
  description = "Get all authors"
  handler = "index.handler"
  runtime = "nodejs12.x"
  source_path = "${path.module}/src/get_all_authors/index.js"
  environment_variables = {
    TABLE_NAME = var.table_author_name
  }
 
  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect = "Allow"
      actions = [ "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:PutItem",
                "dynamodb:Scan",
                "dynamodb:UpdateItem"]
      resources = [var.table_author_arn]
    }
  }

 tags = module.label.tags

}