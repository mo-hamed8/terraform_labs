# Terraform Lab 02 — Existing Network & Private Backend on GCP

## Overview

This lab focuses on using Terraform with existing Google Cloud infrastructure.

Unlike Lab 01, the VPC and subnet were created outside Terraform. Terraform uses data sources to retrieve information about these existing resources and uses them when deploying new infrastructure.

The lab also introduces Terraform outputs and a private Compute Engine VM without an external IP address.

## Architecture

```text
Existing Infrastructure
(Not managed by Terraform)

company-shared-vpc
└── backend-subnet
    └── 10.20.0.0/24
            │
            │ Data Source
            ▼
        Terraform
            │
            ├── Backend VM
            │   └── Internal IP only
            │
            └── Firewall Rule
                └── TCP 8080
```

## Infrastructure

### Existing Resources

These resources already existed before running Terraform:

| Resource | Configuration |
|---|---|
| VPC | `company-shared-vpc` |
| Subnet | `backend-subnet` |
| Region | `me-central1` |
| CIDR | `10.20.0.0/24` |

Terraform retrieves information about these resources using **data sources** instead of creating them.

### Terraform Managed Resources

Terraform creates and manages:

| Resource | Configuration |
|---|---|
| VM | `backend-server` |
| Machine Type | `e2-micro` |
| Zone | `me-central1-a` |
| Operating System | Ubuntu |
| External IP | None |
| Network Tag | `backend` |
| Firewall Port | TCP `8080` |
| Firewall Source | `10.20.0.0/24` |

## Project Structure

```text
lab-02/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## Terraform Concepts Practiced

This lab helped me practice:

- Terraform providers
- Resources
- Data sources
- Input variables
- Resource referencing
- Data source referencing
- Resource attributes
- Terraform outputs
- Working with existing infrastructure
- Private Compute Engine instances
- Firewall rules and network tags

## Data Sources

The VPC and subnet are not created by this Terraform configuration.

Terraform retrieves information about the existing resources using data blocks.

This demonstrates the difference between:

- `resource` — creates and manages infrastructure.
- `data` — retrieves information about existing infrastructure.

The retrieved attributes are then referenced by other Terraform resources.

## Private VM

The `backend-server` VM does not have an external IP address.

It is connected to the existing:

```text
backend-subnet
```

and receives only an internal IP from:

```text
10.20.0.0/24
```

## Firewall

The firewall rule allows:

```text
Protocol: TCP
Port: 8080
Source: 10.20.0.0/24
Target tag: backend
```

Using a target tag ensures that the firewall rule applies only to VMs with the `backend` network tag.

## Variables

The configuration uses variables for:

```text
project_id
region
zone
machine_type
```

Each variable includes a type, description, and default value.

This reduces hardcoded configuration and makes the Terraform configuration easier to reuse.

## Outputs

After deployment, Terraform displays:

- VM name
- VM internal IP
- VPC name
- Subnet name

Example output from this lab:

```text
subnet-name    = "backend-subnet"
vm-internal-ip = "10.20.0.2"
vm-name        = "backend-server"
vpc-name       = "company-shared-vpc"
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

Review the execution plan:

```bash
terraform plan
```

Deploy the Terraform-managed resources:

```bash
terraform apply
```

View the outputs:

```bash
terraform output
```

## Cleanup

To remove the resources managed by this Terraform configuration:

```bash
terraform destroy
```

The existing VPC and subnet are referenced using data sources, so they are not managed as resources by this Terraform configuration.

## What I Learned

Through this lab, I practiced working with infrastructure that already exists in Google Cloud instead of creating everything with Terraform.

The main concepts I learned were:

- The difference between Terraform resources and data sources.
- How to retrieve information about existing GCP resources.
- How to reference attributes returned by data sources.
- How Terraform resources can depend on existing infrastructure.
- How to create a VM without an external IP.
- How to use outputs to retrieve useful information after deployment.
- How to use resource attributes such as a VM's dynamically assigned internal IP.