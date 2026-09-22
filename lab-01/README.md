# Terraform Lab 01 — Simple Web Server on Google Cloud

## Overview

This lab is a hands-on Terraform exercise focused on deploying a simple web server on Google Cloud Platform (GCP).

The infrastructure is created entirely using Terraform.

## Architecture

The lab creates:

- Custom VPC
- Custom subnet
- Compute Engine VM
- External IP address
- Firewall rule allowing HTTP traffic on port 80
- Nginx web server installed automatically using a startup script

## Infrastructure

| Resource | Configuration |
|---|---|
| VPC | `cloudbox-vpc` |
| Subnet | `web-subnet` |
| Subnet CIDR | `10.10.0.0/24` |
| Region | `me-central1` |
| VM | `web-server` |
| Machine Type | `e2-micro` |
| Operating System | Ubuntu |
| Web Server | Nginx |
| HTTP Port | `80` |

## Project Structure

```text
lab-01/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## Terraform Concepts Practiced

This lab helped me practice:

- Terraform providers
- Terraform resources
- Input variables
- Resource references
- VPC and subnet creation
- Compute Engine deployment
- Network tags
- Firewall rules
- Startup scripts
- Terraform dependency handling

## Network Security

HTTP traffic is allowed from:

```text
0.0.0.0/0
```

on TCP port `80`.

The firewall rule uses a target network tag so that the rule applies only to the web server VM rather than every VM in the VPC.

## Startup Script

The VM automatically:

1. Updates the package repository.
2. Installs Nginx.
3. Creates a custom web page.
4. Enables and starts Nginx.

The web page displays:

```text
Hello from Terraform Lab 1
```

## Terraform Workflow

Initialize Terraform:

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt
```

Validate the configuration:

```bash
terraform validate
```

Review the infrastructure changes:

```bash
terraform plan
```

Deploy the infrastructure:

```bash
terraform apply
```

After deployment, the web server can be accessed using the VM external IP:

```text
http://EXTERNAL_IP
```

## Cleanup

To remove all resources created by this lab:

```bash
terraform destroy
```

## What I Learned

Through this lab, I practiced translating infrastructure requirements into Terraform configuration instead of following a predefined code example.

I also practiced using Terraform documentation to identify the required Google Cloud resources and their configuration.