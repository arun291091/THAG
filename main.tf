# Filled up the local variables and the tags in the locals.tf file

## VPC module creation
module "THAG" {
  source      = "./modules"
  vpc_cidr    = local.local_vpc_cidr
  vpc_tenancy = "default"
  vpc_name           = local.local_vpc_name
  vpc_cidr_public    = local.local_public_cidr
  az_list_priv       = local.az_list_priv
  az_list_pub        = local.az_list_pub
  local_newbits_priv = local.local_newbits_priv
  local_newbits_pub  = local.local_newbits_priv
}





## Local variables for VPC          
locals {
  local_newbits_priv = "2"
  local_newbits_pub  = "2"
  local_vpc_cidr     = "172.32.0.0/22"
  local_public_cidr  = "172.32.3.0/24"
  local_vpc_name     = "thag-1"
  az_list_priv       = ["us-west-2a", "us-west-2b", "us-west-2c"] 
  az_list_pub        = ["us-west-2a", "us-west-2b", "us-west-2c"]
}



provider "aws" {}
