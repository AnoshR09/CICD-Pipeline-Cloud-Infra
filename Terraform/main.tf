#Step 1: Creation of VPC
resource "aws_vpc" "vpc1" {
    cidr_block = "10.0.0.0/16"
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

#Step 4: Creation of Route Table
#public route table

resource "aws_route_table" "PublicRouteTable" {
    vpc_id = aws_vpc.vpc1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}
#Step 5: Association of Subnet with Route Table
resource "aws_route_table_association" "PublicSubnetAssociation" {
    subnet_id = aws_subnet.PublicSubnet.id
    route_table_id = aws_route_table.PublicRouteTable.id
}

#Step 6: Creation of Security Group
resource "aws_security_group" "mySG"{
    name = "allow_traffic"
    description = "Allow inbound traffic on port 22 and 80"
    vpc_id = aws_vpc.vpc1.id

    tags = {
        Name = "allow_traffic_sg"
    }
}
#allow inbound rules for SSH and HTTP
resource "aws_security_group_rule" "allow_ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [aws_vpc.vpc1.cidr_block]
    security_group_id = aws_security_group.mySG.id
}
resource "aws_security_group_rule" "allow_http" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [aws_vpc.vpc1.cidr_block]
    security_group_id = aws_security_group.mySG.id
}
#allow all outbound traffic  
resource "aws_security_group_rule" "allow_all_outbound" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.mySG.id  
}

resource "aws_instance" "my_instance" {
    ami           = "ami-12345678"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.PublicSubnet.id
  
    # Reference the IAM instance profile from iam.tf
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  
    vpc_security_group_ids = [aws_security_group.mySG.id]
}






/*provider "aws"{
    region = "us-east-2"
}
data "aws_ami" "ubuntu" {
  most_recent = true


}*/
