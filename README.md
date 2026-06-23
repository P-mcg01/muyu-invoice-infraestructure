# muyu-infrastructure

This repository contains infrastructure code for the Muyu application.

AWS resources for Muyu are managed with Terraform. This repository is currently
an intentionally small starting point with provider setup and placeholder files.

## Intended Network Architecture

The planned network layout is:

- One VPC
- Two public subnets
- Two private subnets
- Internet Gateway
- Route Tables

## Terraform Workflow

```sh
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy
```
## Local Development

This repository uses `mise` to manage development tools and their versions.

## Prerequisites

After cloning the repository, install all required tools defined in `mise.toml`:

```bash
mise install
```

Verify that the required tools are available:

```bash
terraform version
task --version
```

## Development Workflow

### 1. Initialize Terraform

Initialize the Terraform working directory:

```bash
task init
```
### 2. Format Terraform Files

Format all Terraform files recursively:

```bash
task fmt
```
This command applies Terraform's standard formatting rules across the repository.

### 3. Validate Your Changes

Before opening a pull request, run all checks:

```bash
task check
```

This executes:

* Terraform formatting verification (`terraform fmt -check`)
* Terraform configuration validation (`terraform validate`)

> [!CAUTION]
> Always ensure `task check` completes successfully before opening a pull request.

### Individual Tasks

You can also run tasks individually:

| Task             | Description                      |
| ---------------- | -------------------------------- |
| `task init`      | Initialize Terraform             |
| `task fmt`       | Format Terraform files           |
| `task fmt-check` | Verify Terraform file formatting |
| `task validate`  | Validate Terraform configuration |
| `task check`     | Run all pre-PR checks            |

