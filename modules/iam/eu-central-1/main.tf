module "label_table_authors" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = "${var.name}-table-authors"
}

module "label_table_courses" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = "${var.name}-table-courses"
}

module "label_get_course" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = "${var.name}-get-course"
}

module "label_create_course" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = "${var.name}-create-course"
}

module "label_update_course" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = "${var.name}-update-course"
}

module "label_delete_course" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = "${var.name}-delete-course"
}
