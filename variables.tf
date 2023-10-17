variable "access_key" {
  description = "AWS access key"
  sensitive   = true
}

variable "secret_key" {
  description = "AWS secret access key"
  sensitive   = true
}

variable "region" {
  description = "AWS region"
  default     = "us-west-1"
}

variable "aws_availability_zones" {
  description = "A list of availability zones"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1c"] # Adjust with your actual AZs
}

// Rather than making two variables for two different availability zones
// Let's create a single and all AZ will be included
// That variable is in aws_vpc.tf file

# variable "az1" {
#   description = "AWS Availability Zone 1"
#   default     = "us-west-1a"
# }

# variable "az2" {
#   description = "AWS Availability Zone 1"
#   default     = "us-west-1c"
# }


variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.128.0.0/16"
}
// We can also add the number of blocks for public subnet. But Currently we are not using this subnet other than the NAT.
variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.128.0.0/24"
}

// Here CIDR blocks for private subnets are defined
// Here I have made the list because we have multiple number of private subnets
variable "private_subnet_cidr" {
  description = "Available CIDR blocks for private subnets"
  #   default     = "10.128.1.0/24"
  type = list(string)
  default = [
    "10.128.1.0/24",
    "10.128.2.0/24",
    "10.128.3.0/24",
    "10.128.4.0/24",
  ]
}

// number of public and private subnets
variable "subnet_count" {
  description = "Number of Subnets"
  type        = map(number)
  default = {
    public  = 1,
    private = 2
  }
}

// Configuration for RDS and EC2 instances
variable "settings" {
  description = "Configuration Settings"
  type        = map(any)
  default = {
    "database" = {
      allocated_storage   = 10
      engine              = "mysql"
      engine_version      = "8.0.32"
      instance_class      = "db.t2.micro"
      db_name             = "tutorial"
      skip_final_snapshot = true
    },
    "web_app" = {
      count         = 1
      instance_type = "t2.micro"
    }
  }
}

variable "db_username" {
  description = "Database master user"
  type        = string
  sensitive   = true
}
// Pass stored in a secret file
variable "db_password" {
  description = "Database master user password"
  type        = string
  sensitive   = true
}

/* Ubuntu bionic 18.04 AMIs by region */
variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-gov-east-1  = "ami-73db3802"
    us-gov-west-1  = "ami-99f6aaf8"
    us-west-2      = "ami-0a7d051a1c4b54f65"
    us-west-1      = "ami-0f42d8c4eb586ccf7"
    us-east-2      = "ami-059d836af932792c3"
    us-east-1      = "ami-00a208c7cdba991ea"
    sa-east-1      = "ami-049f5d88d2d436431"
    me-south-1     = "ami-026d8603b92fddf7a"
    eu-west-3      = "ami-0b70d1460d5c7a299"
    eu-west-2      = "ami-00622b440d92e55c0"
    eu-west-1      = "ami-04c58523038d79132"
    eu-north-1     = "ami-005bc7d72deb72a3d"
    eu-central-1   = "ami-09356619876445425"
    ca-central-1   = "ami-0972a0d3135cf1fc0"
    ap-southeast-2 = "ami-04a0f7552cff370ba"
    ap-southeast-1 = "ami-07febfdfb4080320e"
    ap-south-1     = "ami-0245841fc4b40e22f"
    ap-northeast-3 = "ami-05f50017c0424c060"
    ap-northeast-2 = "ami-02b4a5559ce53a570"
    ap-northeast-1 = "ami-0f6b4f4104d26f399"
    ap-east-1      = "ami-dc98e2ad"
  }
}
