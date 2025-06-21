# `.portable`

A personal project for a lightweight, offline-friendly configuration system for terminal-based environments — designed for portability across SSH sessions, VMs, containers, recovery shells, or restricted environments.

---

## Purpose

`.portable` provides minimal, self-contained configuration files for command-line tools, allowing you to:

* Stay productive in stripped-down or temporary environments
* Use familiar keybindings, layouts, and behaviors
* Avoid reliance on plugin managers or external downloads
* Safely install configs without overwriting originals

---

## Structure

Each tool has its own directory under `.portable/`:

```
.portable/
├── install.sh        # Install script
├── vim/              # Example tool (Neovim/Vim/Vi)
│   ├── core.vim
│   └── plugins.vim
├── tmux/             # (Optional)
├── bash/             # (Optional)
└── git/              # (Optional)
```

---

## Installation

To install a specific tool’s config, run:

```bash
./install.sh <tool>
```

For example:

```bash
./install.sh vim
```

To install **all available configs**:

```bash
./install.sh all
```

> ⚠️ Existing configs are automatically backed up to `~/.bakconf/`.

---

## Behavior

* Creates any needed directories
* Backs up existing configs as `.bak` inside `~/.bakconf/`
* Uses `ln -s` to symlink portable configs into their target locations

