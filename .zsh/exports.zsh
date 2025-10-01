# Environment Exports

# Load sensitive environment variables from .env file (not in version control)
if [ -f ~/.zsh/.env ]; then
  source ~/.zsh/.env
fi

# General Exports
export LSCOLORS=Exfxcxdxbxegedabagacad
export CLICOLOR=1
export GREP_OPTIONS='--color=always'
export GREP_COLORS='fn=1;32'
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export PATH="/usr/local/bin:$PATH"

# History Configuration
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTFILESIZE=10000
export HISTSIZE=200000
export SAVEHIST=200000

# UTF-8 Support
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Color support for less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

