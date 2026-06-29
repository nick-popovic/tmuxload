# tmuxload

**Author:** Nick Popovic

Interactive loader for tmuxp session configs.

This script looks in `~/.config/tmuxp` for tmuxp configuration files, shows them in an interactive picker, and loads the selected session.

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

_Note: If `fzf` is installed, `tmuxload` uses it for fuzzy searching. If `fzf` is not installed, `tmuxload` falls back to Bash's built-in numbered select menu._

## Usage

```bash
tmuxload
```

### Optional environment variables

You can override the default config directory (`~/.config/tmuxp`) using `TMUXP_CONFIG_DIR`:

```bash
TMUXP_CONFIG_DIR=/some/other/path tmuxload
```
