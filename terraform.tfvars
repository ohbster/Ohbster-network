#Project Attributes
name = "TheosClass"
region = "us-east-1"

#Network Settings
cidr = "10.51.0.0/16"
public_subnet_count = 3
private_subnet_count = 3

#Instance settings
user_data = "./sample_userdata_debian.sh"
instance_count = 5
key_name = "myfinalform"
#key_name = null
port_list = [ 80,22,443 ]