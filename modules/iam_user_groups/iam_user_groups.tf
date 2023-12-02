# module "iam_root_group" {
#   #count = var.toggle_map.iam_toggle ? 1 : 0
#   source = "../base_modules/iam/iam_group"
#   name = "TheoClassRootGroup"
#   #path = var.iam_map["group_path"]
# }


module "iam_user" {
  count = length(var.user_list)
  #count = length(var.user_list)
  source = "../base_modules/iam/iam_user"
  name = var.user_list[count.index]
  tags = var.tags
}

module "iam_group" {
  #count = var.toggle_map.iam_toggle ? 1 : 0
  source = "../base_modules/iam/iam_group"
  #for_each =  var.group_list
  name = "${var.name}" #"${var.iam_map["group_name"]}"
  path = var.path

  depends_on = [ module.iam_user ]
}

module "iam_memberships" {
  #count = length(var.user_list)
  source = "../base_modules/iam/iam_group_membership"
  #count = length(var.user_list)
  
  group = var.name

  user_list = var.user_list
  name = "${var.name}-membership"
  depends_on = [ module.iam_group ]
}

