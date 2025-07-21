#!/bin/bash

##########  Exec-Compose  #########

pwsh -File "/var/app/ALL/ALL/Exec_Sshd/ALL.ps1" -All
pwsh -File "/var/app/ALL/ALL/Exec-Compose/eimzo client.ps1" -All
pwsh -File "/var/app/ALL/ALL/Exec-Compose/eimzo server.ps1" -All
pwsh -File "/var/app/ALL/ALL/Restart-Compose/eimzo.ps1" -All
pwsh -File "/var/app/ALL/ALL/Restart-Compose/portainer.ps1" -All


