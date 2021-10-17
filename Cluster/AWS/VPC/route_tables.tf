#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# VPC Ruote Tables
#===========================================================================================

# Creating a route table for the Internet Gateway
resource "aws_route_table" "VPC_Gateway_Table" {
  vpc_id = aws_vpc.Exam_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VPC_Internet_Gateway.id
  }
  tags = local.Gateway_Table
}

# Associating public subnets with the Internet Gateway route table
resource "aws_route_table_association" "VPC_Gateway_Association" {
  count          = var.Amount_of_Zones
  subnet_id      = aws_subnet.VPC_Public_Subnet[count.index].id
  route_table_id = aws_route_table.VPC_Gateway_Table.id
}

# Creating a route table for private subnets
resource "aws_route_table" "VPC_Private_Subnet_Table" {
  count  = var.Amount_of_Zones
  vpc_id = aws_vpc.Exam_VPC.id
  tags   = merge(local.Tags, { Name = "${var.Environment_Tag}-VPC Private Subnet Table #${tostring(count.index + 1)} ${local.Availability_zone[count.index]}" })
}

# Associating private subnets with the private subnets route table
resource "aws_route_table_association" "VPC_Private_Subnet_Association" {
  count          = var.Amount_of_Zones
  subnet_id      = aws_subnet.VPC_Private_Subnet[count.index].id
  route_table_id = aws_route_table.VPC_Private_Subnet_Table[count.index].id
}
