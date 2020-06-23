# ESLZ (Enterprise Scale Landing Zone) launchpad blueprint

## Description

This level 0 blueprint will deploy the required launchpad in support the ESLZ.

The following resources will be deployed by this blueprint:

1. Azure Active Directory Security Groups for level0-rover-developers
2. Launchpad enterprise application
3. Launchpad resourcegroup
4. Launchpad keyvault for terraform secrets
5. Launchpad Log Analytics Workspace and KeyVaultAnalytics solutions
6. Launchpad Storage Account for terraform state
7. Launchpad Storage Account for diagnostic logs

## Deployment

1. If you have more than one subscription associated to your user, and even you don't, update the `global.envvars` file located in the `envvars` folder with the desired Azure subscription id. This way all commands used in the blueprint will automatically target this subscription.

2. Launch the development workspace in a container following the instructions found at: https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/getting_started/getting_started.md

3. If not already logged-in:

```
rover login
```

4. Configure the level0.tfvars file with the desired values

5. Install the subscription launchpad. For example, to install the launchpad in a dev subscription do:

```
cd L0_blueprint_launchpad
./golaunchpad.sh dev apply
```

## Managing access to the launchpad

If you want to allow more than one user to deploy code based on this launchpad you will need to add them as members of the Azure Active Directory security group that was created as part of the `L0_blueprint_launchpad` deployment.

This membership assignment is handles in the L1_blueprint_base deployment. Simply add any user login email address as found in Azure Active Directory to the desired `<environment>.tfvar` file located in the `L1_blueprint_base/environments` folder. You will list toes identitied in the `L1_RBAC` variable object definition under the `ownerNames` list. For example:

```json
L1_RBAC = {
  ownerNames = [
    "user1.name@111dev.onmicrosoft.com",
    "user1.name@111dev.onmicrosoft.com"
  ]

  contributorNames = []

  readerNames = []
}
```

You can add as many as you need. You can also remove them when needed and simple re-run the `rover-<environment>.sh` script to update the membership.
