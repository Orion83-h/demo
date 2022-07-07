resource "aws_vpc" "dev_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      Name = "dev_vpc"
    }  
}

resource "aws_internet_gateway" "dev_gw" {
    vpc_id = aws_vpc.dev_vpc.id

    tags = {
      Name = "dev_gw"
    }  
}

resource "aws_subnet" "pub_subnet-1" {
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.dev_vpc.id 

    tags = {
      Name = "Web-1a"
    }
}

resource "aws_subnet" "pub_subnet-2" {
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.dev_vpc.id 

    tags = {
      Name = "Web-1b"
    }
}

resource "aws_subnet" "pri_subnet-1" {
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
    vpc_id = aws_vpc.dev_vpc.id 

    tags = {
      Name = "App-1a"
    }
}

resource "aws_subnet" "pri_subnet-2" {
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
    vpc_id = aws_vpc.dev_vpc.id 

    tags = {
      Name = "App-1b"
    }
}

resource "aws_subnet" "pri_subnet-3" {
    cidr_block = "10.0.5.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
    vpc_id = aws_vpc.dev_vpc.id 

    tags = {
      Name = "Database-1a"
    }
}

resource "aws_subnet" "pri_subnet-4" {
    cidr_block = "10.0.6.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
    vpc_id = aws_vpc.dev_vpc.id 

    tags = {
      Name = "Database-1b"
    }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_gw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "pub_subnet-1" {
  subnet_id      = aws_subnet.pub_subnet-1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "pub_subnet-2" {
  subnet_id      = aws_subnet.pub_subnet-2.id
  route_table_id = aws_route_table.public_route_table.id
}
