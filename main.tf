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

module "lambda" {
    source = "./modules/lambda/eu-central-1"
    context = module.label.context
    name_authors = "authors"
    name_courses = "courses"
    table_authors_name = module.author.table_name
    table_authors_arn = module.author.table_arn
    table_courses_name = module.course.table_name
    table_courses_arn = module.course.table_arn
    lambda_courses_role_arn = module.iam.table_courses_role_arn
    lambda_authors_role_arn = module.iam.table_authors_role_arn
}

resource "aws_iam_user" "the-accounts" {
  for_each = toset( ["Todd", "James", "Alice", "Dottie"] )
  name     = "${module.label.id}-${each.key}"
}

module "iam" {
    source = "./modules/iam/eu-central-1"
    context = module.label.context
    name = "iam"
    table_authors_arn = module.author.table_arn
    table_courses_arn = module.course.table_arn
}