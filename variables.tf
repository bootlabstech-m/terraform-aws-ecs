variable "region" {
  type        = string
  description = "(optional) describe your region"
}

variable "ecs_role_name" {
  type        = string
  description = "ECS role name"
}
variable "ecs_cluster_name" {
  type        = string
  description = "Name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name to send logs."
}

variable "name" {
  type        = string
  description = "(Required) A unique name for your task definition."
}

variable "requires_compatibilities" {
  type        = list(string)
  description = " (Optional) Set of launch types required by the task. The valid values are EC2 and FARGATE."
}
variable "cpu_size" {
  type        = number
  description = "(Optional) Number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required."
}

variable "memory_size" {
  type        = number
  description = "(Optional) Amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required."
}

variable "network_mode" {
  type        = string
  description = " (Optional) Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host."
}

variable "security_groups" {
  type        = list(string) 
  description = " (Optional) Security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
}

variable "subnets" {
  type        = list(string)
  description = "(Required) Subnets associated with the task or service."
}
variable "container_definitions" {
  type = string
  default = <<TASK_DEFINITION
  [
    {
      "name": "iis",
      "image": "mcr.microsoft.com/windows/servercore/iis",
      "memory": 2048,
      "essential": true
    }
  ]
  TASK_DEFINITION
}
variable "operating_system_family" {
  type        = string
  description = "OS for the cluster."
}
variable "cpu_architecture" {
  type        = string
  description = "cpu arch for the cluster."
}
variable "role_arn" {
  type        = string
  description = "role of the account."
}
