# VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  tags = {
    Name = "TerraVPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = "${aws_vpc.terra_vpc.id}"
  tags =  {
    Name = "main"
  }
}
# attach Internet gateway to public subnet 

# Subnets : public
resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.terra_vpc.id}"
  cidr_block = "${(var.public_subnet_cidr)}"
#  availability_zone = "${(var.aws_region)}"
  map_public_ip_on_launch = true
  tags =  {
    Name = "Public Subnet"
  }
}

# Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.terra_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terra_igw.id}"
  }
  tags =  {
    Name = "publicRouteTable"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${(aws_subnet.public.id)}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

# Subnets : Private 
resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.terra_vpc.id}"
  cidr_block = "${(var.private_subnet_cidr)}"
#  availability_zone = "${(var.aws_region)}"
 // map_public_ip_on_launch = true  --- can be remove 
  tags =  {
    Name = "Private Subnet"
  }
}



resource "aws_security_group" "webservers" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.terra_vpc.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
