# ECS Container Definition

This module is responsible for generating a single container definition JSON for use with ECS.

#### Example usage

```hcl-terraform
module "example_load_balancer" {
  source = "git::https://github.com/TerraFlops/aws-ecs-container-definition?ref=v1.0"
  name = "api"
  repository_name = "api"
  cpu = 1024
  memory = 2048
  working_directory = "/var/www"
  port_mappings = [
    {
      protocol = "http"
      port = "8080"
    }   
  ]
  entry_point = [
    "/usr/bin/api"
  ]
  command = [
    "-daemon"
  ]
  volumes = [
    "storage",
    "tmp"
  ]
  mount_points = [
    {
      read_only = false
      container_path = "/tmp"
      source_volume = "tmp"
    },
    {
      read_only = false
      container_path = "/mnt/storage"
      source_volume = "storage"
    }
  ] 
  environment_variables = {
    "APP_ENVIRONMENT" = "dev"
  }
  log_group_name = "api"
  log_group_region = "ap-southeast-2"
}
```
