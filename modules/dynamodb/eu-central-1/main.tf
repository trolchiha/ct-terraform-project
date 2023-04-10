module "label" {
  source   = "cloudposse/label/null"
  name       = var.name
  context = var.context
}

resource "aws_dynamodb_table" "this" {
  name         = module.label.id
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
