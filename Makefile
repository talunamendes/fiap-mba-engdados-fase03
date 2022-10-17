MYPY_OPTIONS = --ignore-missing-imports --disallow-untyped-calls --disallow-untyped-defs --disallow-incomplete-defs

.PHONY: install
install:
	poetry run npm -g install serverless
	poetry install

.PHONY: setup
setup: create-dataset terraform

.PHONY: create-dataset
create-dataset:
	poetry run sh 00-instalacao/01-download-dataset.sh
	poetry run sh 00-instalacao/02-break-dataset.sh

.PHONY: terraform
terraform:
	poetry run sh 00-instalacao/03-infra.sh

.PHONY: start
start:
	poetry run sh 01-start/start.sh
