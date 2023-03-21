param([string]$sourcePath = "D:\SDE",<#$(throw "-sourcePath is required."),#>
[string]$targetPath = "Laetus\UP\Laetus UP Core PlatformService Line"<#$(throw "-targetPath is required.")#>
)
Function main()
{
    $currentDir = $PSScriptRoot
    $vmsPath = Join-Path $currentDir "VMs.txt"
    $ips = [string[]](Get-Content $vmsPath)
    Write-Host "Found ips:", $ips
    foreach($ip in $ips)
    {
        Map-Drive $ip
        Copy-Files $ip $sourcePath
    }
}

Function Map-Drive($ip)
{
    $arguments = [string]::Format("use \\$ip\c$ 1gfD4zUJqwes /user:laetus")
    Execute-Command "" "net" $arguments
}

Function Copy-Files($ip, $directory)
{
    $currentDir = $PSScriptRoot
    $files = Get-ChildItem -Path $directory
    $target = [string]::Format("\\{0}\c$\{1}", $ip, $targetPath)
    foreach($file in $files)
    {
        $arguments = [string]::Format("{0} `"{1}`" /Y", $file.FullName, $target)
        Execute-Command "" "xcopy" $arguments
    }
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