variable "aws_instance_type"{
    default="t3.micro"
    type= string
}

variable "aws_volume_size"{
    default=15
    type=number
}

variable "aws_ami_id"{
    default="ami-0e5497a77ef21b5ac"
    type=string
}