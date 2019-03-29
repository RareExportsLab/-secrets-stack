help:	## Help Menu
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
run:	## make run - Run Docker
	@docker-compose -p secrets up -d --build
stop:	## make stop - stop Docker
	@docker-compose -p secrets down
clean-data:	## make clean-data - stops and removes containers,networks,volumes, and images
	@docker-compose -p secrets down -v
vault-logs: ## view logs on vault
	@docker-compose -p secrets logs
vault-ssh: ## SSH access to Vault
	@docker-compose -p secrets exec vault bash
vault-init: ##vault operator init to initialize the vault server. Take note of the Unseal Keys and the Initial Root Token. Without these, the vault is lost when sealed/locked
	@docker-compose -p secret exec vault vault operator init
vault-unseal: #vault operator unseal to unseal/open the vault. Follow the onscreen instructions and use 3 of the five Unseal Keys
	@docker-compose -p secret exec vault vault operator unseal
