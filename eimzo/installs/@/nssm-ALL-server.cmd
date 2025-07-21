Set Version=Uztele

Set ProgramPath=d:\Develop\Projects\server\imzo\server

Set ServiceType=Imzo
Set ServiceName=Server

Set AppPath=%ProgramPath%\%Version%
Set AppExe=java
Set AppCmd=-Dfile.encoding=UTF-8 -jar "%AppPath%\dsv-server.jar" -p 9090 -l 0.0.0.0
REM Set AppCmd=-Dfile.encoding=UTF-8 -jar "%AppPath%\dsv-server.jar" -h
Set AppExit=Restart



Set ObjectName=LocalSystem
Set ObjectPass=""

Set CmdRun=%AppExe% %AppCmd%
Set CmdStop=%AppPath%\mysqladmin %AppCmd% -proot shutdown
Set CmdInit=%CmdRun% --initialize-insecure --console

nssm set %ServiceFullName% AppEnvironmentExtra TSA_URL=%TSA_URL% TRUSTSTORE_FILE=%TRUSTSTORE_FILE% TRUSTSTORE_PASSWORD=%TRUSTSTORE_PASSWORD%
