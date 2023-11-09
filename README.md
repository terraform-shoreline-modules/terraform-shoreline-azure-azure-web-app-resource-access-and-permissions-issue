
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Azure Web App Resource Access and Permissions Issue

The incident type "Azure Web App Resource Access and Permissions Issue" refers to the situation where a web application hosted on the Azure platform is unable to access external resources or databases. This can occur due to incorrect connection string settings or access control settings. It is recommended to review the connection strings and access control settings, as well as check the network security group rules if the app is accessing Azure resources. Additionally, it is suggested to check the service connectors and web app networking settings to identify and resolve the issue.

### Parameters

```shell
export RESOURCE_GROUP="PLACEHOLDER"
export APP_NAME="PLACEHOLDER"
export CONNECTION_NAME="PLACEHOLDER"
export NSG_NAME="PLACEHOLDER"
export NSG_RULE_NAME="PLACEHOLDER"
export SERVER_NAME="PLACEHOLDER"
export DATABASE_NAME="PLACEHOLDER"
export SECRET="PLACEHOLDER"
```

## Debug

### Check the web app's connection strings

```shell
az webapp config connection-string list -g ${RESOURCE_GROUP} -n ${APP_NAME}
```

### Check the web app's access control settings

```shell
az webapp identity show -g ${RESOURCE_GROUP} -n ${APP_NAME}
```

### List web app connection

```shell
az webapp connection list -g ${RESOURCE_GROUP} -n ${APP_NAME}
```

### List web app's connection source configuration

```shell
az webapp connection list-configuration -g ${RESOURCE_GROUP} -n ${APP_NAME} --connection ${CONNECTION_NAME}
```

### Check web app networking settings

```shell
az webapp show -g ${RESOURCE_GROUP} -n ${APP_NAME} --query outboundIpAddresses
```

### List the network security group 

```shell
az network nsg rule list --nsg-name ${NSG_NAME} --resource-group ${RESOURCE_GROUP}
```

### Check network security group rules

```shell
az network nsg rule show --resource-group ${RESOURCE_GROUP_NAME} --nsg-name ${NSG_NAME} --name ${NSG_RULE_NAME}
```

## Repair

### Create connection between webapp and database.

```shell
#!/bin/bash

# Set variables
RESOURCE_GROUP=${RESOURCE_GROUP_NAME}
APP_NAME=${WEB_APP_NAME}
SERVER_NAME=${SERVER_NAME}
DATABASE_NAME=${DATABASE_NAME}
SECRET=${SECRET}


# Get a list of supported target services for App Service.
az webapp connection list-support-types -o table

# Create the connecction between webapp and SQL

az webapp connection create sql -g $RESOURCE_GROUP -n $APP_NAME --tg $RESOURCE_GROUP --server $SERVER_NAME --database $DATABASE_NAME --secret $SECRET
```