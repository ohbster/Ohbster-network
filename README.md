**Ohbster-network** (by Obijah ohbster@protonmail.com)
**READ THIS ENTIRELY BEFORE USING. FAILURE TO DO SO COULD RESULT IN FINANCIAL LOSS. BY USING THIS CODE YOU AGREE NOT TO HOLD ME RESPONSIBLE FOR ANY DAMAGES!!**
Having said that, welcome to Ohbster-network
This is a reusable module that will
- Build a VPC using the a provided CIDR block
- build multiple public and private subnets with routes and CIDR ranges
- Build Instances and evenely distribute them among the public subnets
- Name resources after the project name
- Can change regions. (BEWARE!!! MUST DO A `terraform destroy` FIRST)

How do you use it?
  If you haven't already, you need to perform a `terraform init`
  
  1) Open the file, terraform.tfvars
  2) Edit the settings in this file ![image](https://github.com/ohbster/Ohbster-network/assets/96074979/d733460d-b84c-4eec-8543-b0312f6cc85d)
  3) Save the terraform.tfvars file and do a `terraform apply`
**WARNING IF YOU PLAN TO CHANGE REGION YOU MUST DO `terraform destroy` FIRST OR IT WILL OVERWRITE YOUR STATE FILE!!**
  If this happens, you will need to manually destroy every resource in every region you applied since your last destroy.
  This is not fun and is not cheap.

