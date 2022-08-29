# Terraform for Cloud State Management (Vprofile)
### PROPER REMOTE BACKEND 
# BackEnd: This is where we store the terraform state so we can share with team members.
# No Locking of state if used simulteneously by 2 employees, Could lead to corrupt state
# 

terraform {
    backend "s3" {
        # Give bucket name
        bucket = "proj1-csm"
        # Name of directory in the bucket (terraform)
        # and a file name to maintain the state (backend)
        key = "terraform/backend"
        # Region 
        region = "us-east-1"
       }
}


