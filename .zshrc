# ZSH Configuration - Modular Setup
# Main config file that sources all modular components from ~/.zsh/

# Oh-My-Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="avit"
plugins=(
  git
  brew
  docker
  docker-compose
  zsh-autosuggestions     # Suggests commands as you type
  zsh-syntax-highlighting # Syntax highlighting in shell
  z                      # Jump to frequently used directories
)

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# History Options
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY

# Source all modular configuration files
# The ~/.zsh directory contains organized config files by category

# Load exports first (needed by other modules)
[ -f ~/.zsh/exports.zsh ] && source ~/.zsh/exports.zsh

# Load functions
[ -f ~/.zsh/functions-docker.zsh ] && source ~/.zsh/functions-docker.zsh
[ -f ~/.zsh/functions-ssh.zsh ] && source ~/.zsh/functions-ssh.zsh
[ -f ~/.zsh/functions-openai.zsh ] && source ~/.zsh/functions-openai.zsh
[ -f ~/.zsh/functions-utils.zsh ] && source ~/.zsh/functions-utils.zsh

# Load aliases
[ -f ~/.zsh/aliases-general.zsh ] && source ~/.zsh/aliases-general.zsh
[ -f ~/.zsh/aliases-git.zsh ] && source ~/.zsh/aliases-git.zsh
[ -f ~/.zsh/aliases-tmux.zsh ] && source ~/.zsh/aliases-tmux.zsh
[ -f ~/.zsh/aliases-docker.zsh ] && source ~/.zsh/aliases-docker.zsh
[ -f ~/.zsh/aliases-kaomoji.zsh ] && source ~/.zsh/aliases-kaomoji.zsh

# Initialize SSH agent (if functions are loaded)
if type clean_re_source_ssh_agent &>/dev/null; then
  clean_re_source_ssh_agent
fi
