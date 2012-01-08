# Makefile : workspace setup.

.PHONY: clean exec

# clean non-source files (*.pyc etc)
clean:
	@echo "remove non-source files"
	rm -f *.pyc
	rm -f a.out *.hi *.o

# add exec-permission for script files.
exec:
	@echo "add exec-permission to scripts"
	chmod +x *.py
