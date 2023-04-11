module "course" {
  source  = "./modules/dynamodb/eu-central-1"
  context = module.label.context
  name    = "course"
}

module "author" {
  source  = "./modules/dynamodb/eu-central-1"
  context = module.label.context
  name    = "author"
}

module "get-all-authors-lambda" {
  source            = "./modules/lambda/eu-central-1"
  context           = module.label.context
  name              = "author"
  table_author_name = module.author.table_name
  table_author_arn  = module.author.table_arn
}
