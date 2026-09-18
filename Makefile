.PHONY: academy-site build deploy deploy-dry-run clean

SFTP_HOST := ssh.cab9tolit.service.one
SFTP_PORT := 22
SFTP_USER := cab9tolit_ssh
REMOTE_DIR := webroots/4f0fa1a1
PUBLIC_DIR := public
ACADEMY_DIR := ../project-polaris-academy
ACADEMY_SITE_DIR := $(ACADEMY_DIR)/build/site
NOTES_DIR := $(PUBLIC_DIR)/notes

academy-site:
	$(MAKE) -C $(ACADEMY_DIR) site

build: academy-site
	rm -rf $(PUBLIC_DIR)
	hugo --minify
	mkdir -p $(NOTES_DIR)
	rsync -a --delete $(ACADEMY_SITE_DIR)/ $(NOTES_DIR)/

deploy: build
	lftp -u $(SFTP_USER) sftp://$(SFTP_HOST):$(SFTP_PORT) -e "\
		set cmd:fail-exit yes; \
		cd $(REMOTE_DIR); \
		mirror --reverse --delete --verbose $(PUBLIC_DIR)/ ./; \
		bye"

deploy-dry-run: build
	lftp -u $(SFTP_USER) sftp://$(SFTP_HOST):$(SFTP_PORT) -e "\
		set cmd:fail-exit yes; \
		cd $(REMOTE_DIR); \
		mirror --reverse --delete --verbose --dry-run $(PUBLIC_DIR)/ ./; \
		bye"

clean:
	rm -rf $(PUBLIC_DIR)
