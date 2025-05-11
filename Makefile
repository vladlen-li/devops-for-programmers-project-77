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

build-infra:
	terraform -chdir=./terraform apply

destroy-infra:
	terraform -chdir=./terraform destroy

deploy: ansible-dependencies ansible-deploy

destroy: ansible-destroy

edit-secrets: ansible-edit-secrets

