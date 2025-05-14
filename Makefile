include .env
export $(shell sed 's/=.*//' .env)

.PHONY: ansible-dependencies ansible-deploy ansible-destroy ansible-edit-secrets ansible-generate-terraform-vars \
        terraform-init terraform-plan terraform-apply terraform-destroy terraform-reinit \
        deploy destroy edit-secrets build-infra update-dns

ansible-dependencies:
	make -C ansible dependencies

ansible-deploy:
	make -C ansible play-deploy

ansible-destroy:
	make -C ansible play-destroy

ansible-edit-secrets:
	make -C ansible edit-secrets

ansible-generate-terraform-vars:
	make -C ansible generate-terraform-vars

terraform-init:
	make -C terraform init

terraform-plan:
	make -C terraform plan

terraform-apply:
	make -C terraform apply

terraform-destroy:
	make -C terraform destroy

terraform-reinit:
	make -C terraform reinit

update-dns:
	./update-dns-records.sh

deploy: ansible-dependencies ansible-deploy

destroy: ansible-destroy

edit-secrets: ansible-edit-secrets

build-infra: ansible-generate-terraform-vars terraform-apply update-dns
