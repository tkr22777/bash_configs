# ZSH SPECIFIC:
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
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY

#A. FUNCTIONS:

# Kills Docker container by name
# Example: kill_container mysql
# This will find and force remove any container with 'mysql' in its name
function kill_container {
	runningContainers=`docker ps -a | grep $1 | wc -l `
	if [ $runningContainers -gt 0 ]; then
		docker rm -f `docker ps -a | grep  $1 | cut -d ' ' -f 1`
	fi
}

# Resets SSH agent configuration and adds default keys
# Example: re-source_ssh_agent
# Useful when SSH agent needs to be restarted or is not working properly
function re-source_ssh_agent(){
    rm -f "$HOME"/.ssh/`hostname`.agent
    ssh-agent -t 28800 > "$HOME"/.ssh/`hostname`.agent > /dev/null
    source "$HOME"/.ssh/`hostname`.agent > /dev/null
    ssh-add > /dev/null
}

# Automatically manages SSH agent, checking if it's running and reinitializing if needed
# Example: clean_re_source_ssh_agent
# Usually added to .zshrc to ensure SSH agent is always properly configured on shell start
function clean_re_source_ssh_agent() {
	if [ -e "$HOME"/.ssh/`hostname`.agent ]
	then
		source "$HOME"/.ssh/`hostname`.agent > /dev/null
	fi
	ssh-add -l 2>&1 > /dev/null
	ident=$?
	if [ $ident -ne 0 ]
	then
		ssh-add > /dev/null
		ident=$?
		if [ $ident -ne 0 ]
		then
			re-source_ssh_agent
		fi
	fi
}

# Uses OpenAI API to get bash command suggestions
# Example: oai "how to find large files in current directory"
# Will return a relevant bash command for the query
function oai() {
  local user_prompt="$*"
  local system_prompt="You are an expert at assisting with bash command. Answer very concisely with an output that is suitable for a bash command."

  # Build the JSON body
  local json_payload=$(
    cat <<EOF
{
  "model": "gpt-4o-mini",
  "messages": [
    {
      "role": "system",
      "content": "$system_prompt"
    },
    {
      "role": "user",
      "content": "$user_prompt"
    }
  ],
  "max_tokens": 100,
  "temperature": 0.7
}
EOF
  )

  # Send request to OpenAI, pipe to jq, extract only the assistant's "content".
  curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -d "$json_payload" \
  | jq -r '.choices[0].message.content'
}

# Creates a new directory and changes into it in one command
# Example: mkcd new-project
# This will create 'new-project' directory and cd into it
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Universal archive extraction function
# Example: extract archive.zip
# Automatically detects archive type and extracts it appropriately
function extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#B. ALIASES

# General Aliases:
alias ls='ls -GFh'
alias rmf='rm -rf'
alias ll="ls -la"
alias sha1sum="openssl sha1"
alias scclear_known_hosts="cat /dev/null > ~/.ssh/known_hosts"
alias scedit_known_hosts="vim ~/.ssh/known_hosts"
alias sccleanknownhosts="rm ~/.ssh/known_hosts"
alias scedit_zshrc="vim ~/.zshrc"
alias scsource_zshrc="source ~/.zshrc"
alias scDockerRmAllContainers="docker rm -f \$(docker ps -a -q)"
alias scDockerRemoveDanglingImages="docker rmi \$(docker images -f dangling=true -q)"
alias scDockerRemoveDanglingVolumes="docker volume rm \$(docker volume ls -f dangling=true -q)"

#Tmux Aliases
alias tls='tmux ls '
alias tap='tmux attach -t '
alias tkill='tmux kill-session -t '
alias tns='tmux new -s '

#GIT Aliases:
alias gitamend="git commit --amend"
alias gitcheckoutmaster="git checkout master"
alias gitmergesquashnocommit="git merge --squash --no-commit"
alias gitpushcurrent="git push origin \`git rev-parse --abbrev-ref HEAD\`"
alias gitdifflast="git diff \`git log | head -n 1 | awk -F ' ' '{print \$2}'\`"
alias gitdifflastcommitted="git diff \`git log | grep '^commit ' | head -n 2 | awk -F ' ' '{print \$2}' | tail -r | sed 'N;s/\n/ /'\`"
alias gitdifflaststat="git diff \`git log | head -n 1 | awk -F ' ' '{print \$2}'\` --stat"
alias gitshowignored="git check-ignore *"

#Kaomojis
alias scKaomojiShrug="echo -n '¯\_(ツ)_/¯' | pbcopy"
alias scKaomojiConfused="echo -n 'o_O' | pbcopy"
alias scKaomojiZombie="echo -n '[¬º-°]¬' | pbcopy"
alias scKaomojiCoffe="echo -n 'c[_]' | pbcopy"
alias scKaomojiYass="echo -n '\(ˆ˚ˆ)/' | pbcopy"
alias scKaomojiSmile="echo -n '(ᵔ◡ᵔ)' | pbcopy"
alias scKaomojiMusic="echo -n 'ヾ(⌐■_■)ノ♪' | pbcopy"
alias scKaomojiThinFlex="echo -n 'ᕙ༼◕_◕༽ᕤ' | pbcopy"
alias scKaomojiDistraught="echo -n '༼ ༎ຶ ෴ ༎ຶ༽' | pbcopy"
alias scKaomojiFeisty="echo -n '(ง •̀_•́)ง' | pbcopy"
alias scKaomojiPoggers="echo -n 'ᕕ( ᐛ )ᕗ' | pbcopy"

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# System commands
alias df='df -h'
alias du='du -h'
alias free='free -m'
alias path='echo -e ${PATH//:/\\n}'

# Git additional aliases
alias gst='git status'
alias gco='git checkout'
alias gci='git commit'
alias grb='git rebase'
alias gbr='git branch'
alias gad='git add -A'
alias gpl='git pull'
alias gpu='git push'
alias glg='git log --graph --oneline --decorate'

# Docker additional aliases
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'

#C. EXPORTS

#GENERAL EXPORTS:
export LSCOLORS=Exfxcxdxbxegedabagacad
export CLICOLOR=1
export GREP_OPTIONS='--color=always'
export GREP_COLORS='fn=1;32'
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export PATH="/usr/local/bin:$PATH"

#EXPORT FOR HISTORY:
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTFILESIZE=10000
export HISTSIZE=200000
export SAVEHIST=200000

#EXPORT FOR UTF:
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
