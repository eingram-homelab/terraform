#!/bin/bash

cat <<EOF > backend.tf
terraform {
    backend "gcs" {
        bucket      = "yc-srv1-tfstate"
        credentials = ${TF_VAR_GCP_cred} 
        prefix      = "terraform/state/${PWD##*/}"
    }
}
EOF
