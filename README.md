# tmuxload (`tml`)

**Author:** Nick Popovic

Interactive loader for tmuxp session configs.

This script looks in `~/.config/tmuxp` for tmuxp configuration files, shows them in an interactive picker, and loads the selected session.

## Installation

You can install the latest release of `tmuxload` quickly via your terminal:

```bash
curl -sL https://raw.githubusercontent.com/nick-popovic/tmuxload/main/install.sh | bash
```

By default, this will download the script, verify its checksum, and install it to `~/.local/bin`.

If you prefer to install it to a different directory (e.g. `/usr/local/bin`), you can pass the path as an argument:

```bash
curl -sL https://raw.githubusercontent.com/nick-popovic/tmuxload/main/install.sh | bash -s -- /usr/local/bin
```

## Supported config formats

- `.yaml`
- `.yml`
- `.json`

## Dependencies

**Required:**

- `tmux`
- `tmuxp`

**Optional:**

- `fzf`

_Note: If `fzf` is installed, `tml` uses it for fuzzy searching. If `fzf` is not installed, `tml` falls back to Bash's built-in numbered select menu._

## Usage

```bash
tml
```

### Optional environment variables

You can override the default config directory (`~/.config/tmuxp`) using `TMUXP_CONFIG_DIR`:

```bash
TMUXP_CONFIG_DIR=/some/other/path tml
```
