
### VPC #####

resource "aws_vpc" "base" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  instance_tenancy     = var.vpc_tenancy
}


################ Subnet ####################################################################################

# Private CIDR block Split

module "subnet_addrs_main_cidr_priv" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.vpc_cidr
  networks = [
    {
      name     = var.az_list_priv[0]
      new_bits = var.local_newbits_priv
    },
    {
      name     = var.az_list_priv[1]
      new_bits = var.local_newbits_priv
    },
    {
      name     = var.az_list_priv[2]
      new_bits = var.local_newbits_priv
    }

  ]
}

resource "aws_subnet" "private" {
  count             = length(var.az_list_priv)
  vpc_id            = aws_vpc.base.id
  cidr_block        = element(module.subnet_addrs_main_cidr_priv.networks[*].cidr_block, count.index)
  availability_zone = var.az_list_priv[count.index]

}


####################################################################################################
### Pub Cidr ###

module "subnet_addrs_main_cidr_pub" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.vpc_cidr_public
  networks = [
    {
      name     = var.az_list_pub[0]
      new_bits = var.local_newbits_pub
    },
    {
      name     = var.az_list_pub[1]
      new_bits = var.local_newbits_pub
    },
    {
      name     = var.az_list_pub[2]
      new_bits = var.local_newbits_pub
    }

  ]
}
resource "aws_subnet" "public" {
  count                   = length(var.az_list_pub)
  vpc_id                  = aws_vpc.base.id
  cidr_block              = element(module.subnet_addrs_main_cidr_pub.networks[*].cidr_block, count.index)
  availability_zone       = var.az_list_pub[count.index]
  map_public_ip_on_launch = true

}

###############################################################################################


###########Public Route ##########################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.base.id
}


resource "aws_eip" "nat" {
  count = length(var.az_list_pub)
  vpc   = true

}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id
}



resource "aws_route_table_association" "public" {
  count          = length(var.az_list_pub)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}


resource "aws_nat_gateway" "ngw" {
  count         = length(var.az_list_pub)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  depends_on = [aws_internet_gateway.igw]
}

########Private route#####################

resource "aws_route" "private_nat_gateway" {
  count                  = length(var.az_list_priv)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
}


resource "aws_route_table" "private" {
  count  = length(var.az_list_priv)
  vpc_id = aws_vpc.base.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.az_list_priv)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}







