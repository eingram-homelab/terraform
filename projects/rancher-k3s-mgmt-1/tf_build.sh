#!/bin/bash

ENVIRONMENT = ${PWD##*/}
terraform init -backend-config=backend.hcl
