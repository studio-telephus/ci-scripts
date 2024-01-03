#!/usr/bin/env bash

TERRAFORM_PLAN_FILE=.terraform/tf-plan.out
terraform plan --out ${TERRAFORM_PLAN_FILE}
