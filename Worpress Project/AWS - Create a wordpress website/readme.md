# Terraform: Deploying a Wordpress Website on AWS using EC2 
This project deploys an Ec2 instance( Ubuntu) on AWS, a DB instance. configures Wordpress,installs apache2, and database inside the server by running linux commands. 

### Resources Deployed:

- VPC
- Subnet
- Route Table 
- Internet Gateway 
- Security Group 
- DB instance 
- EC2

### Notes:

- Keypair - The keypair used is an already existing key pair on my AWS, other create a new one 
- AMI id - ensure the AMI is region specific, ensure the region specified on your tfvar is same as the region where you picked your AMI ID (AMI IDS)[https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#LaunchInstances]
- Ensure instance type for DB instance is at 