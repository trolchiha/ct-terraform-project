module "label" {
  source = "cloudposse/label/null"

  namespace   = var.namespace
  stage       = var.stage
  label_order = var.label_order
  environment = var.environment

}
