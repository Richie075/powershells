param(
    #[string]$directory = "D:\SVN\repos",
    [string]$directory = "D:\SVN\repos",
    [Parameter(Mandatory=$true)][string]$filePattern,
    [Parameter(Mandatory=$true)][string] $searchPattern,
    [Parameter(Mandatory=$true)][int] $searchFileNamesOnly
)

function GetAllFiles()
{
    $searchPath = $directory.Trim(" ")
    Write-Host $searchPath 
    if($searchFileNamesOnly -eq 1)
    {
        $searchString = [string]::Format("*.{0}",$filePattern)
        $info = [string]::Format("Executing: Get-ChildItem -Path {0} -Recurse -Include {1}", $searchPath, $searchString)    
        Write-Host $info
        return Get-ChildItem -Path $searchPath -Recurse -Include $searchString
    }else{
        $searchString = [string]::Format("*{0}*.{1}", $searchPattern, $filePattern)
        $info = [string]::Format("Executing: Get-ChildItem -Path {0} -Recurse -Include {1}", $searchPath, $searchString)    
        Write-Host $info
        return Get-ChildItem -Path $searchPath -Recurse -Include $searchString
    }
}

function Main()
{
    if(Test-Path($directory))
    {
        $outfile = Join-Path $directory "findings.txt"
        $allFiles = GetAllFiles($directory, $filePattern)
        #$info = [string]::Format("Searching {0} in files", $searchPattern)
        #Add-Content $outfile $info
        #Add-Content $outfile $allFiles
        $files = New-Object System.Collections.Generic.List[string]
        $dict = New-Object System.Collections.Generic.List[pscustomobject]
        $fileCounter = 0
        if($searchFileNamesOnly -eq 1)
        {
            Write-Host "Searching file content"
        }
        else{
            Write-Host "Searching in file names"
        }
        foreach($file in $allFiles)
        {
            if($searchFileNamesOnly -eq 1)
            {
                $content = Get-Content -Path $file.FullName
                $lineCounter = 1
                foreach($line in $content)
                {
                    if($line.Contains($searchPattern))
                    {
                        if(-not $files.Contains($file))
                        {
                            $files.Add($file)
                            $fileCounter++
                        }
                        $fileEntry =[pscustomobject]@{Line=$lineCounter;FileName=$file;Content=$line}
                        $needToAdd =-not ($dict.Contains($fileEntry))

                        if($needToAdd)
                        {
                            $dict.Add($fileEntry)
                        }
                        $info = [string]::Format("Line: {0} `t File {1} `t Content {2}", $lineCounter, $file, $line)
                        Write-Host $info
                        #Add-Content $outfile $info
                    }
                    
                    $lineCounter++
                }
            }
            else{
                Write-Host $allFiles
            }

        }
        $info = [string]::Format("Found {0} Files", $fileCounter)
        Add-Content $outfile $info
        Add-Content $outfile $files | Out-String
        Add-Content $outfile "Details"
        Add-Content $outfile $dict | Out-String
        $dict | Out-String
    }else{
        $warning = [string]::Format("The directory {0} does not exist", $directory)
        Write-Host $warning
    }
}

Main