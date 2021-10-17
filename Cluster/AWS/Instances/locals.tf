#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Locals
#===========================================================================================


locals {
  Traffic_map = {
    blue = {
      blue  = 100
      green = 0
    }
    blue-80 = {
      blue  = 80
      green = 20
    }
    split = {
      blue  = 50
      green = 50
    }
    green-80 = {
      blue  = 20
      green = 80
    }
    green = {
      blue  = 0
      green = 100
    }
  }
}

locals {
  Blue_Weight = lookup(local.Traffic_map[var.Traffic], "blue", 100)
}

locals {
  Green_Weight = lookup(local.Traffic_map[var.Traffic], "green", 0)
}

# Retrieving list of the available availability zones
data "aws_availability_zones" "Available" {
  state = "available"
}
# Retrieving current region
data "aws_region" "Current" {}

# Region and avialability zones
locals {
  Cluster_Name      = "${local.Tags["Environment"]}-${var.Cluster_Name}"
  Current_region    = data.aws_region.Current.name
  Availability_zone = data.aws_availability_zones.Available.names
}

# User data
locals {
  User_Data = templatefile("templates/ecs_agent.tpl", {
    cluster = local.Cluster_Name
  })
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
  }
}

locals {
  Green_App = {
    port   = 8080
    amount = 4
    cpu    = 128
    memory = 128
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
