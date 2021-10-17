#===========================================================================================
# Rainbow Gravity's 10
# 
# Endpoints
#===========================================================================================

# Creating endpoint for S3 Bucket service
resource "aws_vpc_endpoint" "S3_Endpoint" {
  vpc_id            = aws_vpc.Exam_VPC.id
  service_name      = "com.amazonaws.${local.Current_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.VPC_Private_Subnet_Table.*.id
}
