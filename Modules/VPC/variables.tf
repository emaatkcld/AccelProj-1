#VPC Name
variable "vpc_name" {
  description = "VPC for the Pet Adoption Project"
  type        = string
  default     = "ACPJ1-vpc"
}

variable "name" {
    description = "Name to be associated with all resources for this Project"
    type = string
    default = "ACPJ1"
  
}

variable "all_access" {
  default = "0.0.0.0/0"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "Pub-SN_cidr1" {
  default     = "10.0.1.0/24"
  description = "cidr for public subnet 1"
}

variable "Pub-SN_cidr2" {
  default     = "10.0.2.0/24"
  description = "cidr for public subnet 2"
}

variable "Priv-SN_cidr1" {
  default     = "10.0.3.0/24"
  description = "cidr for private subnet 1"
}

variable "Priv-SN_cidr2" {
  default     = "10.0.4.0/24"
  description = "cidr for private subnet 1"
}

# VPC Availability Zone1
variable "vpc_az1" {
  description = "VPC AZs"
  type        = string
  default     = "eu-west-2a"
}

# VPC Availability Zone2
variable "vpc_az2" {
  description = "VPC AZs"
  type        = string
  default     = "eu-west-2b"
}

# VPC Public Subnets
variable "vpc_pub_sub1" {
  description = "VPC Public Subnet1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vpc_pub_sub2" {
  description = "VPC Public Subnet2"
  type        = string
  default     = "10.0.2.0/24"
}

# VPC Private Subnets
variable "vpc_priv_sub1" {
  description = "VPC Private Subnet1"
  type        = string
  default     = "10.0.3.0/24"
}

# VPC Private Subnets
variable "vpc_priv_sub2" {
  description = "VPC Private Subnet2"
  type        = string
  default     = "10.0.4.0/24"
}

# VPC Database Subnets
variable "vpc_database_subnets" {
  description = "VPC Database Subnets"
  type        = list(string)
  default     = ["10.0.151.0/24", "10.0.152.0/24"]
}

# VPC Create Database Subnet Group (True / False)
variable "vpc_create_database_subnet_group" {
  description = "VPC Create Database Subnet Group"
  type        = bool
  default     = true
}

# VPC Create Database Subnet Route Table (True or False)
variable "vpc_create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type        = bool
  default     = true
}


# VPC Enable NAT Gateway (True or False) 
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type        = bool
  default     = true
}

# VPC Single NAT Gateway (True or False)
variable "vpc_single_nat_gateway" {
  description = "Enable only single NAT Gateway in one Availability Zone to save costs during our demos"
  type        = bool
  default     = true
}