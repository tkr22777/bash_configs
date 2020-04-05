#!bin/bash
#ORDER: A: FUNCTIONS, B: EXPORTS, C: ALIASES

#FUNCTIONS:
function kill_container {
#Takes container name as a parameter and if found, kills the container
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
		ssh-add > /dev/null ident=$?  if [ $ident -ne 0 ]
		then
			re-source_ssh_agent
		fi
	fi
}

## Java Compile Run Clean for PS
javaCompileRunClean() {
    javac "$1.java" 
    java "$1"
    rm *.class
}

#A. EXPORTS

#GENERAL EXPORTS:
export LSCOLORS=Exfxcxdxbxegedabagacad
export CLICOLOR=1
export GREP_OPTIONS='--color=always'
export GREP_COLORS='fn=1;32'
export PATH="/usr/local/bin:$PATH"

#EXPORT FOR HISTORY:
export HISTFILE=/Users/tahsink/.bash_history
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTFILESIZE=10000
export HISTSIZE=1000

#EXPORT FOR UTF:
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_PAPER=en_US.UTF-8
export LC_NAME=en_US.UTF-8
export LC_ADDRESS=en_US.UTF-8
export LC_TELEPHONE=en_US.UTF-8
export LC_MEASUREM=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8

#B. ALIASES
#GENERAL ALIASES
alias ls='ls -GFh'
alias rmf='rm -rf'
alias ll="ls -la"
alias sha1sum="openssl sha1"
alias scclear_known_hosts="cat /dev/null > ~/.ssh/known_hosts"
alias scedit_bash_profile="vim ~/.bash_profile"
alias scedit_known_hosts="vim ~/.ssh/known_hosts"
alias scsource_bash_profile="source ~/.bash_profile"
alias scDockerRmAllContainers="docker rm -f \$(docker ps -a -q)"

#TMUX ALIASES:
alias tls='tmux ls '
alias tap='tmux attach -t '
alias tns='tmux new -s '
alias tkill='tmux kill-session -t '

#GIT ALIASES:
alias gitamend="git commit --amend"
alias gitcheckoutmaster="git checkout master"
alias gitdifflast="git diff \`git log | head -n 1 | awk -F ' ' '{print \$2}'\`"
alias gitdifflastcommitted="git diff \`git log | grep '^commit ' | head -n 2 | awk -F ' ' '{print \$2}' | tail -r | sed 'N;s/\n/ /'\`"
alias gitdifflaststat="git diff \`git log | head -n 1 | awk -F ' ' '{print \$2}'\` --stat"
alias gitmergesquashnocommit="git merge --squash --no-commit"
alias gitpushcurrent="git push origin \`git rev-parse --abbrev-ref HEAD\`"
alias gitshowignored="git check-ignore *"

#cdaliases
alias cdicloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"

#Kaomojis
alias scKaomojiShrug="echo -n '¯\_(ツ)_/¯' | pbcopy"
alias scKaomojiConfused="echo -n 'o_O' | pbcopy"
alias scKaomojiZombie="echo -n '[¬º-°]¬' | pbcopy"
alias scKaomojiCoffe="echo -n 'c[_]' | pbcopy"
alias scKaomojiYass="echo -n '\(ˆ˚ˆ)/' | pbcopy"

