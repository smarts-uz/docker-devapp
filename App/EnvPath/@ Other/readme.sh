#!/bin/bash

##########  GIT  #########

pwsh -File "/var/app/ALL/ALL/Git/git-pull.ps1" -All
pwsh -File "/var/app/ALL/ALL/Git/git-stash.ps1" -All

export PATH="/var/app/ALL/ALL/AZK/:$PATH"
echo $PATH




##########  Exec_Testing  #########

pwsh -File "/var/app/ALL/ALL/Exec_Netstat/ALL.ps1" -All
pwsh -File "/var/app/ALL/ALL/Exec_Ifconfig/ALL.ps1" -All



##########  Exec-Compose  #########

pwsh -File "/var/app/ALL/ALL/Exec_Sshd/ALL.ps1" -All
pwsh -File "/var/app/ALL/ALL/Exec-Compose/eimzo client.ps1" -All
pwsh -File "/var/app/ALL/ALL/Exec-Compose/eimzo server.ps1" -All



##########  ALL UP  #########

pwsh -File "/var/app/ALL/ALL/ALL-Up/ALL.ps1" -All
pwsh -File "/var/app/ALL/ALL/ALL-Up/postgres.ps1" -All




##########  ALL  #########

pwsh -File "/var/app/ALL/ALL/ALL/ALL.ps1" -All



##########  ALL NC  #########

pwsh -File "/var/app/ALL/ALL/ALL-Nc/ALL.ps1" -All
