include .env
export $(shell sed 's/=.*//' .env)

ansible-dependencies:
	ansible-galaxy install -r ansible/requirements.yml

ansible-deploy:
	ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --vault-password-file ansible/get_vault_key  --skip-tags destroy

ansible-destroy:
	ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --vault-password-file ansible/get_vault_key --tags destroy

ansible-edit-secrets:
	ansible-vault edit ansible/group_vars/webservers/vault.yml --vault-password-file ansible/get_vault_key

plan-infra:
	terraform -chdir=./terraform plan

build-infra:
	terraform -chdir=./terraform apply -var-file=secret.tfvars

destroy-infra:
	terraform -chdir=./terraform destroy

reinit-infra:
	terraform -chdir=./terraform init -upgrade

deploy: ansible-dependencies ansible-deploy

destroy: ansible-destroy

edit-secrets: ansible-edit-secrets

