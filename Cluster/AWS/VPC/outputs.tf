#===========================================================================================-
# Rainbow Gravity's Inrastructure for exam
# 
# Outputs
#===========================================================================================

output "Exam_VPC" {
  value = aws_vpc.Exam_VPC.id
}

output "ECS_Agent_Profile" {
  value = aws_iam_instance_profile.ECS_Agent_Profile.id
}

output "VPC_Public_Subnet" {
  value = aws_subnet.VPC_Public_Subnet.*.id
}
