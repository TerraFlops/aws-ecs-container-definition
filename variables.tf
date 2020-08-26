variable "name" {
  description = "ECS container name"
  type = string
}

variable "repository_account_id" {
  description = "ECR repository AWS account ID. If none specified defaults to current Terraform AWS provider account"
  type = string
  default = null
}

variable "repository_name" {
  description = "ECR repository name"
  type = string
}

variable "repository_tag" {
  description = "ECR repository image tag to be deployed. If none specified defaults to 'latest'"
  type = string
  default = "latest"
}

variable "repository_region" {
  description = "ECR repository region. If none specified defaults to the current Terraform AWS provider region"
  type = string
  default = null
}

variable "cpu" {
  description = "The number of CPU units the ECS container agent will reserve for the container. This must fit within the total amount of reserved CPU for all containers in the task"
  type = number
}

variable "memory" {
  description = "The amount of memory (in MiB) to reserve for the container. This must fit within the total amount of reserved memory for all containers in the task"
  type = number
}

variable "essential" {
  description = "Boolean flag, if true and the container fails or stops for any reason all other containers that are part of the task will be stopped. If none specified defaults to true"
  type = bool
  default = true
}

variable "entry_point" {
  description = "Optional entrypoint override"
  type = list(string)
  default = []
}

variable "command" {
  description = "Optional command that is passed to the container"
  type = list(string)
  default = []
}

variable "log_group_name" {
  description = "CloudWatch log group name for the container"
  type = string
}

variable "log_group_region" {
  description = "CloudWatch log region. If none specified defaults to the current Terraform AWS provider region"
  type = string
  default = null
}

variable "working_directory" {
  description = "Optional working directory"
  type = string
  default = null
}

variable "volumes" {
  description = "Optional list of volume names"
  type = list(string)
  default = []
}

variable "volumes_efs" {
  description = "Optional list of EFS volumes to attach"
  type = list(object({
    name = string
    file_system_id = string
    root_directory = string
  }))
}

variable "volumes_from" {
  description = "Optional list of Docker volume names to load from other containers"
  type = list(object({
    read_only = bool
    source_container = string
  }))
  default = []
}

variable "ulimits" {
  description = "Optional list of ulimits to define on the container"
  type = list(object({
    hard_limit = number
    soft_limit = number
    name = string
  }))
  default = []
}

variable "mount_points" {
  description = "Optional list of mount points in the Docker container"
  type = list(object({
    read_only = bool
    container_path = string
    source_volume = string
  }))
  default = []
}

variable "port_mappings" {
  description = "Optional list of port mappings"
  type = list(object({
    protocol = string
    port = number
  }))
}

variable "environment_variables" {
  description = "Optional map of environment variables"
  type = map(string)
  default = {}
}

variable "start_timeout" {
  description = "Optional override to container start timeout"
  type = number
  default = 120
}

variable "stop_timeout" {
  description = "Optional override to container stop timeout"
  type = number
  default = 120
}

variable "read_only_root_filesystem" {
  description = "Boolean flag if true makes root filesystem read-only. Defaults to true"
  type = bool
  default = true
}