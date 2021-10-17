#======================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Elsatic Compute Service resources
#======================================================================

# sed -i 's/ignore_changes = \[\]/ignore_changes = []/' ecs.tf
# sed -i "s/ignore_changes = []/ignore_changes = []/" ecs.tf

resource "aws_ecs_service" "VPC_ECS_Service_Blue" {
  name            = "${local.ENV_Tag}-Blue"
  cluster         = data.terraform_remote_state.VPC_State.outputs.ECS_Cluster
  task_definition = aws_ecs_task_definition.Task_Blue.arn
  desired_count   = local.Blue_App.amount
  launch_type     = "EC2"
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  load_balancer {
    target_group_arn = data.terraform_remote_state.VPC_State.outputs.VPC_Blue_Target_Group
    container_name   = "${local.ENV_Tag}-Blue-Container"
    container_port   = local.Blue_App.port
  }
  tags = local.ECS_Service
}

resource "aws_ecs_task_definition" "Task_Blue" {
  family = "${local.ENV_Tag}-Blue-APP"
  container_definitions = jsonencode([
    {
      name      = "${local.ENV_Tag}-Blue-Container"
      image     = local.Blue_App.image
      cpu       = local.Blue_App.cpu
      memory    = local.Blue_App.memory
      essential = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = local.Blue_App.port
          hostPort      = 0
        }
      ]
    }
  ])
  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }
  lifecycle {
    ignore_changes = []
  }
}
