function Get-Raw-Event-Logs {

    cd "C:\resptools\"

    mkdir "C:\resptools\Reports\Event-Logs\"

    $logList = Get-ChildItem "C:\Windows\System32\winevt\Logs" -Name
    
    foreach ($log in $logList) {
        echo "Retrieving log file named: $($log)..."
        .\fget.exe -extract "C:\Windows\System32\winevt\Logs\$($log)" "C:\resptools\Reports\Event-Logs\$($log)"
    }

}

Get-Raw-Event-Logs

Compress-Archive -Path C:\resptools\Reports\Event-Logs -DestinationPath "C:\resptools\Reports\Event-Logs.zip"

Remove-Item -Recurse -Force C:\resptools\Reports\Event-Logs