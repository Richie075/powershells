
FUNCTION MAIN()
{
$srvname="."
$dbname="Plant"
$mySrvConn = new-object Microsoft.SqlServer.Management.Common.ServerConnection
$mySrvConn.ServerInstance=$srvname
$mySrvConn.LoginSecure = $false
$mySrvConn.Login = "sa"
$mySrvConn.Password = "picture"

[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
$s = New-Object Microsoft.SqlServer.Management.Smo.Server($mySrvConn)
$dbs=$s.Databases
$dbs | Select-Object ## -Property ##--Get-Member -MemberType Property | 
} 

MAIN
