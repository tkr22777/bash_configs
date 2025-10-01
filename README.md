# Shell Configuration

Modular ZSH config for Oh-My-Zsh with organized functions, aliases, and environment variables.

## Setup

```bash
cd ~/Dropbox/Work/init
./sync_zsh_config.sh
vim ~/.zsh/.env          # Add API keys
source ~/.zshrc
```

## Structure

```
.zshrc                   # Main config
.zsh/
  ├── .env              # Private env vars (gitignored)
  ├── functions-*.zsh   # Docker, SSH, OpenAI, utils
  ├── aliases-*.zsh     # Git, Docker, Tmux, general
  └── exports.zsh       # Environment variables
```

## Key Commands

**OpenAI:**
```bash
oai "find files >100MB"    # Get bash suggestions
oai_help                   # Test API config
```

**Functions:**
- `kill_container name` - Kill Docker container
- `mkcd dir` - Create and cd
- `extract file` - Extract any archive
- `update_zshrc_from_github` - Update from remote (safe)

**Aliases:**
- Git: `gst` `gad` `gci` `gpu` `gpl` `glg`
- Docker: `dps` `dpsa` `dimg` `dcup` `dcdown`
- Tmux: `tls` `tns myproject` `tap myproject` `tkill myproject`
- Nav: `..` `...` `....`

## Env Vars

Edit `.zsh/.env` for API keys (gitignored):
```bash
export OPENAI_API_KEY="your-key"
export AWS_ACCESS_KEY_ID="your-key"
export GITHUB_TOKEN="your-token"
```

## Update Workflow

```bash
# Edit files in ~/Dropbox/Work/init/.zsh/
./sync_zsh_config.sh && source ~/.zshrc
```

