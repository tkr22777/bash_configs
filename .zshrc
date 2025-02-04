# ZSH SPECIFIC:
ZSH_THEME="avit"
plugins=(
  git
  brew
  docker
  docker-compose
)
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY

#A. FUNCTIONS:

#Takes container name as a parameter and if found, kills the container
function kill_container {
	runningContainers=`docker ps -a | grep $1 | wc -l `
	if [ $runningContainers -gt 0 ]; then
		docker rm -f `docker ps -a | grep  $1 | cut -d ' ' -f 1`
	fi
}

function re-source_ssh_agent(){
    rm -f "$HOME"/.ssh/`hostname`.agent
    ssh-agent -t 28800 > "$HOME"/.ssh/`hostname`.agent > /dev/null
    source "$HOME"/.ssh/`hostname`.agent > /dev/null
    ssh-add > /dev/null
}

## SSH agent script
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

#EXPORT FOR UTF:
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8