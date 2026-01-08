data "aws_vpc" "vpc" {
    default = true
}

data "aws_subnets" "subnets" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.vpc.id]
    }
}


output "cluster_name" {value = aws_eks_cluster.eks_cluster.name}
output "cluster_arn" {value = aws_eks_cluster.eks_cluster.arn}
output "cluster_endpoint" {value = aws_eks_cluster.eks_cluster.endpoint}
output "cluster_ca" {value = aws_eks_cluster.eks_cluster.certificate_authority}
output "desired_size" {value = var.desired_size}
output "min_size" {value = var.min_size}
output "max_size" {value = var.max_size}