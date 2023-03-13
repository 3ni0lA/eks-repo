resource "kubernetes_deployment" "laravel" {
  metadata {
    name = "laravel"
    labels = {
      test = "My-Laravel-App"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "My-Laravel-App"
      }
    }

    template {
      metadata {
        labels = {
          test = "My-Laravel-App"
        }
      }

      spec {
        container {
          image = "3niola/webapp02"
          name  = "laravel-pod"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
    resource "kubernetes_service" "laravel" {
  metadata {
    name = "laravel"
  }
  spec {
    selector = {
      test = "My-Laravel-App"
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}