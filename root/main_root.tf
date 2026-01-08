provider "aws"{
    region = "us-east-2"
}

provider "kubernetes" {
  host = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(
    module.eks_cluster.cluster_ca[0].data
  )
  token = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_name
}

module "eks_cluster" {
    source = "../eks"
    name = "stage-app"
    eks_arn = module.iam.eks_role
    ec2_arn = module.iam.ec2_role
    instance_type = ["t3.small"]
    eks_cluster_policy_attachment_id = module.iam.eks_cluster_policy_attachment_id
    ec2_rpa_ecr_id = module.iam.ec2_rpa_ecr_id 
    ecr_policy = module.iam.ec2_rpa_ecr_id
    cni_policy = module.iam.ec2_rpa_cni_id
    desired_size = 2
    min_size = 1
    max_size = 3

}

module "iam" {
    source = "../iam"
    name = "stage-app"
}




module "simple_webapp" {
  source = "../simpleapp"

  name = "stage-app"

  image          = "nginx:alpine"
  replicas       = 2
  container_port = 80
  


  # Only deploy the app after the cluster has been deployed
  depends_on = [module.eks_cluster]
}


