# Cross-Account IAM with CloudFormation, Jenkins, and LocalStack

## Project Objective
Simulate a cross-account IAM role and access flow using:
- AWS IAM (Roles, Policies, Trust Relationships)
- CloudFormation templates
- Jenkins pipeline for automation
- LocalStack for local AWS simulation (no real AWS charges)

---
```bash
## Folder Structure
❯ tree -L 3 --gitignore
.
├── cloudformation
│   ├── accountA-role.yaml
│   ├── accountB-user.yaml
│   └── s3-bucket.yaml
├── docker-compose.yaml
├── jenkins
│   ├── deploy-pipeline.groovy
│   └── Jenkinsfile
├── README.md
└── scripts
    ├── assume-role.sh
    └── test-s3-access.sh

4 directories, 9 files
```

## Step 1: Prerequisites

- Docker and Docker Compose installed
- Jenkins installed via Docker
- LocalStack installed via Docker
- AWS CLI installed (`aws` command)
- `jq` installed for parsing JSON



## Step 2: Starting the Environment

```bash
docker-compose up -d
```

## Step 3: Jenkins Configuration
- Open Jenkins (localhost:8080)

- Install basic plugins if prompted.

- Create a simple pipeline project:

- Name: cross-account-iam-deploy

- Point it to your jenkins/Jenkinsfile in this repository.

- Configure credentials/environment if necessary.



## Step 4: CloudFormation Deployment (via Jenkins)
Trigger the Jenkins pipeline. It will:

- Create an IAM Role (accountA-role.yaml)

- Create an IAM User (accountB-user.yaml)

- Create an S3 Bucket (s3-bucket.yaml)

- All deployments happen in LocalStack.


## Step 5: Assume Role and Access S3 (Testing)

1. Run the script to assume the IAM Role:

    ```bash
    ./scripts/assume-role.sh
    ```

    - This uses `sts:AssumeRole` to get temporary credentials.
    - The output is saved into `temp-creds.json`.

2. Test S3 access using the temporary credentials:

    ```bash
    ./scripts/test-s3-access.sh
    ```

    - This script uses the temporary credentials to access the `cross-account-test-bucket`.

## To Force Jenkins container to use your local timezone
    1. Pass local timezone environment variable when running Jenkins Container:
        In `docker-compose.yaml` for Jenkins

        services:
            jenkins:
                ...
                environment:
                    - TZ=America/New_York
                volumes:
                    - /etc/localtime:/etc/localtime:ro
                    - /etc/timezone:/etc/timezone:ro
        

        ✅ TZ=America/New_York sets timezone inside container.

        ✅ Mounting /etc/localtime and /etc/timezone ensures that Linux in container syncs with your host time settings.



