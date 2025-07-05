terraform {
  backend "s3" {
    bucket         = "goit-cicd-tf-state-s3-bucket-vitalii1"
    key            = "lesson-5/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "goit-cicd-tf-locks-dyndb-vitalii"
    encrypt        = true
  }
}