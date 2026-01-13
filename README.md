# EKS Terraform Module

This repo contains Terraform code to deploy a containerized application on AWS EKS.

## What Gets Created

- VPC with public and private subnets across 2 AZs
- NAT Gateway for outbound internet access from private subnets
- EKS cluster with managed node group
- Sample nginx deployment exposed via LoadBalancer

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate credentials
- kubectl

## Quick Start

1. **Set AWS credentials**

```bash
export AWS_ACCESS_KEY_ID="key"
export AWS_SECRET_ACCESS_KEY="secret"
export AWS_SESSION_TOKEN="token"  # if using temporary creds
```

2. **Initialize Terraform**

```bash
terraform init
```

3. **Review the plan**

```bash
terraform plan
```

4. **Apply the configuration**

```bash
terraform apply
```

This takes about 15-20 minutes. EKS cluster creation is the longest part.

5. **Configure kubectl**

After apply completes, run the command from the output:

```bash
aws eks update-kubeconfig --region us-east-1 --name demo-eks-cluster
```

6. **Verify the deployment**

```bash
kubectl get nodes
kubectl get pods -n demo-app
kubectl get svc -n demo-app
```

7. **Access the application**

Grab the LoadBalancer URL:

```bash
kubectl get svc nginx -n demo-app -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```

Open it in your browser. You should see the nginx welcome page.

## Customization

Edit `terraform.tfvars` to change:

- `aws_region` - AWS region
- `project_name` - Prefix for all resources
- `cluster_version` - Kubernetes version
- `node_instance_type` - EC2 instance type for nodes
- `node_desired_count` - Number of worker nodes

## Cleanup

```bash
terraform destroy
```


## Project Structure

```
.
├── main.tf              # Root module, wires everything together
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── providers.tf         # Provider configuration
├── versions.tf          # Terraform and provider versions
├── kubernetes.tf        # K8s resources (deployment, service)
├── terraform.tfvars     # Default variable values
└── modules/
    ├── vpc/             # VPC, subnets, NAT, routing
    └── eks/             # EKS cluster and node group
```
