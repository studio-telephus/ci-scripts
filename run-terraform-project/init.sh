#!/usr/bin/env bash
: "${TF_VAR_env?}"
: "${TF_VAR_org_name?}"
: "${TF_VAR_product_name?}"
: "${TF_VAR_component_name?}"
: "${TF_VAR_region?}"
: "${MINIO_ADM_S3_ENDPOINT?}"
: "${MINIO_ADM_SA_ACCESS_KEY?}"
: "${MINIO_ADM_SA_SECRET_KEY?}"

BACKEND_CONFIG_BUCKET="bucket-${TF_VAR_org_name}-state-${TF_VAR_env}"
echo "Preparing for Terraform init: bucket=$BACKEND_CONFIG_BUCKET"
BACKEND_CONFIG_KEY="${TF_VAR_product_name}/${TF_VAR_component_name}/tfstate.json"
echo "Preparing for Terraform init: key=$BACKEND_CONFIG_KEY"
BACKEND_CONFIG_REGION="${TF_VAR_region}"
echo "Preparing for Terraform init: region=$BACKEND_CONFIG_REGION"

terraform init -upgrade \
  -backend-config=endpoint="${MINIO_ADM_S3_ENDPOINT}" \
  -backend-config=access_key="${MINIO_ADM_SA_ACCESS_KEY}" \
  -backend-config=secret_key="${MINIO_ADM_SA_SECRET_KEY}" \
  -backend-config=bucket="${BACKEND_CONFIG_BUCKET}" \
  -backend-config=key="${BACKEND_CONFIG_KEY}" \
  -backend-config=region="${BACKEND_CONFIG_REGION}" \
  -backend-config=skip_credentials_validation=true \
  -backend-config=skip_metadata_api_check=true \
  -backend-config=skip_region_validation=true \
  -backend-config=force_path_style=true
