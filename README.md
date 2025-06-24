# plugy

A lightweight, personal plugin manager for custom automations and quality-of-life addons!

## What _is_ plugy exactly?

Plugy is a `make`-based system designed to help you organize and streamline your personal command-line workflows and system automations.

Imagine accumulating a collection of useful scripts or repetitive tasks that you perform regularly (like syncing files, managing system services, cleaning up downloads, performing quick backups, or anything tedious and cumbersome). Instead of having scattered shell scripts or a single, ever-growing, unwieldy `Makefile` in your home directory, `plugy` lets you organize these automations into modular, reusable "plugins."

It essentially acts as a central dispatcher that discovers and makes available specific `Makefile` snippets (your plugins) as easily callable commands directly from your terminal. This brings **structure**, **discoverability**, and **reusability** to your custom automations, making your personal command-line experience more efficient and organized.

---

## How Does plugy Work?

`plugy` operates by discovering plugin files, which are standard GNU Makefiles ending with the `.mk` extension. It looks for these plugins in one centralized, user-specific directory: `~/.config/plugy`.

When you invoke `plugy` from your command line, you specify the name of the plugin you wish to use. `plugy` then dynamically loads that plugin's Makefile, making all its defined targets directly executable as sub-commands of `plugy`.

---

## Installation

To install `plugy`, simply download the `plugy` executable script and place it in a directory that is included in your system's `PATH`.

1.  **Download the `plugy` script:**
    ```bash
    # Example: If plugy script is available in a repo, fetch it
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/unsigned-long-long-int/plugy/refs/heads/main/install.sh)"
    ```

---

## Let's Look at a plugy Plugin Example: `sync.mk`

Here's an example `plugy` plugin file called `sync.mk`, designed for synchronizing files with a remote host. You'd save this file as `~/.config/plugy/sync.mk`:

```make
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
```
---

## Dissecting `sync.mk`:

Let's break down the components of this example `plugy` plugin:

* **`# File: ~/.config/plugy/sync.mk` (Comment):** A good practice to indicate the plugin's name and its expected location.
* **`FLAGS`, `REMOTE`, and `USER` (Variables):**
    * These are standard **GNU Make variables**. They serve as **configurable parameters** specific to this `sync` plugin.
    * Users can easily override these directly from the command line when invoking the plugin (e.g., `plugy sync pull USER=myuser REMOTE=myhost.com`).
    * Providing default empty values ensures the plugin can run without errors if these aren't supplied.
* **`.PHONY: help pull push ssh` (Phony Targets):**
    * This directive is **crucial for `make`**. It tells `make` that `help`, `pull`, `push`, and `ssh` are *not* actual files to be built. This prevents conflicts with files of the same name and ensures these targets always execute their commands regardless of whether a file with that name exists.
* **`help` (Default Target):**
    * This target is executed if the plugin is invoked without specifying a particular sub-command (e.g., `plugy sync`).
    * It's used here to provide a concise **help message** for the plugin, detailing its available commands and usage. The `@echo -e` ensures the message is printed without `make`'s command echoing, and `\n\t` creates new lines and tabs for clear formatting.
* **`pull` (Target/Command):**
    * A defined `make` target that executes the `rsync` command. It's configured to **pull files** from the specified `REMOTE` host's `/home/$(USER)` directory to your local `/mnt` directory.
    * Includes a helpful `@echo` message for user feedback during execution.
* **`push` (Target/Command):**
    * The inverse of `pull`, this target executes `rsync` to **push files** from your local `/mnt/$(USER)` directory to the `REMOTE` host's `/home` directory.
    * Also includes an informative `@echo` message.
* **`ssh` (Target/Command):**
    * A simple target to directly establish an **SSH connection** to the defined `REMOTE` host, offering quick command-line access.
    * Includes an informative `@echo` message.

---

## How to Use `plugy`

Once you have the `plugy` executable script installed and placed in your system's `PATH`, and your plugin files in `~/.config/plugy/`, you can use it like this:

* **To get a list of all available plugins:**
    ```bash
    plugy --list
    ```
    or
    ```bash
    plugy -l
    ```

* **To get help for a specific plugin (e.g., `sync`):**
    ```bash
    plugy sync
    ```
    (This will run the `help` target within `sync.mk`)

* **To run a specific command within a plugin (e.g., `pull` from `sync`):**
    ```bash
    plugy sync pull
    ```

* **To override plugin variables from the command line:**
    ```bash
    plugy sync pull REMOTE=your_server.com USER=your_username
    ```

* **To push files to the remote with extra rsync flags:**
    ```bash
    plugy sync push REMOTE=your_server.com USER=your_username FLAGS="-P --dry-run"
    ```

* **To SSH to the remote:**
    ```bash
    plugy sync ssh REMOTE=your_server.com
    ```

---

## Contributing

To contribute, do the following:
 1. Fork the project!
 2. Add a new plugy plug-in, using sync.mk as a template
 3. Test on your machine
 4. Open a pull request
