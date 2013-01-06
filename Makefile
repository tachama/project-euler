# Makefile : workspace setup.

.PHONY: clean exec sync

# clean non-source files (*.pyc etc)
clean:
	@echo "remove non-source files"
	rm -f *.pyc
	rm -f a.out *.hi *.o core

# add exec-permission for script files.
exec:
	@echo "add exec-permission to scripts"
	chmod +x *.py

# sync with github
sync:
	@echo "sync with github"
	git push -u origin master
