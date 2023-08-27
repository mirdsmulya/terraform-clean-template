# Terraform GCP Infrastructure Template

This repository contains a reusable and clean Terraform template for provisioning infrastructure on Google Cloud Platform (GCP). The template leverages a modular approach and uses a `local.tf` file to customize the main infrastructure according to your requirements.


## Prerequisites

Before you begin, ensure you have the following in place:

- [Terraform](https://www.terraform.io/downloads.html) installed locally (v1.1 or higher).
- A [Google Cloud Platform (GCP) account](https://cloud.google.com/) and project.
- Authentication credentials and proper IAM roles to provision resources within your GCP project.

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/your-username/terraform-gcp-template.git
   cd terraform-gcp-template

2. Customize Configuration:

    Customize the `local.tf` file with your desired configuration variables. This is where you can set specific values such as project names, instance sizes, and any other parameters that are specific to your project.

3. Initialize Terraform:

    Initialize the Terraform working directory:

    ```bash
    terraform init

3. Preview the changes on each gcp service directory one by one:

    ```bash
    terraform plan

    This step will give you an overview of the resources that Terraform plans to create, modify, or delete based on your configuration.

4. Apply Changes:
    Apply the changes to create your GCP infrastructure:

    ```bash
    terraform apply

Review the changes listed and confirm by typing yes when prompted. Terraform will then provision your GCP resources according to your configuration.

Note: Be cautious when applying changes, especially in a production environment. Terraform will make the changes as described in the plan without further confirmation.