
Project: Automated Cloud Deployment with Terraform, Ansible, Docker, and Git Action
Overview
This project uses a Docker container and a sample PHP web application to automatically deploy a cloud-based server. It includes CI/CD pipelines using GitHub Actions, Terraform for infrastructure provisioning, and Ansible for configuration management.
Technologies Used
•	Terraform - This Infrastructure as Code (IaC) was used to provision an Azure Virtual Machine.
•	Ansible - Automates server configuration and Docker installation.
•	Docker - Containerizes the PHP web application.
•	GitHub Actions - Implements CI/CD pipelines for automated deployment.
1. Infrastructure Setup (Terraform)
Files:
main.tf (This Terraform script was used to provision Azure VM, networking, and security groups)
Terraform Resources Created:
•	Azure Virtual Machine (Ubuntu-based)
•	Virtual Network and Subnet
•	Network Security Group (NSG) allowing HTTP (80) & SSH (22)
•	Public IP Address for remote access
Usage:
#Format the code
erraform fmt
# Initialize Terraform
terraform init
#Check if Everything is Correct
terraform plan 
#Apply Terraform configuration (approval needed)
terraform apply 
# Apply Terraform configuration (no approval needed)
terraform apply -auto-approve

2. Server Configuration (Ansible)
Files:
•	setup-docker.yml (Ansible playbook to configure the Virtual Machine)
•	hosts (Inventory file with Virtual Machine details)
What It Does:
•	Updates system packages needed
•	Installs Docker and dependencies
•	Ensures Docker starts on boot
Usage:
# Run Ansible playbook
ansible-playbook -i hosts setup-docker.yml

3. Application Deployment (Docker)
Files:
•	Dockerfile (Defines PHP Apache container setup)
•	docker-compose.yml (Orchestrates deployment)
•	deploy.sh (Script to start the container)
•	index.php (Sample PHP application)
Usage:
# Build and run Docker container
bash deploy.sh

4. CI/CD Pipeline Integration
Files:
•	.github/workflows/deploy.yml (GitHub Actions for CI/CD)
Pipeline Tasks:
1.	Terraform Deployment - Provisions infrastructure
2.	Ansible Configuration - Sets up the server
3.	Docker Build & Push - Pushes image to Azure Container Registry
4.	Container Deployment - Runs the app on the VM
How to Test
•	Internet: Must be connected to the internet to be able to setup.
•	Account: Ensure you have an Azure Account for easy setup.
•	Check Terraform Deployment: Ensure the Azure VM is created on the Azure website or you can run this code on the command-line terraform state list to check all the resources created.
•	Verify Ansible Setup: Check if Docker is installed by running this code on the command-line docker --version.
•	Run the Application: Open the public IP in a browser (http://<public-ip>).
•	CI/CD Validation: Push changes to GitHub and verify automatic deployment.

Conclusion
This project fully automates cloud infrastructure provisioning, server configuration, containerized application deployment, and CI/CD integration.
