terraform {
  backend "s3" {
    bucket       = "uc-11-docker-nginx"
    key          = "terraform.tfstate"
    region       = "us-west-1"
    
  }
}