param(
[String]$ReplaceDBServer,
[String]$ReplaceDBName,
[String]$ReplaceDBUser,
[String]$ReplaceDBPassword)

$file = "C:\OPENTEXT\config\autoconfig.xml"
$StrDBServer = "DBServer"
$StrDBName = "DBName"
$StrDBUser = "DBUser"
$StrDBPassword = "DBPassword"

$ReplaceDBServerFull = $ReplaceDBServer+".database.windows.net"

#$ReplaceDBServer = "otcs.database.windows.net"
#$ReplaceDBName = "otcsps"
#$ReplaceDBUser = "otcsps"
#$ReplaceDBPassword = "Livelink1!"

Write-Host $ReplaceDBServerFull
Write-Host $ReplaceDBName
Write-Host $ReplaceDBUser
Write-Host $ReplaceDBPassword

$text = get-content $file
$newText0 = $text -replace $StrDBServer,$ReplaceDBServerFull
$newText1 = $newText0 -replace $StrDBName,$ReplaceDBName
$newText2 = $newText1 -replace $StrDBUser,$ReplaceDBUser
$newText3 = $newText2 -replace $StrDBPassword,$ReplaceDBPassword
$newText3 > $file 

# Start Services
cmd.exe /c '\configOTCS.bat'
# change to the path to IE on your machine if necessary
$IE = "C:\Program Files\Internet Explorer\iexplore.exe"
# I created a sample XML file for you and put it on my server; you can try the URL below
# But you will have to change it if you want to open another file
$XML = "http://localhost/OTCS/cs.exe?func=admin.autoconfig"
# Lanch Internet Explorer and open an XML file in it
Start-Process $IE $XML
