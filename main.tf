# Specify the Terraform provider for Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

# Define the Redis Docker image
resource "docker_image" "redis_image" {
  name         = "redis:latest"
  keep_locally = false
}


# Create a Redis Docker container
resource "docker_container" "redis_container" {
  name  = "redis_server"
  image = docker_image.redis_image.name
  ports {
    internal = 6379
    external = 6379
  }
}
