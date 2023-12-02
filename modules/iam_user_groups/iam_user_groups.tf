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

resource "aws_iam_group_policy" "group_policy" {
  name = "${var.name}-policy"
  group = var.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "${var.permission_list}"
        # Action = [
        #   #"ec2:Describe*",
        #   "ec2:StartInstances",
        #   "ec2:StopInstances",
        # ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {"aws:ResourceTag/mff_id" = "${var.tags["mff_id"]}"}
        }
      },
   
    {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
    }],
  })

  depends_on = [ module.iam_group ]
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

# resource "aws_iam_user_login_profile" "login" {
#   count = length(var.user_list)
#   user = var.user_list[count.index]

#   depends_on = [ module.iam_user ]
# }
module "login_profile" {
  source = "../base_modules/iam/iam_user_login_profile"
  count = length(var.user_list)
  user = var.user_list[count.index]

  depends_on = [ module.iam_user ]
}