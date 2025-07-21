
Set Version=Uztele

Set ProgramPath=d:\Develop\Projects\server\imzo\client

Set ServiceType=Imzo
Set ServiceName=Client

Set AppPath=%ProgramPath%\%Version%
Set AppExe=java
Set AppCmd=-jar %AppPath%\vpn-client.jar %AppPath%\client-eimzo.conf 
Set AppExit=Restart

Set ObjectName=LocalSystem
Set ObjectPass=""