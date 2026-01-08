# Terraform EKS Simple Webapp

This project provisions an **AWS EKS (Elastic Kubernetes Service)** cluster using Terraform and deploys a simple Kubernetes web application (NGINX) using the Terraform **Kubernetes provider**.

It demonstrates:
- Terraform modules for IAM + EKS
- EKS cluster + managed node group
- Deploying Kubernetes resources via Terraform once the cluster is available

## What It Creates

### AWS
- IAM roles + policy attachments for:
  - EKS control plane
  - Worker nodes
- EKS cluster
- EKS managed node group (EC2 workers)

### Kubernetes
- Deployment: `nginx` (example web workload)
- Service: `ClusterIP` (internal service)

> You can switch the Service type to `LoadBalancer` or add an Ingress for external access.

## Repo Structure

```text
.
├── root/        # Entry point: providers + wiring modules together
├── iam/         # IAM roles/policy attachments
├── eks/         # EKS cluster + node group
└── simpleapp/   # Kubernetes Deployment + Service
