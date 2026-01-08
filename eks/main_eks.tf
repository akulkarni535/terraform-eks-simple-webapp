# modules/simpleapp/main.tf (or a separate file)


resource "aws_eks_cluster" "eks_cluster" {

  name     = var.name
  version = "1.31"
  role_arn = var.eks_arn   # Your EKS control-plane IAM role

  vpc_config {
    subnet_ids = data.aws_subnets.subnets.ids
  }
  depends_on = [
    var.eks_cluster_policy_attachment_id
  ]
}



resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.name}-node-group"
  node_role_arn   = var.ec2_arn
  subnet_ids      = data.aws_subnets.subnets.ids   # pass in the same subnets as your cluster
  instance_types = var.instance_type

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  depends_on = [
    var.ec2_rpa_ecr_id,
    var.ecr_policy,
    var.cni_policy,
  ]

}



