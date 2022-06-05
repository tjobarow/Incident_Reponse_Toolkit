$hostname = $env:COMPUTERNAME

function Clean-Up {

    Start-Sleep -Seconds 10

    #Remove zip file 
    rm C:\resptools.zip

    Remove-Item -Recurse -Force C:\resptools

}

#Compress and save reports dir to zip
Compress-Archive -Path C:\resptools\Reports -DestinationPath "C:\Reports.zip"

$output_file = @{
    File="C:\Reports.zip"
}

Clean-Up

$output_file | ConvertTo-Json