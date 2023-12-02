#By Obijah <ohbster@protonmail.com>

########
#Project Attributes
########
#The name to use for the resources
name = "Ohbster-Network"
#Set the region for the project
regions = [{
  region = "us-east-1"
  cidr   = "10.51.0.0/16"
  },
  {
    region = "us-west-2"
    cidr   = "10.52.0.0/16"
}]
region  = "us-east-1"
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

#Add users / groups to this map.
group_list = {
  owners     = ["User1", "User2"]
  admins     = ["User3", "User4"]
  developers = ["User5"]
  users      = ["User6"]
}

#Add permissions / actions to the groups. Make sure they group names match the group list
action_map = {
  owners     = ["ec2:StartInstances", "ec2:StopInstances", "ec2:RebootInstances", "ec2:TerminateInstances"]
  admins     = ["ec2:StartInstances", "ec2:StopInstances", "ec2:RebootInstances"]
  developers = ["ec2:StartInstances", "ec2:StopInstances"]
  users      = ["ec2:StartInstances"]
}