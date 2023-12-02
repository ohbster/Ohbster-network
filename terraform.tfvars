#By Obijah <ohbster@protonmail.com>

########
#Project Attributes
########
#The name to use for the resources
name = "Ohbster-Network"
#Set the region for the project
regions = [ {
  region = "us-east-1"
  cidr = "10.51.0.0/16"
},
{
  region = "us-west-2"
  cidr = "10.52.0.0/16"
} ]
region = "us-east-1"
region2 = "us-west-2"
#common tags to apply to resources
common_tags = {
  Environment = "dev"
  Version     = ".1"
  Owner       = "ohbster@protonmail.com"
}

#######
#Network Settings
#######
#This is the CIDR for the vpc
cidr = "10.51.0.0/16"
#The number of public subnets
public_subnet_count = 3
#The number of private subnets
private_subnet_count = 3

#######
#Instance settings
#######
#User data script
user_data = "./sample_userdata_debian.sh"
#How many instances you want to create
instance_count = 5
#If you want to ssh into instances, you must provide a valid key name
#Remember the key pairs are regional
#key_name = "<CHANGE ME TO A VALID KEYNAME IN THE REGION>"
key_name = null
#Below is the list of ports you are opening in your instance security groups
port_list = [80, 22, 443]


###IAM###
iam_map = {
  "group_name" = "TheoClass-grp"
  "group_path" = "/TheoClass/"
}

user_list = ["test_user","test_admin","test_contributer","test_member"]
group_list = {
  group_a = ["User1", "User2"]
  group_b = ["User3", "User4"]
  group_c = ["User5"]
  group_d = ["User6"]
}
# groups = {
#   group_name = "group_a"
#   user_list = ["User1", "User2"]
# }
