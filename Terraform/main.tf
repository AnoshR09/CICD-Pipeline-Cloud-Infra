#Step 1: Creation of VPC
resource "aws_vpc" "vpc1" {
    cidr_block = "10.0.0.0.16"
    tags = {
        Name = var.vpc_name
    }
}

#Step 2: Creation of Subnet
#public subnet
resource "aws_subnet" "PublicSubnet" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.1.0/24"
}
#private subnet
resource "aws_subnet" "PrivateSubnet" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.2.0/24"
}

#Step 3: Creation of InternetGateway
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vpc1.id
}


/*provider "aws"{
    region = "us-east-2"
}
data "aws_ami" "ubuntu" {
  most_recent = true


}*/
