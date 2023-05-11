module "label" {
  source = "cloudposse/label/null"

  namespace   = var.namespace
  stage       = var.stage
  label_order = var.label_order
  environment = var.environment

}

module "label_api" {
  source   = "cloudposse/label/null"

  name = "api"
  context = module.label.context
}
