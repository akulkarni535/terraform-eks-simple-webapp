#provider "aws" {
#    region = "us-east-2"
#}

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
  }
}





resource "kubernetes_deployment" "myapp" {
    metadata { 
        name = var.name
    }
    spec {
        replicas = var.replicas
        selector  {
            match_labels ={
                app = "hello"
            }
        }
    
    template {
        metadata {
            labels = {
                app = "hello"
            }
        }
        spec {
            container {
                name = var.name
                image = var.image
                port {
                    container_port = var.container_port
                }
            }
        }
        }

        }
    }


resource "kubernetes_service" "myapp_service" {
    metadata {
        name = var.name
    }
    spec {
        selector = {
            app = "hello"
        }
        port {
            port = 80
            target_port = 80
        }
        type = "LoadBalancer"
        }

    }

