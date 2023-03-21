param([string]$action = "start")
Function main()
{
    $psExec = "PsExec.exe"
    $currentDir = $PSScriptRoot
    $commandPath = Join-Path $currentDir $psExec
    $restartPfsName = "restart_UP_with_fresh_logs.cmd"
    $pfsStopName = "stopPfs.cmd"
    $pfsStartName = "startPfs.cmd"
    $computerList = Join-Path $currentDir "VMs.txt"
    $restartPfsPath = Join-Path $currentDir $restartPfsName
    $stopPfsPath = Join-Path $currentDir $pfsStopName
    $startPfsPath = Join-Path $currentDir $pfsStartName

    $toolToExecute

    if($action -eq "restart")
    {
        $toolToExecute = $restartPfsPath
    }
    
    if($action -eq "start")
    {
        $toolToExecute = $startPfsPath
    }
    if($action -eq "stop")
    {
        $toolToExecute = $stopPfsPath
    }

    $commandArgumentsPfs = [string]::Format("@{0} -h -u laetus -p 1gfD4zUJqwes -c {1}", $computerList, $toolToExecute)
    Execute-Command "Restart Pfs" $commandPath $commandArgumentsPfs

}

Function Map-Drive($ip)
{
    $arguments = [string]::Format("use $ip 1gfD4zUJqwes /user:laetus")
    Execute-Command "" "net" $arguments
}

Function Copy-Files($ip)
{
    $currentDir = $PSScriptRoot
    $toolPath = Join-Path $currentDir $toolName
    $arguments = [string]::Format("{0} {1}\c$\Laetus\UP\ /Y", $toolPath, $ip)
    Execute-Command "" "xcopy" $arguments
}



Function Execute-Command ($commandTitle, $commandPath, $commandArguments)
{
Try {
    $currentDir = $PSScriptRoot
    Write-Host "Running", $commandPath,$commandArguments
    $p = Start-Process -FilePath $commandPath -ArgumentList $commandArguments -WorkingDirectory $currentDir -NoNewWindow
    Write-Host "Finished",$commandPath,$commandArguments
  }
  Catch {
    Write-Output "Ran into an issue: $($PSItem.ToString())"
     exit
  }

}

main