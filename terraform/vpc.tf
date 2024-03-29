resource "aws_vpc" "kotlin_app_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "hello-world"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.kotlin_app_vpc.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "app-subnet-1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.kotlin_app_vpc.id

  tags = {
    Name = "app-igw"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kotlin_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "terrafrom-101-rt-public"
  }
}

resource "aws_route_table_association" "route_table_association_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}