# Dependencies
msOutput=docs/*
msInput=manuscript/manuscript.md
CONF=manuscript/conf/*
BIB=manuscript/references.bib
META=metadata.yml
SUPPINFO=manuscript/suppInfo.md
bibR=manuscript/conf/update_bib.R

# render manuscript pdf
$(msOutput): $(META) $(BIB) $(CONF) $(SUPPINFO)
	@bash manuscript/conf/build.sh $(msInput) $(BIB) $(META) $(SUPPINFO)

# generate bib file
$(BIB): $(msInput) $(bibR)
	@echo [1] check if references are up to date
	@Rscript -e "source('$(bibR)')"

# install dependencies
install:
	Rscript -e 'renv::restore()'

clean: check_clean
	rm -rf $(msOutput)

# check_clean:
# 	@echo -n "Are you sure you want to delete all figures and the associated data? [y/N] " && read ans && [ $${ans:-N} == y ]

.PHONY: install clean check_clean
