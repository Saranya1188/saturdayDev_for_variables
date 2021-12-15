resource "aws_vpc" "prod-vpc" {
  cidr_block       = "20.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production vpc"
  }
}
#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    Name = "prod IGW"

  }
}
#subnet
resource "aws_subnet" "subnet1" {
  #count                   = length(var.subnet_cidr)
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "20.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "prod_subnet1"
  }
}

#create RT
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "prodRT"
  }
}
#subnet association
resource "aws_route_table_association" "associate" {
  count          = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.subnet1.*.id, count.index)
  route_table_id = aws_route_table.prod-route-table.id
}