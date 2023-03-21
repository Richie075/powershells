
Function main()
{
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$rootPath = "C:\SVN\repos\nt-core"

if(Test-Path $rootPath)
{
    $pomfileExe = Join-Path $rootPath "pom\branches\develop\agent\development\bin\Debug\Laetus.NT.Core.POManager.Development.exe"
    $controlPanelExe = Join-Path $rootPath "control-panel\branches\develop\agent\development\bin\Debug\Laetus.NT.Core.ControlPanel.Development.exe"
    $auditTrail = Join-Path $rootPath "audit-trail\branches\develop\agent\development\bin\Debug\Laetus.NT.Core.Platform.AuditTrail.Development.exe"
    $centralizedLogger = Join-Path $rootPath "centralized-logger\branches\develop\agent\development\bin\Debug\Laetus.NT.Core.CentralizedLogger.Development.exe"
    $configuration = Join-Path $rootPath "configuration\branches\develop\agent\development\bin\Debug\Laetus.NT.Core.Configuration.Development.exe"
    $hmi = Join-Path $rootPath "hmi\branches\develop\agent\development\bin\Debug\Laetus.NT.Core.HMI.Development.exe"
    $plant = Join-Path $rootPath "plant\branches\develop\agent\development\bin\Debug\Laetus.NT.Core.Platform.Plant.Development.exe"
    $uscExportImnport = Join-Path $rootPath "usc-export-import\branches\develop\agent\development\bin\Debug\Laetus.NT.Core.USCExportImport.Development.exe"

    

    $agentsToStart = $pomfileExe, $controlPanelExe, $auditTrail, $centralizedLogger, $configuration, $hmi, $plant, $uscExportImnport
     foreach($agent in $agentsToStart) {
        if(![string]::IsNullOrEmpty($agent) -and $rootPath -ne $agent)
        {
            
            $split = $agent.Split([char]"\")
            $commandName = $split[-1]
            $info = [string]::Format("Trying to start agent: {0} `nfrom {1}", $commandName, $agent)
            Write-Host $info
            $process = Start-Process $agent
        }
    }

    
    
}else{
    $warning = [string]::Format("The directory {0} does not exist", $rootPath)
    Write-Host $warning
}
}

Function Execute-Command ($commandTitle, $commandPath, $commandArguments)
{
Try {
    Write-Host $commandTitle
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = $commandPath
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = $commandArguments
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $pinfo
    $p.Start() | Out-Null
    $p.WaitForExit()
    $p | Add-Member "commandTitle" $commandTitle
    $p | Add-Member "stdout" $p.StandardOutput.ReadToEnd()
    $p | Add-Member "stderr" $p.StandardError.ReadToEnd()
    $p | Add-Member "exitCode" $p.ExitCode
    Write-Host $p.commandTitle
    Write-Host $p.stdout
    Write-Host $p.stdout
  }
  Catch {
     exit
  }

}

main