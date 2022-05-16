# Creating networkinf for the project 

resource "aws_vpc" "Eng_Daps" {

  cidr_block = "10.0.0.0/16"

  instance_tenancy = "default"

  enable_dns_hostnames = true

  tags = {

    Name = "Eng_Daps"

  }

}

# Public Subnet 1 

resource "aws_subnet" "Public_Subnet_1" {

  vpc_id = aws_vpc.Eng_Daps.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "eu-west-2a"




  tags = {

    Name = "Public_Subnet_1"

  }

}

# Public Subnet 2 

resource "aws_subnet" "public_subnet_2" {

  vpc_id = aws_vpc.Eng_Daps.id

  cidr_block = "10.0.2.0/24"

  availability_zone = "eu-west-2b"




  tags = {

    Name = "Public_Subnet_2"

  }

}

# Private Subnet 1 

resource "aws_subnet" "Private_Subnet_1" {

  vpc_id = aws_vpc.Eng_Daps.id

  cidr_block = "10.0.3.0/24"

  availability_zone = "eu-west-2a"




  tags = {

    Name = "Private_Subnet_1"

  }

}

# Private Subnet 2 

resource "aws_subnet" "Private_Subnet_2" {

  vpc_id = aws_vpc.Eng_Daps.id

  cidr_block = "10.0.4.0/24"

  availability_zone = "eu-west-2b"




  tags = {

    Name = "Private_Subnet_2"

  }

}

# Public Route table 

resource "aws_route_table" "Daps_Public_Route" {

  vpc_id = aws_vpc.Eng_Daps.id





  tags = {

    Name = "Daps_Public_Route"

  }

}

# Private Route table 

resource "aws_route_table" "Daps_Private_Route" {

  vpc_id = aws_vpc.Eng_Daps.id





  tags = {

    Name = "Daps_Private_Route"

  }

}

# Associate public subnets with the public route table 

resource "aws_route_table_association" "pub_sub1_route_assoc" {

  subnet_id = aws_subnet.Public_Subnet_1.id

  route_table_id = aws_route_table.Daps_Public_Route.id

}

resource "aws_route_table_association" "pub_sub2_route_assoc" {

  subnet_id = aws_subnet.public_subnet_2.id

  route_table_id = aws_route_table.Daps_Public_Route.id

}

# Associate private subnets with the private route table 

resource "aws_route_table_association" "priv_sub1_route_assoc" {

  subnet_id = aws_subnet.Private_Subnet_1.id

  route_table_id = aws_route_table.Daps_Private_Route.id

}

resource "aws_route_table_association" "priv_sub2_route_assoc" {

  subnet_id = aws_subnet.Private_Subnet_2.id

  route_table_id = aws_route_table.Daps_Private_Route.id

}

# Internet Gateway 

resource "aws_internet_gateway" "daps_igw" {

  vpc_id = aws_vpc.Eng_Daps.id




  tags = {

    Name = "Daps_IGW"

  }

}

# Associate the internet gateway to the public route table 

resource "aws_route" "Daps_IGW_route_assoc" {

  route_table_id = aws_route_table.Daps_Public_Route.id

  gateway_id = aws_internet_gateway.daps_igw.id

  destination_cidr_block = "0.0.0.0/0"
}
