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
  default = "068379437484.dkr.ecr.eu-central-1.amazonaws.com/python-app-blue:97721ca7c3293855562263ac00fa8aedb161baaa"
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
