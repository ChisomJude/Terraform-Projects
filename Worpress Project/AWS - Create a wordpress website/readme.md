# Terraform: Deploying a Wordpress Website on AWS using EC2 
This project deploys an Ec2 instance( Ubuntu) on AWS, a DB instance. configures Wordpress, installs Apache2, and Database inside the server by running Linux commands. 

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
- AMI id - ensure the AMI is region-specific, ensure the region specified on your tfvars is same as the region where you picked your AMI ID (AMI IDS)[https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#LaunchInstances]
- Ensure instance type for DB instance has size of t3

- After running the script:
  ![Completed State](https://github.com/ChisomJude/Terraform-Projects/blob/master/completed.PNG))

  Checking the IP on the Browser
  ![WordPress View](https://github.com/ChisomJude/Terraform-Projects/blob/master/view.PNG)
