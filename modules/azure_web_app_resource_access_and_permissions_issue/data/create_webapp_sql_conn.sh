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