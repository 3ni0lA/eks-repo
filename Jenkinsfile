 pipeline{
         agent any
         environment {
              AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
              AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
              AWS_DEFAULT_REGION = "eu-west-1"
         }
         stages {
              stage("Create an EKS Cluster") {
                steps {
                     script {
                         dir('eks-repo') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }  
                      stage("Deploy to EKS") {
            steps {
                script {
                    dir('sockapp') {
                        sh "aws eks update-kubeconfig --name demo"
                        sh "kubectl apply -f demo.yaml"
                    }
                }
            }
        }
    }
}
