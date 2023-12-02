

module "iam_user" {
  count = length(var.user_list)
  source = "../base_modules/iam/iam_user"
  name = var.user_list[count.index]
  tags = var.tags
  #path = module.iam_group[0].path
}

