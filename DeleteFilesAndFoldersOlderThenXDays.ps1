param(
    #[string]$directory = "D:\SVN\repos",
    [string]$directory = "D:\SVN\repos",
    [Parameter(Mandatory=$true)][int]$days
)

function DeleteAllFilesAndDirectories()
{
    Get-ChildItem -Path $directory -Directory -recurse| where {$_.LastWriteTime -le $(get-date).Adddays(-$days)} | Remove-Item -recurse -force
}

function Main()
{
    if(Test-Path($directory))
    {
        DeleteAllFilesAndDirectories
    }else{
        $warning = [string]::Format("The directory {0} does not exist", $directory)
        Write-Host $warning
    }
}

Main