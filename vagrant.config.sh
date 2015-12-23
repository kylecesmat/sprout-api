#!/bin/bash
declare -A env
########## CONFIG ##########
env[APP_NAME]="sprout-app"
env[DB_NAME]="database_vm"
env[DB_USER]="mongodb"
env[DB_PASS]="mongodbpass"
env[DB_HOST]="localhost"
env[DB_PORT]="5432"
env[APP_ENV]="$1"
env[NODE_ENV]="$1"
########## DO NOT EDIT BELOW THIS LINE ##########

## Fixes stdin: is not a tty warning
sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
