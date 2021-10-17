#===========================================================================================-
# Rainbow Gravity's Inrastructure for exam
# 
# Outputs
#===========================================================================================

output "VPC_Blue_Target_Group" {
  value = aws_lb_target_group.VPC_Blue_Target_Group.arn
}

output "VPC_Green_Target_Group" {
  value = aws_lb_target_group.VPC_Green_Target_Group.arn
}

output "ECS_Cluster" {
  value = aws_ecs_cluster.ECS_Cluster.id
}

output "VPC_Load_Balancer" {
  value = aws_lb.VPC_Load_Balancer.arn
}
