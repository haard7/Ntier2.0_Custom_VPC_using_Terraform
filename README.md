# Ntier 2.0
## Custom VPC using Terraform configured with RDS, EC2 

![VPC_Using_Terraform drawio](https://github.com/haard7/Ntier2.0_Custom_VPC_using_Terraform/assets/69381806/d930e459-2735-4528-9dea-36ccaa0a18b7)


### This project contains terraform configuration files on creating EC2 and RDS instances inside a Custom VPC on AWS. Basic information about the architecture is here  below

## Set Up
### Prerequisites
- Ubuntu installed and configuration
- [Terraform](https://www.terraform.io/downloads) installed

### Edit the terraform.tfvars file
 - **access key** <-- your access key from AWS account 
  - **Secret Key** <-- your secret key from AWS account. Be very careful when sharing your code. Change this before sharing 
  - **db_username** <-- this is going to be the master user for RDS
  - **db_password** <-- this is going to be the RDS 


### SSH configuration
- Create the .ssh file and have your private and public key created. Make the changes in **Key-pairs.tf**

## Running the Configuration
### Initializing the Terraform directory
Run the command: `terraform init`

### Create the plan of what we will create on AWS
Run the command: `terraform plan`

### Apply the Terraform Config to AWS
Run the command: `terraform apply -auto-approve`

### To destroy everything that was created by the Terraform Config
Run the command: `terraform destroy -var-file="secrets.tfvars"`
## Basic Configuration


### Security Groups
```bash
Ntier 2.0 Configuration

Internal-default-SG
	allow all traffic 
	for all things Internal
	allows itself
	and gets associated with everything Internal

NAT-SG
	allow TCP/22 for SSH
	allow UDP/1194 for OpenVPN

Web-SG
	allow TCP/80 for http
	allow TCP/443 for https
   allow TCP/22 for SSH

DB_server_SG
   allow TCP/3306 for MySQL 
```
### Instances (EC2 and RDS)

```bash
NAT Machine
   Security Group: NAT-SG
                   Internal-default-SG
   Subnet: Public Subnet
  

M0, M1 etc.
   Security Group: Internal-default-SG
   Subnet: private Subnet 

RDS_db instance
   Security Group:  Web_SG
   Subnet: private Subnet 
   It is the database instance in the RDS

Db_instance
   Security Group:  Db_server_SG
   Subnet: public Subnet 
   It is the db instance in public subnet. It is used to communicate with the rds database using port 3306.
```

### Fault tolerance and high availability
```bash
Load Balancer
	Internal-default-SG
	Web-SG

Availability zones
    US_west_1a
    US_west_1c

    Both the Availability zones are used for fault tolerant system in app servers app1 and app2 
```

## Acknowledgements and References

 - [Ntier exercise from @beacloudgenius](https://github.com/beacloudgenius/ntier)
 - [Medium article by @Mat Little](https://medium.com/strategio/using-terraform-to-create-aws-vpc-ec2-and-rds-instances-c7f3aa416133)


 ### All are welcomed to collaborate in this project. There are still many improvemnts are required to make. It is not completely "Resilient" and "FaultTolerant"

 No-copyright@2023 


 ### Thank You


