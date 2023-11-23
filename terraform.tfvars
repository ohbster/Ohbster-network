#By Obijah <ohbster@protonmail.com>

########
#Project Attributes
########

#The name to use for the resources
name = "Ohbster-Network"

#Set the region for the project
region = "us-east-1"

#######
#Network Settings
#######

#This is the CIDR for the vpc
cidr = "10.51.0.0/16"

#The number of public subnets
public_subnet_count = 3

#The number of private subnes
private_subnet_count = 3

#Instance settings
user_data = "./sample_userdata_debian.sh"

#How many instances you want to create
instance_count = 5

#If you want to ssh into instances, you must provide a valid key name
#Remember the key pairs are regional

#key_name = "<CHANGE ME TO A VALID KEYNAME IN THE REGION>"
key_name = null 


#Below is the list of ports you are opening in your instance security groups
port_list = [ 80,22,443 ]