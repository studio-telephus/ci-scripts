#!/usr/bin/env bash
: "${TF_VAR_env?}"
: "${TF_VAR_org_name?}"
: "${TF_VAR_product_name?}"
: "${TF_VAR_component_name?}"
: "${TF_VAR_region?}"
: "${CI_S3_MINIO_ADM_ENDPOINT?}"
: "${CI_MINIO_ADM_SA_ACCESS_KEY?}"
: "${CI_MINIO_ADM_SA_SECRET_KEY?}"

BACKEND_CONFIG_BUCKET="${TF_VAR_org_name}-state-${TF_VAR_env}"
BACKEND_CONFIG_KEY="${TF_VAR_product_name}/${TF_VAR_component_name}/tfstate.json"
BACKEND_CONFIG_REGION="${TF_VAR_region}"

terraform init -upgrade \
  -backend-config=endpoint="${CI_S3_MINIO_ADM_ENDPOINT}" \
  -backend-config=access_key="${CI_MINIO_ADM_SA_ACCESS_KEY}" \
  -backend-config=secret_key="${CI_MINIO_ADM_SA_SECRET_KEY}" \
  -backend-config=bucket="${BACKEND_CONFIG_BUCKET}" \
  -backend-config=key="${BACKEND_CONFIG_KEY}" \
  -backend-config=region="${BACKEND_CONFIG_REGION}" \
  -backend-config=skip_credentials_validation=true \
  -backend-config=skip_metadata_api_check=true \
  -backend-config=skip_region_validation=true \
  -backend-config=force_path_style=true
