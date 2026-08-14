#OUTPUTS FOR SINGLE INSTANCE:

# output "ec2_public_ip" {
#   value = aws_instance.my_ec2.public_ip
# }

# output "ec2_public_dns" {
#   value =aws_instance.my_ec2.public_dns
# }

# output "ec2_private_ip" {
#   value = aws_instance.my_ec2.private_ip
# }

# output "ec2_private_dns" {
#   value = aws_instance.my_ec2.private_dns
# }




#OUTPUTS FOR META ARGUMENT "COUNT"

# output "ec2_public_ip" {
#   value = aws_instance.my_ec2[*].public_ip
# }

# output "ec2_public_dns" {
#   value =aws_instance.my_ec2[*].public_dns
# }

# output "ec2_private_ip" {
#   value = aws_instance.my_ec2[*].private_ip
# }

# output "ec2_private_dns" {
#   value = aws_instance.my_ec2[*].private_dns
# }



#OUTPUTS FOR META ARGUMENT "FOR_EACH"

output "ec2_public_ip" {
  value = {for key,instance in aws_instance.my_ec2:key => instance.public_ip}
}

output "ec2_public_dns" {
  value ={for key,instance in aws_instance.my_ec2 :key => instance.public_dns}
}

output "ec2_private_ip" {
  value = {for key,instance in aws_instance.my_ec2:key => instance.private_ip}
}

output "ec2_private_dns" {
  value = {for key,instance in aws_instance.my_ec2:key => instance.private_dns}
}