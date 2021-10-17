#======================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# Elsatic Compute Service resources
#======================================================================

# sed -i 's/ignore_changes = \[\]/ignore_changes = []/' ecs.tf
# sed -i "s/ignore_changes = []/ignore_changes = []/" ecs.tf

resource "aws_ecs_service" "VPC_ECS_Service_Green" {
  name            = "${local.ENV_Tag}-Green"
  cluster         = data.terraform_remote_state.Instances_State.outputs.ECS_Cluster
  task_definition = aws_ecs_task_definition.Task_Green.arn
  desired_count   = local.Green_App.amount
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
    target_group_arn = data.terraform_remote_state.Instances_State.outputs.VPC_Green_Target_Group
    container_name   = "${local.ENV_Tag}-Green-Container"
    container_port   = local.Green_App.port
  }
  tags = local.ECS_Service
}

resource "aws_ecs_task_definition" "Task_Green" {
  family = "${local.ENV_Tag}-Green-APP"
  container_definitions = jsonencode([
    {
      name      = "${local.ENV_Tag}-Green-Container"
      image     = local.Green_App.image
      cpu       = local.Green_App.cpu
      memory    = local.Green_App.memory
      essential = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = local.Green_App.port
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
