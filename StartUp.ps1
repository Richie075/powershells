function WaitUntilServices($searchString, $status)
{
    # Get all services where DisplayName matches $searchString and loop through each of them.
    foreach($service in (Get-Service -DisplayName $searchString))
    {
        # Wait for the service to reach the $status or a maximum of 30 seconds
        $service.WaitForStatus($status, '00:01:30')
    }
}

function Main()
{
    $outfile = "D:\Laetus-UP\start.txt"
    Add-Content $outfile "Started"
    WaitUntilServices "Laetus UP Core Platform Service Line" "Running"
    Add-Content $outfile "Service started, waiting 60 seconds"
    Start-Sleep -s 30
    Start-Process "D:\Laetus\UP\Chromium\chromium-61.0.3163.0\chrome.exe" "--kiosk http://10.31.13.35:2000 --no-first-run"
    Add-Content $outfile "Chrome started"
}

Main