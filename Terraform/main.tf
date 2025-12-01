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
    map_public_ip_on_launch = true

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

resource "tls_private_key" "ec2_sshkey" {
    algorithm = "RSA"
    rsa_bits  = 4096
  
}
resource "aws_key_pair" "infra_key" {
    key_name   = "infra_key"  # Replace with your desired key pair name
    public_key = tls_private_key.ec2_sshkey.public_key_openssh
}

resource "local_file" "ssh_private_key" {
    content  = tls_private_key.ec2_sshkey.private_key_pem
    filename = "C:\\Users\\anosh\\Downloads\\infra_key.pem"
    file_permission = "0400"
}

resource "aws_instance" "infra-project" {
    ami           = "ami-0ecb62995f68bb549"  # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type in us-east-1
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.PublicSubnet.id
    key_name    = aws_key_pair.infra_key.key_name

    tags = {
        Name = var.instance_name # Use the instance_name variable
    }

    # Reference the IAM instance profile from iam.tf
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  
    vpc_security_group_ids = [aws_security_group.mySG.id]
}
resource "aws_s3_bucket" "infra_bucket" {
    bucket = "infra-project-bucket-1234567890" # Replace with a unique bucket name
    
    tags = {
        Name        = var.s3_bucket_name
        Environment = "Dev"  
    }
}

resource "aws_s3_bucket_versioning" "infra_bucket_versioning" {
    bucket = aws_s3_bucket.infra_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
  
}
/*
resource "aws_dynamodb_table" "state_lock_table" {
    name         = "terraform-state-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
    
    tags = {
        Name        = "terraform-state-lock"
        Environment = "Dev"
    } 
}
*/
