#########VPC########################

variable "vpc_cidr" {
  description = "vpc_cidr block"
  default     = ""
}

variable "Region" {
  description = "region"
  default     = "us-west-2"
}

variable "vpc_cidr_public" {
  description = "vpc_cidr block"
  default     = ""
}

variable "vpc_name" {
  description = "A name for your VPC"
  default     = ""
}

variable "vpc_tenancy" {
  default = "default"
}





######SUBNET#################################
variable "subnet_cidr_priv" {
  default = ""
}


variable "subnet_cidr_pub" {
  default = ""
}

variable "az_list_priv" {
  default = ""
}


variable "az_list_pub" {
  default = ""
}


variable "local_newbits_priv" {
  default = ""
}

variable "local_newbits_pub" {
  default = ""
}



