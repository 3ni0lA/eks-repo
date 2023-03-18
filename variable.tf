# Configure the AWS Provider
variable "region" {
  default     = "eu-west-2"
  description = "AWS region"
}
variable "cluster_name" {
  default = "first-eks"
}
variable "aws_access_key" {
 default = "" 
}
variable "aws_secret_key" {
  default =""
}
