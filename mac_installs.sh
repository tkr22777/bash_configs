#!/bin/bash

# install aws cli: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

# install brew: https://docs.brew.sh/Installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install cask           #cask is a non command prompt installer
brew install ctop           #the container top
brew install fzf            #command line fuzzy finder
brew install iftop          #network top
brew install iperf3         #netperf
brew install kafkacat       #the kafka cat
brew install maven          #for maven based java project dependency manager
brew install openssl        #open ssl
brew install ranger         #termincal gui based file browser
brew install tmux           #the terminal multiplexer
brew install tree           #tree view of files
brew install watch          #watch the whole world burn
brew install wget           #the terminal based downloader
brew install htop           #the process top
brew install ncdu           #the disk usage analyzer
brew cask install docker    #docker, the container manager
brew install jq             #jq, the json processor
brew install git            #git, the version control system
brew install terraform      #infrastructure as code tool
brew install kubectl        #the kubernetes cli
brew install poetry         #the python package manager
brew install asciinema      #bash command flow recorder

# brew cask install java      #the jdk
# brew install asdf           #project specific version manager
# brew install sbt            #sbt, the interactive build tool for scala and java 
# brew install scala          #scala, the func lang in JMV (for shobdo)
