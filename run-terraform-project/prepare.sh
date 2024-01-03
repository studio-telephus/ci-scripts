#!/usr/bin/env bash
: "${TF_VAR_env?}"

ACCOUNT_VARS_FILE=variables/account/${TF_VAR_env}/${TF_VAR_env}.tfvars

if [ -f ${ACCOUNT_VARS_FILE} ]; then
  cp ${ACCOUNT_VARS_FILE} ${ENV}.auto.tfvars ;
else
  echo "File [${ACCOUNT_VARS_FILE}] not found, skipping."
fi
