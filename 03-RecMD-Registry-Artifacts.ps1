#The below function runs the RecMD and AmCacheParser tools.
#RecMD is pointed at C:\Windows to get all Registry Hives and Transaction logs from this directory
#AmCacheParser is pointed at C:\Windows\appcompat\Programs\Amcache.hve

function RegistryGathering {

    cd C:\resptools\RecMD
    mkdir C:\resptools\Reports\RecMDOutput-Registry-Hives
    .\RECmd.exe --bn ".\BatchExamples\Kroll_Batch.reb" -d C:\Windows\ --csv "..\Reports\RecMDOutput-Registry-Hives" --csvf Kroll_Batch_Registry_Output.csv

    cd C:\resptools\AmCacheParser
    mkdir C:\resptools\Reports\AmCacheOutput
    .\AmcacheParser.exe -f C:\Windows\appcompat\Programs\Amcache.hve -i --csv "..\Reports\AmCacheOutput" --csvf Amcache_Registry_Output.csv

}

#Gather registry information and save it to C:\resptools\Reports
RegistryGathering