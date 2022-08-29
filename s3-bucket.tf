# Terraform for Cloud State Management (Vprofile)
### PROPER REMOTE BACKEND 
# BackEnd: This is where we store the terraform state so we can share with team members.
# No Locking of state if used simulteneously by 2 employees, Could lead to corrupt state
# 

terraform {
    backend "s3" {
    key = "terraform/backend"
    region = "us-east-1"
    }
}

resource "aws_s3_bucket" "b" {
  bucket = "CSM-s3-bucket"
  
  lifecycle {
      prevent_destroy = true
  }
  
  versioning {
      enabled = true
  }
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
