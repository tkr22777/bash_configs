# Shell Configuration

Modular ZSH configuration managed in Dropbox and synced to home directory.

## Quick Start

### First-Time Setup
```bash
# 1. Clone or navigate to this repo
cd ~/Dropbox/Work/init

# 2. Sync configuration to home directory
./sync_zsh_config.sh

# 3. Configure your API keys (optional, for OpenAI features)
vim ~/.zsh/.env
# Uncomment and add: export OPENAI_API_KEY="your-key"

# 4. Reload shell
source ~/.zshrc
```

### Updating Configuration
```bash
# After editing any .zsh files in this repo:
./sync_zsh_config.sh && source ~/.zshrc

# Or update from GitHub remote (with safety checks):
update_zshrc_from_github
```

## Structure

```
.zshrc                  # Main config, sources all modules
.zsh/                   # Modular components
  ├── .env              # Private env vars (gitignored)
  ├── .env.template     # Template for required vars
  ├── functions-docker.zsh
  ├── functions-ssh.zsh
  ├── functions-openai.zsh
  ├── functions-utils.zsh
  ├── aliases-general.zsh
  ├── aliases-git.zsh
  ├── aliases-tmux.zsh
  ├── aliases-docker.zsh
  ├── aliases-kaomoji.zsh
  └── exports.zsh
```

## Usage Examples

### OpenAI Assistant
```bash
# Get bash command suggestions
oai "find all files larger than 100MB"

# Test API configuration
oai_help
```

### Docker Shortcuts
```bash
# Kill containers by name
kill_container mysql

# Quick docker commands
dps              # docker ps
dpsa             # docker ps -a
dcup             # docker-compose up
dcdown           # docker-compose down
```

### Git Shortcuts
```bash
gst              # git status
gad              # git add -A
gci -m "msg"     # git commit
gpu              # git push
gpl              # git pull
glg              # git log --graph --oneline --decorate
```

### Tmux Shortcuts
```bash
tls              # tmux ls
tns myproject    # tmux new -s myproject
tap myproject    # tmux attach -t myproject
tkill myproject  # tmux kill-session -t myproject
```

### Utility Functions
```bash
# Create directory and cd into it
mkcd new-project

# Extract any archive type
extract archive.tar.gz

# Quick navigation
..               # cd ..
...              # cd ../..
....             # cd ../../..
```

## Environment Variables

Sensitive variables (API keys, tokens) are stored in `~/.zsh/.env`:
- **Gitignored** - won't be committed to version control
- Use `.zsh/.env.template` as reference
- Required for OpenAI functions: `OPENAI_API_KEY`

## Customization

### Adding New Functions
1. Edit appropriate file in `.zsh/` (e.g., `functions-utils.zsh`)
2. Run `./sync_zsh_config.sh`
3. Run `source ~/.zshrc`

### Adding New Aliases
1. Edit appropriate file in `.zsh/` (e.g., `aliases-general.zsh`)
2. Run `./sync_zsh_config.sh`
3. Run `source ~/.zshrc`

## Reference

### Key Functions
- `oai "query"` - Get bash command suggestions from OpenAI
- `oai_help` - Test OpenAI API configuration
- `update_zshrc_from_github` - Update from remote repo (with safety checks)
- `kill_container name` - Kill Docker container by name
- `mkcd dir` - Create and cd into directory
- `extract file` - Extract any archive type
- `clean_re_source_ssh_agent` - Reinitialize SSH agent

### All Aliases
**Git:** `gst`, `gco`, `gci`, `grb`, `gbr`, `gad`, `gpl`, `gpu`, `glg`, `gitamend`, `gitpushcurrent`  
**Docker:** `dps`, `dpsa`, `dimg`, `dcup`, `dcdown`  
**Tmux:** `tls`, `tap`, `tkill`, `tns`  
**Navigation:** `..`, `...`, `....`, `.....`  
**System:** `ll`, `df`, `du`, `path`

## Troubleshooting

**Shell not loading config?**
```bash
source ~/.zshrc
```

**Functions not working?**
```bash
# Check if files exist
ls -la ~/.zsh/

# Re-sync
cd ~/Dropbox/Work/init && ./sync_zsh_config.sh
```

**OpenAI functions not working?**
```bash
# Check API key is set
oai_help

# Configure in .env file
vim ~/.zsh/.env
```

