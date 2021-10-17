#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Locals
#===========================================================================================

# Region and avialability zones
locals {
  Cluster_Name = "${local.Tags["Environment"]}-${var.Cluster_Name}"
}

locals {
  Tags = {
    Environment = var.Environment_Tag
    Project     = var.Project_Tag
    Owner       = var.Owner_Tag
  }
}

locals {
  Blue_App = {
    port   = 8080
    amount = 4
    cpu    = 128
    memory = 128
    image  = var.Blue_Container
  }
}

# Tags for several resources
locals {
  VPC                      = merge(local.Tags, { Name = "${local.Tags["Environment"]} VPC" })
  Internet_Gateway         = merge(local.Tags, { Name = "${local.Tags["Environment"]}-VPC Internet Gateway" })
  ENV_Tag                  = local.Tags["Environment"]
  ALB_Tags                 = merge(local.Tags, { Name = "VPC Load Balancer" })
  ECS_Service              = merge(local.Tags, { Name = "${local.ENV_Tag}-ECS Service" })
  Gateway_Table            = merge(local.Tags, { Name = "${local.ENV_Tag}-VPC Internet Gateway Table" })
  Load_Security_Group      = merge(local.Tags, { Name = "${local.ENV_Tag}-Load Balancer security group" })
  Instances_Security_Group = merge(local.Tags, { Name = "${local.ENV_Tag}-Instances security group" })
  SSM_Security_Group       = merge(local.Tags, { Name = "${local.ENV_Tag}-SSM security group" })
}
