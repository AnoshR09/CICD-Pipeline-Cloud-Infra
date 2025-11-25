#This is for iam_role
resource "aws_iam_role" "test_role" {
    name = "test_role"
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    EOF
    tags = {
        Name = "EC2-SSM-CloudWatch-ECR-Role"
    }    
}

# Attach AWS managed policy for SSM
resource "aws_iam_role_policy_attachment" "ssm_policy" {
    role       = aws_iam_role.test_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Attach AWS managed policy for CloudWatch Agent
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy" {
    role       = aws_iam_role.test_role.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Attach AWS managed policy for ECR read access
resource "aws_iam_role_policy_attachment" "ecr_read_policy" {
    role       = aws_iam_role.test_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Create instance profile for EC2
resource "aws_iam_instance_profile" "ec2_profile" {
    name = "ec2-ssm-cloudwatch-ecr-profile"
    role = aws_iam_role.test_role.name
}