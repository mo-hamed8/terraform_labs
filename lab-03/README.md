# Lab 03 — Terraform State Management

This lab focuses on understanding and managing Terraform state in a Google Cloud environment.

## Objectives

- Understand Terraform state
- Inspect resources stored in state
- Migrate local state to a remote GCS backend
- Detect infrastructure drift
- Use refresh-only operations
- Refactor state using moved blocks
- Stop managing resources using removed blocks
- Import existing infrastructure using import blocks
- Understand Terraform CLI workspaces

## Infrastructure

The lab uses the following Google Cloud resources:

- Custom VPC: `state-lab-vpc`
- Subnet: `state-lab-subnet`
- CIDR: `10.30.0.0/24`
- Compute Engine VM: `state-lab-vm`
- Machine type: `e2-micro`
- Region: `me-central1`
- Zone: `me-central1-a`

## State Inspection

Terraform state was inspected using:

```bash
terraform state list
terraform state show google_compute_instance.vm
terraform show