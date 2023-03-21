param([string]$sqlScriptsPath = "D:\SqlSnippets\Maintenance\FromPLan1",<#$(throw "-sqlScriptsPath is required."),#>
[string]$serverInstance = ".",<#$(throw "-serverInstance is required."),[Parameter(Mandatory=$true)]#>
[string]$dataBaseName = "Plant", <#$(throw "-dataBaseName is required."),#>
[string]$userName = "sa", <#$(throw "-userName is required."),#>
[string]$password = "picture",<#$(throw "-password is required.")#>
[string]$backupPath = "D:\SqlSnippets\Maintenance\FromPLan"<#$(throw "-backupPath is required.")#>
)
Function main()
{
    $date = get-date 
    $fileName = [string]::Format("{0}_log.txt",$date.ToString("yyyyMMdd_HHmm"))
    $logFile = Join-Path $sqlScriptsPath $fileName
    <#start-transcript Path-Combine($sqlScriptsPath,)#>
    $sqlFiles = GetAllFiles($sqlScriptsPath)
    $count = $sqlFiles.Count
    $counter = 1
<#$password = $password | ConvertTo-SecureString -AsPlainText -Force#>
    foreach($sqlFile in $sqlFiles)
    {
        $info = [string]::Format("Executing file {0}", $sqlFile)
        Write-Progress -Activity $info -Status "Progress ->" -PercentComplete ((100/$count)*$counter++) -CurrentOperation SqlMaintenance;
        $exec = [string]::Format("Invoke-Sqlcmd -inputfile {0} -serverinstance {1} -database {2} -Username {3} -Password {4}", $sqlFile, $serverInstance, $dataBaseName, $userName, $password)
        Write-Host $exec
        "$(get-date -format "yyyy-MM-dd H:mm:ss"):`t" + $exec | out-file $logFile -Append
        $backupFileName = [string]::Format("{0}_{1}", $dataBaseName, (get-date -format "yyyy_MM_dd_HHmmss"))
        $fullPath = [string]::Format("{0}\{1}.bak", $backupPath, $backupFileName)
        $variables = 
                "dataBaseName = $dataBaseName",
                "reportOnly = 1",
                "fullPath = $fullPath",
                "backupFileName = $backupFileName"
        $stopwatch =  [system.diagnostics.stopwatch]::StartNew()
        if($sqlFile.name.StartsWith("02"))
        {
            $exec = [string]::Format("Invoke-Sqlcmd -inputfile {0} -Variable {1} -serverinstance {2} -database {3} -Username {4}", $sqlFile, $variables, $serverInstance, $dataBaseName, $userName)
            Write-Host $exec
            (Invoke-Sqlcmd -inputfile $sqlFile -Variable $variables -serverinstance $serverInstance -database $dataBaseName -Username $userName -Password $password -Verbose) *>> $logFile
        }else{
            $exec = [string]::Format("Invoke-Sqlcmd -inputfile {0} -Variable {1} -serverinstance {2} -database {3} -Username {4}", $sqlFile, $variables, $serverInstance, $dataBaseName, $userName)
            Write-Host $exec
            (Invoke-Sqlcmd -inputfile $sqlFile -Variable $variables -serverinstance $serverInstance -database $dataBaseName -Username $userName -Password $password -Verbose) *>> $logFile
        }
        $stopwatch.Stop()
        "$(get-date -format "yyyy-MM-dd H:mm:ss"):`t Sql Execution took: `n" + $stopwatch.ElapsedMilliseconds + " ms" | out-file $logFile -Append        
        <#"$(get-date -format "yyyy-MM-dd H:mm:ss"):`t" + $sqlResult | out-file $logFile -Append'#>
    }
}

function GetAllFiles()
{
    $searchPath = $sqlScriptsPath.Trim(" ")
    Write-Host $searchPath 
    $searchString = "*.sql"
    $info = [string]::Format("Executing: Get-ChildItem -Path {0} -Recurse -Include {1}", $searchPath, $searchString)    
    Write-Host $info
    return Get-ChildItem -Path $searchPath -Recurse -Include $searchString
}

main
