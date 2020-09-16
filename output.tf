locals {
  output = merge(
    {
      name = var.name
      cpu = var.cpu
      memory = var.memory
      workingDirectory = var.working_directory
      entryPoint = var.entry_point
      command = var.command
      startTimeout = var.start_timeout
      stopTimeout = var.stop_timeout
      image = "${local.repository_account_id}.dkr.ecr.${local.repository_region}.amazonaws.com/${var.repository_name}:${var.repository_tag}"
      logConfiguration = {
        logDriver = "awslogs"
        secretOptions = null
        options = {
          "awslogs-group" = var.log_group_name
          "awslogs-region" = local.log_group_region
          "awslogs-stream-prefix" = var.name
        }
      }
      dnsSearchDomains = null
      environmentFiles = null
      firelensConfiguration = null
      dependsOn = null
      disableNetworking = null
      interactive = null
      healthCheck = null
      essential = true
      links = null
      hostname = null
      extraHosts = null
      pseudoTerminal = null
      user = null
      readonlyRootFilesystem = true
      dockerLabels = null
      systemControls = null
      privileged = null
      linuxParameters = null
      resourceRequirements = null
      dnsServers = null
      secrets = [
        for key, arn in var.secrets: {
          name = key
          valueFrom = arn
        }
      ]
      dockerSecurityOptions = null
      memoryReservation = null
    },
    local.ulimits,
    local.volumes,
    local.volumes_efs,
    local.volumes_from,
    local.port_mappings,
    local.mount_points,
    local.environment_variables
  )
}

output "json" {
  description = "Container definition JSON"
  value = jsonencode(local.output)
}

output "json_array" {
  description = "Container definition JSON wrapped in an array for use with task definitions"
  value = jsonencode([
    local.output
  ])
}

output "name" {
  value = var.name
}

output "repository_name" {
  value = var.repository_name
}

output "cpu" {
  value = var.cpu
}

output "memory" {
  value = var.memory
}

output "volumes" {
  value = var.volumes
}