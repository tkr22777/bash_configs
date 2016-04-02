#Title: UNC bash_profile
#!bin/bash
export CLICOLOR=1
export GREP_OPTIONS='--color=always'
export GREP_COLORS='fn=1;32'
export PATH="/usr/local/bin:$PATH"

alias ll='ls -la'
alias sha1sum="openssl sha1"

alias sccleanknownhosts="rm ~/.ssh/known_hosts"
alias scedit_bash_profile="vim ~/.bash_profile"
alias scsource_bash_profile="source ~/.bash_profile"

alias sctitkariGitClone="echo 'git clone git@github.com:stupefied/titkari.git' | pbcopy"
alias scinitGitClone="echo 'git clone git@github.com:stupefied/init.git' | pbcopy"
