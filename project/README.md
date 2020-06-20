# ESLZ (Enterprise Scale Landing Zone) project blueprint

## Description

This blueprint will deploy the project specific resources needed to support the Client Project.

The following resources will be deployed by this blueprint:

1. Project resource group
2. Azure Active Directory group members for the project
3. NSG (Network Security Group) for MAZ, PAZ, OZ and RZ
4. Project storage account
5. Demo linux management VM

## Deployment

1. Launch the development workspace in a container following the instructions found at: https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/getting_started/getting_started.md
2. If not already logged-in:
```
rover login
```
3. Select the subscription to use with:
```
az account set --subscription <subscription_GUID>
```
4. Make sure you install or have access to the existing subscription launchpad with:
```
launchpad /tf/launchpads/launchpad_opensource_light apply -var 'location=canadacentral'
```
5. Edit the content of the desired variable files ScSc.tfvars (sandobx), ScDc.tfvars (dev) or ScPc.tfvars (prod) files depending on the environment LZ config you want to deploy.
6. Deploy the desired Landing Zone environment resources by running the following commands:
```sh
cd /tf/caf/LZ
./rover-apply-Sc<letter of the environment you want to deply>c.sh
```
