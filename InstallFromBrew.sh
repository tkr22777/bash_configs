#!/bin/bash

#Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install asciinema      #bash command flow recorder
brew install asdf           #project specific version manager
brew install awscli         #the aws cli
brew install cask           #cask is a non command prompt installer
brew install ctags          #ze ctags for source code exploration
brew install ctop           #the container top
brew install fzf            #command line fuzzy finder
brew install iftop          #network top
brew install iperf3         #netperf
brew install kafkacat       #the kafka cat
brew install maven          #for maven based java project dependency manager
brew install openssl        #open ssl
brew install ranger         #termincal gui based file browser
brew install sbt            #sbt, the interactive build tool for scala and java 
brew install scala          #scala, the func lang in JMV (for shobdo)
brew install tmux           #the terminal multiplexer
brew install tree           #tree view of files
brew install watch          #watch the whole world burn
brew install wget           #the terminal based downloader

brew install docker --cask    #docker, the container manager
brew install java --cask      #the jdk
