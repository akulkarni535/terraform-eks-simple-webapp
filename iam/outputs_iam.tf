output "eks_role" {
    value = aws_iam_role.eks_role.arn
}

output "ec2_role" {
    value = aws_iam_role.ec2_role.arn
}


output "eks_cluster_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.eksroleattach.id
}

output "ec2_rpa_ecr_id" {
  value = aws_iam_role_policy_attachment.ecr_policy.id
}

output "ec2_rpa_cni_id" {
  value = aws_iam_role_policy_attachment.cni_policy.id
}

output "ec2_rpa_worker_id" {
  value = aws_iam_role_policy_attachment.worker_node_policy.id
}