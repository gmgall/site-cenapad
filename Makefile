JEKYLL=jekyll

BASEDIR=$(CURDIR)
OUTPUTDIR=$(BASEDIR)/_site

SSH_HOST=
SSH_PORT=
SSH_USER=
SSH_TARGET_DIR=

help:
	@echo 'Simple makefile for generate the jekyll web site                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make clean                       remove the generated files         '
	@echo '   make serve [PORT=4000]           serve site at http://localhost:4000'
	@echo '   make ssh_upload                  upload the web site via SSH        '
	@echo '                                                                       '

html:
	$(JEKYLL) build

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

serve: html
	$(JEKYLL) serve

ssh_upload:
	ssh $(SSH_USER)@$(SSH_HOST) 'cd $(SSH_TARGET_DIR) && rm -rf *'
	scp -P $(SSH_PORT) -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)
