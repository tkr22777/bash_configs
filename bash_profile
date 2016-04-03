#!bin/bash
export CLICOLOR=1
export GREP_OPTIONS='--color=always'
export GREP_COLORS='fn=1;32'
export PATH="/usr/local/bin:$PATH"

git config --global user.name "Tahsin Kabir"
git config --global user.email tahsinkabir@gmail.com

alias ll='ls -la'
alias sha1sum="openssl sha1"
alias ldroplet="ssh root@104.236.146.164"

alias sccleanknownhosts="rm ~/.ssh/known_hosts"
alias scedit_bash_profile="vim ~/.bash_profile"
alias scsource_bash_profile="source ~/.bash_profile"

alias sctitkariGitClone="echo 'git clone git@github.com:stupefied/titkari.git' | pbcopy"
alias scinitGitClone="echo 'git clone git@github.com:stupefied/init.git' | pbcopy"
alias scbdictGitClone="echo 'git clone git@github.com:stupefied/bdict.git' | pbcopy"
alias scCopyDropletIP="echo '104.236.146.164' | pbcopy"

#Tmux Aliases
alias tls='tmux ls '
alias tap='tmux attach -t '
alias tkill='tmux kill-session -t '
alias tns='tmux new -s '
