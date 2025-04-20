# Terraform AWS VPC Module

This repository contains a Terraform module for provisioning a secure, scalable, and highly available Virtual Private Cloud (VPC) infrastructure in AWS. It includes all necessary networking components such as subnets, route tables, NAT gateways, and network ACLs, following AWS best practices.

## Features

- **VPC Creation**: Provisions a VPC with customizable CIDR blocks.
- **Subnets**: Creates public, private, and database subnets across multiple Availability Zones.
- **Internet Gateway**: Attaches an Internet Gateway for public subnet internet access.
- **NAT Gateways**: Configures NAT Gateways for private subnet internet access.
- **Route Tables**: Manages route tables for public, private, and database subnets.
- **Network ACLs**: Implements NACLs for public, private, and database subnets.
- **Elastic IPs**: Allocates Elastic IPs for NAT Gateways.
- **Reachability Analyzer**: Configures network insights paths and analyses for connectivity validation.
- **Tagging**: Tags all resources for easy identification and management.

## Prerequisites

- **Terraform**: Version >= 1.0
- **AWS Provider**: Version >= 4.0
- **AWS CLI**: Configured with appropriate credentials
- **IAM Permissions**: Sufficient permissions to create VPC resources

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "vpc" {
  source = "github.com/azysir/terraform-aws-vpc"

  # Required variables
  region               = "eu-west-2"
  org                  = "my-organization"
  app                  = "my-application"
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = {
    eu-west-2a = "eu-west-2a"
    eu-west-2b = "eu-west-2b"
    eu-west-2c = "eu-west-2c"
  }
  public_subnet_cidrs  = {
    eu-west-2a = "10.0.1.0/24"
    eu-west-2b = "10.0.2.0/24"
    eu-west-2c = "10.0.3.0/24"
  }
  private_subnet_cidrs = {
    eu-west-2a = "10.0.4.0/24"
    eu-west-2b = "10.0.5.0/24"
    eu-west-2c = "10.0.6.0/24"
  }
  database_subnet_cidrs = {
    eu-west-2a = "10.0.7.0/24"
    eu-west-2b = "10.0.8.0/24"
    eu-west-2c = "10.0.9.0/24"
  }
}
```

## Input Variables

| Name                   | Description                                         | Type        | Default | Required |
|------------------------|-----------------------------------------------------|-------------|---------|----------|
| `region`           | AWS region to deploy resources                     | `string`    | n/a     | yes      |
| `org`                  | Organization name for resource tagging             | `string`    | n/a     | yes      |
| `app`                  | Application name for resource tagging              | `string`    | n/a     | yes      |
| `vpc_cidr`             | CIDR block for the VPC                             | `string`    | n/a     | yes      |
| `availability_zones`   | Map of availability zones                          | `map(string)` | n/a   | yes      |
| `public_subnet_cidrs`  | Map of public subnet CIDR blocks                   | `map(string)` | n/a   | yes      |
| `private_subnet_cidrs` | Map of private subnet CIDR blocks                  | `map(string)` | n/a   | yes      |
| `database_subnet_cidrs`| Map of database subnet CIDR blocks                 | `map(string)` | n/a   | yes      |

## Outputs

This module does not currently define outputs. You can extend it to output resource IDs or other useful information.

## Components

### VPC
The VPC is defined in [`vpc.tf`](vpc.tf) and includes DNS support and hostnames.

### Subnets
Subnets are defined in [`subnets.tf`](subnets.tf) and categorized into public, private, and database tiers.

### Internet Gateway
The Internet Gateway is configured in [`igw.tf`](igw.tf) and attached to the VPC.

### NAT Gateways
NAT Gateways are provisioned in [`nat.tf`](nat.tf) with Elastic IPs from [`eip.tf`](eip.tf).

### Route Tables
Route tables for public, private, and database subnets are managed in [`route_table.tf`](route_table.tf).

### Network ACLs
Network ACLs for each subnet type are defined in [`nacl.tf`](nacl.tf).

### Reachability Analyzer
Network insights paths and analyses are configured in [`reachability.tf`](reachability.tf) to validate connectivity.

## Development

### Testing
To validate the configuration, run:

```sh
terraform init
terraform validate
terraform plan
```

System Integration Testing is handled in the `reachability.tf` with the utilisation of VPC Reachability Analyzer. These allow for the validation of connectivity between resources.

The test coverage spans betweeen the sunny day scenarion and a rainy day scenario.

**Sunny Day Scenario:** The expected subnets can communicate with each other via the expected ports - these will show up as successful connections in the reachability analyzer.

**Rain Day Scenario:** Communnication is blocked between the expected subnets via unexpected ports - these will show up as failed connecitions in the reachability analyzer.

### Deployment
To deploy the infrastructure, execute:

```sh
terraform apply
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any improvements or bug fixes.