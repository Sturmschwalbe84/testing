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

variable "Environment_Tag" {
  type    = string
  default = "Exam"
  validation {
    condition     = length(var.Environment_Tag) <= 5 && length(var.Environment_Tag) >= 1
    error_message = "Maximum lenght of the Environment tag is 5, because it used as name prefix for several resources."
  }
}

variable "Blue_Container" {
  type    = string
  default = "068379437484.dkr.ecr.eu-central-1.amazonaws.com/python-app-blue:97721ca7c3293855562263ac00fa8aedb161baaa"
}

variable "Green_Container" {
  type    = string
  default = ""
}

variable "Enable_Green" {
  type    = bool
  default = false
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

variable "Green_Container_Params" {
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

# Amount of EC2 Instances per avialability zone
variable "EC2_Per_Zone" {
  type    = number
  default = 1

  validation {
    condition     = var.EC2_Per_Zone >= 1
    error_message = "Amount of EC2 Instances per avialability zone cannot be less than 1. Why do you need that?"
  }
}

# Amount of avialability zones. Cannot be less than 2 or ALB will not start.
variable "Amount_of_Zones" {
  type    = number
  default = 2

  validation {
    condition     = var.Amount_of_Zones >= 2
    error_message = "Amount of avialability zones cannot be less than 2. ALB will not start."
  }
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
