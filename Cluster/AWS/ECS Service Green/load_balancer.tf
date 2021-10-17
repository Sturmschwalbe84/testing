#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
#
# Green Listeners and Target Groups
#===========================================================================================

resource "aws_lb_listener" "VPC_Green_Load_Balancer_Listener_80" {
  load_balancer_arn = data.terraform_remote_state.Instances_State.outputs.VPC_Load_Balancer
  port              = 8080
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.VPC_Green_Target_Group.arn
  }
}

resource "aws_lb_target_group" "VPC_Green_Target_Group" {
  name_prefix          = "${var.Environment_Tag}-"
  vpc_id               = data.terraform_remote_state.VPC_State.outputs.Exam_VPC
  port                 = local.Green_App.port
  protocol             = "HTTP"
  deregistration_delay = 10
  health_check {
    port                = "traffic-port"
    healthy_threshold   = var.Health_Check.healthy_threshold
    unhealthy_threshold = var.Health_Check.unhealthy_threshold
    timeout             = var.Health_Check.timeout
    interval            = var.Health_Check.interval
    matcher             = var.Health_Check.matcher
  }
}
