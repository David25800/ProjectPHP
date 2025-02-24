# Cloud Infrastructure Automation with Terraform and Ansible

## Overview
This project demonstrates the automation of cloud infrastructure setup and server configuration using Terraform and Ansible. The goal is to deploy a server on Azure, install Docker, and configure it to run a sample application.

## Prerequisites
- An Azure account with sufficient permissions to create resources.
- SSH key pair for accessing the virtual machine.
- Terraform installed on your local machine or WSL.
- Ansible installed on your local machine or WSL.
- Basic understanding of Terraform and Ansible.

## Directory Structure
```plaintext
/project-directory
  /terraform
    main.tf (Terraform scripts)
  /ansible
    hosts (Ansible inventory file)
    setup-docker.yml (Ansible playbook)
  README.md (This file)
# myphpapp
