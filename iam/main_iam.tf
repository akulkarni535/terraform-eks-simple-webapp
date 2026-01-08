resource "aws_iam_role" "eksrole" {
  name               = "${var.name}-eks-role"
  assume_role_policy = data.aws_iam_policy_document.eksrolepolicy.json
}


data "aws_iam_policy_document" "eksrolepolicy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}



resource "aws_iam_role_policy_attachment" "eksroleattach" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
   role = aws_iam_role.eks_role.name
}


resource "aws_iam_role" "ec2_role" {
    name = "${var.name}-ec2-role"
    assume_role_policy = data.aws_iam_policy_document.ec2_role_policy.json
}


data "aws_iam_policy_document" "ec2_role_policy" {
    statement  {
        effect   = "Allow"
        actions   = ["sts:AssumeRole"]
        principals {
        type = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }
      }
}

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
    role = aws_iam_role.ec2_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {
    role = aws_iam_role.ec2_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
    role = aws_iam_role.ec2_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}


