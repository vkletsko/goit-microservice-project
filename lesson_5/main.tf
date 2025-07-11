# Підключаємо модуль для S3 та DynamoDB
module "s3_backend" {
  source = "./modules/s3-backend"            
  bucket_name = "goit-cicd-tf-state-s3-bucket-vitalii1"
  table_name  = "goit-cicd-tf-locks-dyndb-vitalii"
}

# Підключаємо модуль VPC
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr_block      = "10.0.0.0/16"
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  # availability_zones  = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  vpc_name            = "goit-cicd-vpc"
}

# Підключаємо модуль ECR
module "ecr" {
  source           = "./modules/ecr"
  repository_name  = "lesson-5-ecr"
}

