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
