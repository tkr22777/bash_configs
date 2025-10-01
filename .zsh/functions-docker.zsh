# Docker Functions

# Kills Docker container by name
# Example: kill_container mysql
# This will find and force remove any container with 'mysql' in its name
function kill_container {
	runningContainers=`docker ps -a | grep $1 | wc -l `
	if [ $runningContainers -gt 0 ]; then
		docker rm -f `docker ps -a | grep  $1 | cut -d ' ' -f 1`
	fi
}

