# Git Aliases

alias gitamend="git commit --amend"
alias gitcheckoutmaster="git checkout master"
alias gitmergesquashnocommit="git merge --squash --no-commit"
alias gitpushcurrent="git push origin \`git rev-parse --abbrev-ref HEAD\`"
alias gitdifflast="git diff \`git log | head -n 1 | awk -F ' ' '{print \$2}'\`"
alias gitdifflastcommitted="git diff \`git log | grep '^commit ' | head -n 2 | awk -F ' ' '{print \$2}' | tail -r | sed 'N;s/\n/ /'\`"
alias gitdifflaststat="git diff \`git log | head -n 1 | awk -F ' ' '{print \$2}'\` --stat"
alias gitshowignored="git check-ignore *"

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

