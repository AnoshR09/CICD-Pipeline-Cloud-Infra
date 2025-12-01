variable "vpc_name"{
    description = "value of vpc's Name tag."
    type = string
    default = "myTerraformvpc"
}
  
variable "subnet_name"{
    description = "value of subnet's Name tag"
    type = string
    default = "myTerraformsubnet"
}


variable "ineternetgateway_name"{
    description = "value of internetgateway's Name tag"
    type = string
    default = "myTerraformigw"
}  
 
variable "instance_name"{
    description = "value of instance Name tag"
    type = string
    default = "Infra-Project"
}

variable "s3_bucket_name"{
    description = "Name of the S3 bucket"
    type = string
    default = "infra-project-bucket-1234567890"
}