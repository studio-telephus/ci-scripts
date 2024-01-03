#!/usr/bin/env bash

TERRAFORM_PLAN_FILE=.terraform/tf-plan.out

if [ -f ${TERRAFORM_PLAN_FILE} ]; then
  terraform plan --out ${TERRAFORM_PLAN_FILE}
else
  echo "File [${TERRAFORM_PLAN_FILE}] not found!"
  exit 1
fi
