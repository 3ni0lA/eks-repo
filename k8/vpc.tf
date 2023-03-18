
resource "aws_vpc" "second-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "second-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.second-vpc.id

  tags = {
    Name = "igw"
  }
}

# Subnets
resource "aws_subnet" "private-eu-west-2a" {
  vpc_id            = aws_vpc.second-vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "eu-west-2a"

  tags = {
    "Name"                            = "private-eu-west-2a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "private-eu-west-2b" {
  vpc_id            = aws_vpc.second-vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "eu-west-2b"

  tags = {
    "Name"                            = "private-eu-west-2b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "public-eu-west-2a" {
  vpc_id                  = aws_vpc.second-vpc.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-eu-west-2a"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

resource "aws_subnet" "public-eu-west-2b" {
  vpc_id                  = aws_vpc.second-vpc.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-eu-west-2b"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

