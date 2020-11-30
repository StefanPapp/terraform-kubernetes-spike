resource "aws_vpc" "default" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name         = format("%s-vpc", var.cluster_name)
    Purpose      = format("%s-k8s", var.cluster_name)
    Department   = format("%s", var.tag_account)
    Creator      = format("%s", var.tag_creator)
    Date_Created = format("%s", var.run_date)
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.subnet_cidr_blocks[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = var.public
  tags = {
    Name         = format("%s-subnet1", var.cluster_name)
    Purpose      = format("%s-k8s", var.cluster_name)
    Department   = format("%s", var.tag_account)
    Creator      = format("%s", var.tag_creator)
    Date_Created = format("%s", var.run_date)
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.subnet_cidr_blocks[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = var.public
  tags = {
    Name         = format("%s-subnet2", var.cluster_name)
    Purpose      = format("%s-k8s", var.cluster_name)
    Department   = format("%s", var.tag_account)
    Creator      = format("%s", var.tag_creator)
    Date_Created = format("%s", var.run_date)
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.subnet_cidr_blocks[2]
  availability_zone       = var.availability_zones[2]
  map_public_ip_on_launch = var.public
  tags = {
    Name         = format("%s-subnet3", var.cluster_name)
    Purpose      = format("%s-k8s", var.cluster_name)
    Department   = format("%s", var.tag_account)
    Creator      = format("%s", var.tag_creator)
    Date_Created = format("%s", var.run_date)
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name         = format("%s-igw", var.cluster_name)
    Purpose      = format("%s-k8s", var.cluster_name)
    Department   = format("%s", var.tag_account)
    Creator      = format("%s", var.tag_creator)
    Date_Created = format("%s", var.run_date)
  }
}
resource "aws_route_table" "main" {
    vpc_id = format("%s", aws_vpc.default.id)

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.default.id
    }
}

resource "aws_route_table_association" "snt1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "snt2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "snt3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.main.id
}