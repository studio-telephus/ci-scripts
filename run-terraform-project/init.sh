#!/usr/bin/env bash
: "${ENV?}"
: "${ORG_NAME?}"
: "${CI_S3_MINIO_ADM_ENDPOINT?}"
: "${CI_MINIO_ADM_SA_ACCESS_KEY?}"
: "${CI_MINIO_ADM_SA_SECRET_KEY?}"
: "${APP_NAME?}"
: "${COMPONENT_NAME?}"

BACKEND_CONFIG_BUCKET="${ORG_NAME}-state-${ENV}"
BACKEND_CONFIG_KEY="${APP_NAME}/${COMPONENT_NAME}/tfstate.json"
BACKEND_CONFIG_REGION="main"

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
