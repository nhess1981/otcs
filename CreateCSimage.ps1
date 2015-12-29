param(
[String]$ReplaceDBServer,
[String]$ReplaceDBName,
[String]$ReplaceDBUser,
[String]$ReplaceDBPassword,
[String]$ReplaceAPassword)

# Start Services
start-service OTCS

set-service -name OTCS -startuptype automatic 

Write-Host "Set Service Content Server (OTCS) to Automatic and Status Running"

start-service OTCSAdmin

set-service -name OTCSAdmin -startuptype automatic 

Write-Host "Set Service Content Server Admin (OTCS) to Automatic and Status Running"

Write-Host "Start: Replace Parameter in autoconfig.xml"

# Wait 60 sec
# start-sleep -s 60

$file = "C:\OPENTEXT\config\autoconfig.xml"
$StrDBServer = "DBServer"
$StrDBName = "DBName"
$StrDBUser = "DBUser"
$StrDBPassword = "DBPassword"
$StrAPassword = "APassword"

$ReplaceDBServerFull = $ReplaceDBServer+".database.windows.net"

Write-Host $ReplaceDBServerFull
Write-Host $ReplaceDBName
Write-Host $ReplaceDBUser
Write-Host $ReplaceDBPassword
Write-Host $ReplaceAPassword

(Get-Content $file) -replace $StrDBServer, $ReplaceDBServerFull | Set-Content $file
(Get-Content $file) -replace $StrDBName, ,$ReplaceDBName | Set-Content $file
(Get-Content $file) -replace $StrDBUser, $ReplaceDBUser | Set-Content $file
(Get-Content $file) -replace $StrDBPassword, $ReplaceDBPassword | Set-Content $file
(Get-Content $file) -replace $StrAPassword, $ReplaceAPassword | Set-Content $file

Write-Host "End: Replace Parameter in autoconfig.xml"

Write-Host "Start: auto creation Content Server"

$url = "http://localhost/OTCS/cs.exe?func=admin.autoconfig"
# Wait 60 sec
start-sleep -s 60
$result = Invoke-WebRequest $url -UseBasicParsing

Write-Host $result

$url2 = "http://localhost/OTCS/cs.exe?func=ll.index"
$result2 = Invoke-WebRequest $url2

Write-Host $result2

Write-Host "End: auto creation Content Server"
