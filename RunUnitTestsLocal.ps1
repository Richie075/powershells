param(
[string] $sourceDirectory = "D:\vsprojects\Calculator2\Calculator\Calculator.Test\bin\x64\Release\net5.0\"
, $fileFilters = @("*.Test.dll", "*_UnitTests.dll", "*UnitTests.dll")

)

#script that executes all unit tests available.
$nUnitLog = Join-Path $sourceDirectory "UnitTestResults.txt"
$nUnitErrorLog = Join-Path $sourceDirectory "UnitTestErrors.txt"

Write-Host "Source: $sourceDirectory"
Write-Host "NUnit Results: $nUnitLog"
Write-Host "NUnit Error Log: $nUnitErrorLog"
Write-Host "File Filters: $fileFilters"

$cFiles = ""
$nUnitExecutable = "D:\Downloads\NUnit.Console-3.15.2\bin\net6.0\nunit3-console.exe"

# look through all subdirectories of the source folder and get any unit test assemblies. To avoid duplicates, only use the assemblies in the Debug folder
[array]$files = get-childitem $sourceDirectory -include $fileFilters -recurse | select -expand FullName 

foreach ($file in $files)
{
    $cFiles = $cFiles + $file + " "
}

# set all arguments and execute the unit console
$argumentList = @("$cFiles", "--result=UnitTestResults.xml")

$unitTestProcess = start-process -filepath $nUnitExecutable -argumentlist $argumentList -wait -nonewwindow -passthru -RedirectStandardOutput $nUnitLog -RedirectStandardError $nUnitErrorLog

if ($unitTestProcess.ExitCode -ne 0)
{
    "Unit Test Process Exit Code: " + $unitTestProcess.ExitCode
    "See $nUnitLog for more information or $nUnitErrorLog for any possible errors."
    "Errors from NUnit Log File ($nUnitLog):"
    Get-Content $nUnitLog | Write-Host
}

$exitCode = $unitTestProcess.ExitCode

exit $exitCode