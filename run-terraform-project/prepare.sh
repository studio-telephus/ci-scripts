#!/usr/bin/env bash
: "${ENV?}"

ACCOUNT_VARS_FILE=variables/account/${ENV}/${ENV}.tfvars

if [ -f ${ACCOUNT_VARS_FILE} ]; then
  cp ${ACCOUNT_VARS_FILE} ${ENV}.auto.tfvars ;
else
  echo "File [${ACCOUNT_VARS_FILE}] not found, skipping."
fi
