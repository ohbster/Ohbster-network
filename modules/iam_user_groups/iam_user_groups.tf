

module "iam_user" {
  count = length(var.user_list)
  source = "../base_modules/iam/iam_user"
  name = var.user_list[count.index]
  tags = var.tags
}

module "iam_group" {
  source = "../base_modules/iam/iam_group"
  name = "${var.name}" 
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
        Effect   = "Allow"
        Resource = "*"
        #This condition will only allow action on resources with the mff_id tag, which is unique to each terraform deployment
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
  source = "../base_modules/iam/iam_group_membership"
  group = var.name
  user_list = var.user_list
  name = "${var.name}-membership"
  depends_on = [ module.iam_group ]
}


module "login_profile" {
  source = "../base_modules/iam/iam_user_login_profile"
  count = length(var.user_list)
  user = var.user_list[count.index]

  depends_on = [ module.iam_user ]
}