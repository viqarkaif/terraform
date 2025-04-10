# Provisioning a Redis Docker Container Using Terraform<br>

# Objective<br>
To use Terraform with the Docker provider to automate the creation and deployment of a Redis container running locally.<br><br>

# Tools Required<br>
Terraform: Infrastructure as Code tool to define and manage infrastructure.<br>
Docker:Containerization tool to run the Redis instance.<br><br>
# Step-by-Step Implementation<br>
1. Install Prerequisites<br>
Ensure the following tools are installed:<br>
Terraform<br>
Docker<br><br>
2. Create and open a file named main.tf :<br><br>
Specify the Terraform provider for Docker<br> 
  terraform {<br>
    required_providers {<br>
      docker = {<br>
      source  = "kreuzwerker/docker"<br>
      version = "~> 2.0"<br>
    }<br>
  }<br>
}<br>

#Docker provider configuration<br>
provider "docker" {}<br>

#Define the Redis Docker image<br>
resource "docker_image" "redis_image" {<br>
  name         = "redis:latest"<br>
  keep_locally = false<br>
}<br>

#Create a Redis Docker container<br>
resource "docker_container" "redis_container" {<br>
  name  = "redis_server"<br>
  image = docker_image.redis_image.name<br>
  ports {<br>
    internal = 6379<br>
    external = 6379<br>
  }<br>
}<br><br>
3. Initialize Terraform<br>
Initialize the Terraform working directory and download the Docker provider:<br>
  terraform init<br>
You should see output confirming that Terraform is successfully initialized, and the Docker provider is installed.<br><br>

4. Plan the Deployment<br>
Preview the changes Terraform will make to create the Redis container:<br>
  terraform plan<br>
This command will show that Terraform intends to:<br>
Pull the Redis Docker image (redis:latest).<br>
Create a Docker container named redis_server with port 6379 exposed.<br><br>
5. Apply the Configuration<br>
Run the following command to deploy the infrastructure:<br>
  terraform apply<br>
When prompted, type yes to confirm and apply the changes. Terraform will:<br>
Pull the redis:latest Docker image .<br>
Create a Redis container named redis_server with port  mapped 6379 to the host.<br><br>
6. Verify the Deployment<br>
Check that the container is running:<br>
  docker ps<br>
You should see the redis_server container in the list of running containers.<br>
Verify connectivity to the Redis server:<br>
redis-cli -h <server_ip> -p 6379<br>
Replace <server_ip> with your local IP or localhost if you're running it locally.<br>
Test the connection:<br>
  PING<br>
Expected response: PONG .<br><br>
7. Destroy the Infrastructure<br>
To clean up the resources created by Terraform, run:<br>
  terraform destroy<br>
When prompted, type yes to confirm. This will stop the container and delete it along with the Redis image.<br>
