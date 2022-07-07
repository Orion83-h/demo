resource "aws_eip" "dev_eip-1" {
  vpc      = true
}

resource "aws_nat_gateway" "dev_nat" {
  allocation_id = aws_eip.dev_eip-1.id
  subnet_id     = aws_subnet.pub_subnet-1.id
  depends_on = [aws_internet_gateway.dev_gw]

  tags = {
    Name = "dev_nat"
  }
}

resource "aws_eip" "test_eip-2" {
  vpc      = true
}

resource "aws_nat_gateway" "test_nat" {
  allocation_id = aws_eip.test_eip-2.id
  subnet_id     = aws_subnet.pub_subnet-2.id
  depends_on = [aws_internet_gateway.dev_gw]

  tags = {
    Name = "test_nat"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_gw.id
  }

  tags = {
    Name = "privat_route_table"
  }
}

resource "aws_route_table_association" "pri_subnet-1" {
  subnet_id      = aws_subnet.pri_subnet-1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "pri_subnet-2" {
  subnet_id      = aws_subnet.pri_subnet-2.id
  route_table_id = aws_route_table.private_route_table.id
}