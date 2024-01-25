# OpenMetadata Deployment scripts

This repository holds deployment scripts for OpenMetadata in your cloud.

## Terraform - AWS

Terraform files to deploy Openmetadata/Collate in AWS.
Although the resources defined here cover most of the required components to deploy the application, a careful review of each should be made, adapting what we provide to the needs of your company.

For instance, database passwords are generated using a `random` resource, therefore storing the secret in plain text in the tfstate.
You will also need to adapt the backup policies, naming, tags, etc to your company policies. Providing variables to customize each of these would end on an unusable module.

## BYOC - AWS

Helper files to deploy OpenMetadata/Collate in AWS. Before using the files, please make sure to fill in the placeholders.
