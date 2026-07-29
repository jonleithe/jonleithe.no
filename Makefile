.PHONY: build deploy deploy-dry-run clean

SFTP_HOST := ssh.cab9tolit.service.one
SFTP_PORT := 22
SFTP_USER := cab9tolit_ssh
REMOTE_DIR := webroots/4f0fa1a1
PUBLIC_DIR := public

build:
	rm -rf $(PUBLIC_DIR)
	hugo --minify

deploy: build
	lftp -u $(SFTP_USER) sftp://$(SFTP_HOST):$(SFTP_PORT) -e "\
		cd $(REMOTE_DIR); \
		mirror --reverse --delete --verbose $(PUBLIC_DIR)/ ./; \
		bye"

deploy-dry-run: build
	lftp -u $(SFTP_USER) sftp://$(SFTP_HOST):$(SFTP_PORT) -e "\
		cd $(REMOTE_DIR); \
		mirror --reverse --delete --verbose --dry-run $(PUBLIC_DIR)/ ./; \
		bye"

clean:
	rm -rf $(PUBLIC_DIR)
