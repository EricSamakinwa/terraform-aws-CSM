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


