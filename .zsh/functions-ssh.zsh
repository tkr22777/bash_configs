# SSH Agent Functions

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

