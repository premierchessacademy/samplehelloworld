terraform {

 backend "s3" {
    bucket         = "pca-terraform-bucket"
    region         = "us-east-1"
    encrypt        = "true"
    dynamodb_table = "TF_LOCK_TABLE"
    key            = "pca-helloworld.tfstate"
  }

}