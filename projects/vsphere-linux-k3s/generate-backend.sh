#!/bin/bash

cat <<EOF > backend.hcl
terraform {
    bucket      = "yc-srv1-tfstate"
    credentials = ${TF_VAR_GCP_cred} 
    prefix      = "terraform/state/${PWD##*/}"
}
EOF
