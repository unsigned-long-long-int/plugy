# File: ~/.config/plugy/sync.mk

# Plugin Configuration Variables
# These variables can be overridden when running the plugin, e.g., 'plugy sync pull REMOTE=my_server'
FLAGS :=
REMOTE :=
USER :=

# .PHONY is crucial for targets that don't produce files.
# It tells make that these are command names.
.PHONY: help pull push ssh

help: # This is the default target if 'plugy sync' is run without further arguments.
	@echo -e "sync: sync between a remote host and local host\n\tUSAGE:\n\t\tpull: pull from remote\n\t\tpush: push to remote\n\t\tssh: ssh to the remote"

pull:
	rsync -avz --delete $(REMOTE):/home/$(USER) /mnt $(FLAGS)
push:
	rsync -avz --delete /mnt/$(USER) $(REMOTE):/home $(FLAGS)

ssh:
	@echo "Connecting to $(REMOTE)..."
	ssh $(REMOTE)
