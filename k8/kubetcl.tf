# resource "kubectl_manifest" "laravel_ns" {
#   yaml_body = file("${path.module}/laravel/deployment.yaml")
#   }
 resource "kubectl_manifest""laravel_dep" {
  yaml_body = file("deployment.yaml")  
  # depends_on = [
  #   kubectl_manifest.laravel_ns
  # ]
    }
  resource "kubectl_manifest" "laravel_cvc"{
    yaml_body = file("service.yaml")  
  # depends_on = [
  #  kubectl_manifest.laravel_ns
  # ]
  }