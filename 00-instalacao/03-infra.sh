cd terraform || exit

terraform init
terraform plan
terraform show
terraform apply -auto-approve