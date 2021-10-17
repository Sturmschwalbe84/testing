#===========================================================================================
# Rainbow Gravity's Inrastructure for exam
# 
# VPC Variables
#===========================================================================================

# Maximum length of the Environment tag is 5, because it used as name prefix for several resources.
# DON'T delete it.
variable "Cluster_Name" {
  type    = string
  default = "Cluster"
}

variable "Traffic" {
  type    = string
  default = "blue"
  validation {
    condition     = var.Traffic == "blue" || var.Traffic == "blue-80" || var.Traffic == "split" || var.Traffic == "green-80" || var.Traffic == "green"
    error_message = "Traffic can be only in these conditions: blue, blue-80, split, green-80, green."
  }
}

variable "Environment_Tag" {
  type    = string
  default = "Exam"
  validation {
    condition     = length(var.Environment_Tag) <= 5 && length(var.Environment_Tag) >= 1
    error_message = "Maximum lenght of the Environment tag is 5, because it used as name prefix for several resources."
  }
}

variable "Blue_Container_Params" {
  type = map(number)
  default = {
    port   = 8080
    amount = 4
    cpu    = 128
    memoru = 128
  }
}

variable "Autoscaling" {
  type = map(number)
  default = {
    desired_capacity = 2
    max_size         = 2
    min_size         = 2
  }
}

variable "Project_Tag" {
  type    = string
  default = "Template Homework"
}

variable "Owner_Tag" {
  type    = string
  default = "Rainbow Gravity"
}

# Region selection
variable "Region" {
  type    = string
  default = "eu-central-1"
}

# EC2 Instance type
variable "Instance_Type" {
  type    = string
  default = "t2.micro"
}

# Application Load Balancer Security Group ports
variable "Load_Security_Group_Ports" {
  type    = list(string)
  default = ["80", "8080"]
}

# Instances Security Group ports
variable "Instances_Security_Group_Ports" {
  default = {
    22    = 22
    49153 = 65535
  }
}

# ALB Health Check parameters
variable "Health_Check" {
  type = map(number)
  default = {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = 200
  }
}
