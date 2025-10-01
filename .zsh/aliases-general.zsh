# General Aliases

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

