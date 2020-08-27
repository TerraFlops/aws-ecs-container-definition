data "aws_caller_identity" "default" {}
data "aws_region" "default" {}

locals {
  # Create port mapping block
  port_mappings = length(var.port_mappings) == 0 ? null : {
    portMappings = [
    for port_mapping in var.port_mappings: {
      hostPort = port_mapping["port"]
      containerPort = port_mapping["port"]
      protocol = lower(port_mapping["protocol"])
    }
    ]
  }

  # Create volumes block
  volumes = length(var.volumes) == 0 ? null : {
    volumes = [
      for volume in var.volumes: {
        name = volume
      }
    ]
  }

  # Create EFS volumes block
  volumes_efs = length(var.volumes_efs) == 0 ? null : {
    volumes_efs = [
      for volume_efs in var.volumes_efs: {
        dockerVolumeConfiguration = null
        efsVolumeConfiguration = {
          fileSystemId = volume_efs["file_system_id"]
          rootDirectory = volume_efs["root_directory"]
        }
        name = volume_efs["name"]
      }
    ]
  }

  # Create volumes from block
  volumes_from = length(var.volumes_from) == 0 ? null : {
    volumesFrom = [
      for volume_from in var.volumes_from: {
        readOnly = volume_from["read_only"]
        sourceContainer = volume_from["source_container"]
      }
    ]
  }
  
  # Create ulimits block
  ulimits = length(var.ulimits) == 0 ? null : {
    ulimits = [
      for ulimit in var.ulimits: {
        hardLimit = ulimit["hard_limit"]
        softLimit = ulimit["soft_limit"]
        name = lower(ulimit["name"])
      }
    ]
  }  

  # Create mount point block
  mount_points = length(var.mount_points) == 0 ? null : {
    mountPoints = [
      for mount_point in var.mount_points: {
        readOnly: mount_point["read_only"]
        containerPath: mount_point["container_path"]
        sourceVolume: mount_point["source_volume"]
      }
    ]
  }

  # Create environment variables block
  environment_variables = length(var.environment_variables) == 0 ? null : {
    environment = [
      for key, value in var.environment_variables: tomap({
        name: key
        value: value
      })
    ]
  }

  # Get ECR repository account ID
  repository_account_id = var.repository_account_id == null ? data.aws_caller_identity.default.account_id : var.repository_account_id

  # Get required regions (or use the default AWS provider region if none supplied)
  image_region = var.repository_region == null ? data.aws_region.default.name : var.repository_region
  log_group_region = var.log_group_region == null ? data.aws_region.default.name : var.log_group_region
  repository_region = var.repository_region == null ? data.aws_region.default.name : var.repository_region
}
