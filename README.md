**Ohbster-network** (by Obijah ohbster@protonmail.com)  
**READ THIS ENTIRELY BEFORE USING. FAILURE TO DO SO COULD RESULT IN FINANCIAL LOSS. BY USING THIS CODE YOU AGREE NOT TO HOLD ME RESPONSIBLE FOR ANY DAMAGES!!**  
**USE AT YOUR OWN RISK**  
Having said that, welcome to Ohbster-network  
This is a reusable terraform module that will  
- Build a VPC using the a provided CIDR block
- build multiple public and private subnets with routes and CIDR ranges
- Build Instances and evenely distribute them among the public subnets
- Name resources after the project name
- Can change regions. (BEWARE!!! MUST DO A `terraform destroy` FIRST)  

How do you use it?  
  If you haven't already, you need to perform a   
  - `git clone`
  - `cd` into the 'Ohbster-network' directory
  - `terraform init`
  From there you can do  
  - `terraform apply`
It should run just like that. If you want to make changes you don't need to touch ANY terraform code. Make changes to the terraform.tfvars file and re-apply

**WARNING IF YOU CHANGE REGION YOU MUST DO `terraform destroy` BEFORE `terraform apply` OR IT WILL OVERWRITE YOUR STATE FILE!!**  
  If this happens, you will need to manually destroy every resource in every region you applied since your last destroy.  
  This is not fun and is not cheap. (I am looking at ways to avoid this.)
  1) Open the file, terraform.tfvars
  2) Edit the settings in this file  
   ![image](https://github.com/ohbster/Ohbster-network/assets/96074979/d733460d-b84c-4eec-8543-b0312f6cc85d)
  3) Save the terraform.tfvars file and do a `terraform apply`

That is all you should need to change for most circumstances. Just those 9 settings. If you want multiple networks in multiple regions, you can use:  
`terraform workspace`  
to avoid maintain multiple states.  

Please send any feedback to Obijah - ohbster@protonmail.com  
Thanks and happy coding  
