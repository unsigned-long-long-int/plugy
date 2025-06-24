# plugy

A lightweight, personal plugin manager for custom automations and quality-of-life addons!

## What _is_ plugy exactly?

Plugy is a `make`-based system designed to help you organize and streamline your personal command-line workflows and system automations.

Imagine accumulating a collection of useful scripts or repetitive tasks that you perform regularly (like syncing files, managing system services, cleaning up downloads, performing quick backups, or anything tedious and cumbersome). Instead of having scattered shell scripts or a single, ever-growing, unwieldy `Makefile` in your home directory, `plugy` lets you organize these automations into modular, reusable "plugins."

It essentially acts as a central dispatcher that discovers and makes available specific `Makefile` snippets (your plugins) as easily callable commands directly from your terminal. This brings **structure**, **discoverability**, and **reusability** to your custom automations, making your personal command-line experience more efficient and organized.

---

## How Does plugy Work?

`plugy` operates by discovering plugin files, which are standard GNU Makefiles ending with the `.mk` extension. It looks for these plugins in a single, centralized, user-specific directory: `~/.local/plugy`.

When you invoke `plugy` from your command line, you specify the name of the plugin you wish to use. `plugy` then dynamically loads that plugin's Makefile, making all its defined targets directly executable as sub-commands of `plugy`.

---

## Installation

To install `plugy`, simply download the `plugy` executable script and place it in a directory that is included in your system's `PATH`.

1.  **Download the `plugy` script:**
    ```bash
    # Example: If plugy script is available in a repo, fetch it
    curl -o ~/.local/bin/plugy [https://raw.githubusercontent.com/your-username/plugy/main/plugy](https://raw.githubusercontent.com/your-username/plugy/main/plugy) # Replace with actual URL
    chmod +x ~/.local/bin/plugy
    ```
    *(Ensure `~/.local/bin` is in your `$PATH`. If not, add `export PATH="$HOME/.local/bin:$PATH"` to your shell's config file, like `~/.bashrc` or `~/.zshrc`, and restart your terminal.)*

2.  **Create the default plugin directory:**
    ```bash
    mkdir -p ~/.local/plugy
    ```

---

## Let's Look at a plugy Plugin Example: `sync.mk`

Here's an example `plugy` plugin file called `sync.mk`, designed for synchronizing files with a remote host. You would save this file as `~/.local/plugy/sync.mk`:

```make
# File: ~/.local/plugy/sync.mk

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
	@echo "Pulling from <span class="math-inline">\(REMOTE\)\:/home/</span>(USER) to /mnt..."
	rsync -avz --delete <span class="math-inline">\(REMOTE\)\:/home/</span>(USER) /mnt <span class="math-inline">\(FLAGS\)
push\:
@echo "Pushing from /mnt/</span>(USER) to <span class="math-inline">\(REMOTE\)\:/home\.\.\."
rsync \-avz \-\-delete /mnt/</span>(USER) $(REMOTE):/home $(FLAGS)

ssh:
	@echo "Connecting to $(REMOTE)..."
	ssh $(REMOTE)
