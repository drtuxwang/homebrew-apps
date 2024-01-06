.PHONY: default
default: help        # Default

.PHONY: time
time:                # Set file timestamps to git commit times (last 7 days)
	@echo "\n*** Fixing git timestamps (last 7 days)***"
	find * -type f -mtime -7 | xargs git time

.PHONY: time-all
time-all:            # Set file timestamps to git commit times (all files)
	@echo "\n*** Fixing git timestamps (all files)***"
	find * -type f | xargs git time

.PHONY: gc
gc:                  # Run git garbage collection
	@du -s $(shell pwd)/.git
	git \
		-c gc.reflogExpire=0 \
		-c gc.reflogExpireUnreachable=0 \
		-c gc.rerereresolved=0 \
		-c gc.rerereunresolved=0 \
		-c gc.pruneExpire=now gc \
		--aggressive
	@du -s $(shell pwd)/.git

.PHONY: reset
reset:               # Reset git branch
	git status
	git fetch origin
	git reset --hard origin/`git rev-parse --abbrev-ref HEAD`
	@make --no-print-directory time

.PHONY: help
help:                # Show Makefile options
	@grep -E "^[A-Za-z0-9_-]+:" $(lastword $(MAKEFILE_LIST))
