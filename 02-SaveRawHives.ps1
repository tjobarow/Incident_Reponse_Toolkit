function RetrieveUserProfilePaths {
    $profiles = Get-ChildItem 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList' | ForEach-Object { $_.GetValue('ProfileImagePath') } | Select-String 'C:\\Users\\*'
    return $profiles
}

function Process-SRUMDB {
    mkdir C:\resptools\Reports\Raw_Registry_Hives\SRUMDB

    $fileList = Get-ChildItem "C:\Windows\System32\sru" -Name
    
    foreach ($file in $fileList) {
        echo "Retrieving SRUM file named: $($file)..."
        .\fget.exe -extract "C:\Windows\System32\sru\$($file)" "C:\resptools\Reports\Raw_Registry_Hives\SRUMDB\$($file)"
    }
    #cd "C:\resptools\Reports\Raw_Registry_Hives\SRUMDB"
    #esentutl.exe /r SRU /l C:\resptools\Reports\Raw_Registry_Hives\SRUMDB /s C:\resptools\Reports\Raw_Registry_Hives\SRUMDB /i
    #esentutl.exe /p C:\resptools\Reports\Raw_Registry_Hives\SRUMDB\SRUDB.dat /o
    #C:\resptools\srumECmd\SrumECmd.exe -f "C:\resptools\Reports\Raw_Registry_Hives\SRUMDB\SRUDB.dat" -r "C:\resptools\Reports\Raw_Registry_Hives\SOFTWARE_clean" --csv "C:\resptools\Reports\Raw_Registry_Hives\SRUMDB\CSVs"
}


function FGET-Registry-Hives {

    $profiles = RetrieveUserProfilePaths

    cd C:\resptools\

    mkdir C:\resptools\Reports\Raw_Registry_Hives

    foreach ($profile in $profiles) {

        #split path into array to get username
        $pathSplit = $profile -Split "\\"

        #username is at index 2 of the array
        $userName = $pathSplit[2]

        if (Test-Path -Path "$($profile)\NTUSER.DAT") {
            mkdir "C:\resptools\Reports\Raw_Registry_Hives\$($userName)-NTUSER-USRCLASS\"
            #NTUSER
            .\fget.exe -extract "$($profile)\NTUSER.DAT" "C:\resptools\Reports\Raw_Registry_Hives\$($userName)-NTUSER-USRCLASS\NTUSER.DAT"
            .\fget.exe -extract "$($profile)\ntuser.dat.LOG1" "C:\resptools\Reports\Raw_Registry_Hives\$($userName)-NTUSER-USRCLASS\ntuser.dat.LOG1"
            .\fget.exe -extract "$($profile)\ntuser.dat.LOG2" "C:\resptools\Reports\Raw_Registry_Hives\$($userName)-NTUSER-USRCLASS\ntuser.dat.LOG2"
            #USRCLASS
            .\fget.exe -extract "$($profile)\AppData\Local\Microsoft\Windows\UsrClass.dat" "C:\resptools\Reports\Raw_Registry_Hives\$($userName)-NTUSER-USRCLASS\UsrClass.dat"
            .\fget.exe -extract "$($profile)\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG1" "C:\resptools\Reports\Raw_Registry_Hives\$($userName)-NTUSER-USRCLASS\UsrClass.dat.LOG1"
            .\fget.exe -extract "$($profile)\AppData\Local\Microsoft\Windows\UsrClass.dat.LOG2" "C:\resptools\Reports\Raw_Registry_Hives\$($userName)-NTUSER-USRCLASS\UsrClass.dat.LOG2"
            }
       
       }

    .\fget.exe -extract C:\Windows\System32\config\BBI C:\resptools\Reports\Raw_Registry_Hives\BBI
    .\fget.exe -extract C:\Windows\System32\config\BBI.LOG1 C:\resptools\Reports\Raw_Registry_Hives\BBI.LOG1
    .\fget.exe -extract C:\Windows\System32\config\BBI.LOG2 C:\resptools\Reports\Raw_Registry_Hives\BBI.LOG2

    .\fget.exe -extract C:\Windows\System32\config\COMPONENTS C:\resptools\Reports\Raw_Registry_Hives\COMPONENTS
    .\fget.exe -extract C:\Windows\System32\config\COMPONENTS.LOG1 C:\resptools\Reports\Raw_Registry_Hives\COMPONENTS.LOG1
    .\fget.exe -extract C:\Windows\System32\config\COMPONENTS.LOG2 C:\resptools\Reports\Raw_Registry_Hives\COMPONENTS.LOG2

    .\fget.exe -extract C:\Windows\System32\config\DEFAULT C:\resptools\Reports\Raw_Registry_Hives\DEFAULT
    .\fget.exe -extract C:\Windows\System32\config\DEFAULT.LOG1 C:\resptools\Reports\Raw_Registry_Hives\DEFAULT.LOG1
    .\fget.exe -extract C:\Windows\System32\config\DEFAULT.LOG2 C:\resptools\Reports\Raw_Registry_Hives\DEFAULT.LOG2

    .\fget.exe -extract C:\Windows\System32\config\DRIVERS C:\resptools\Reports\Raw_Registry_Hives\DRIVERS
    .\fget.exe -extract C:\Windows\System32\config\DRIVERS.LOG1 C:\resptools\Reports\Raw_Registry_Hives\DRIVERS.LOG1
    .\fget.exe -extract C:\Windows\System32\config\DRIVERS.LOG2 C:\resptools\Reports\Raw_Registry_Hives\DRIVERS.LOG2

    .\fget.exe -extract C:\Windows\System32\config\SAM C:\resptools\Reports\Raw_Registry_Hives\SAM
    .\fget.exe -extract C:\Windows\System32\config\SAM.LOG1 C:\resptools\Reports\Raw_Registry_Hives\SAM.LOG1
    .\fget.exe -extract C:\Windows\System32\config\SAM.LOG2 C:\resptools\Reports\Raw_Registry_Hives\SAM.LOG2

    .\fget.exe -extract C:\Windows\System32\config\SECURITY C:\resptools\Reports\Raw_Registry_Hives\SECURITY
    .\fget.exe -extract C:\Windows\System32\config\SECURITY.LOG1 C:\resptools\Reports\Raw_Registry_Hives\SECURITY.LOG1
    .\fget.exe -extract C:\Windows\System32\config\SECURITY.LOG2 C:\resptools\Reports\Raw_Registry_Hives\SECURITY.LOG2

    .\fget.exe -extract C:\Windows\System32\config\SOFTWARE C:\resptools\Reports\Raw_Registry_Hives\SOFTWARE
    .\fget.exe -extract C:\Windows\System32\config\SOFTWARE.LOG1 C:\resptools\Reports\Raw_Registry_Hives\SOFTWARE.LOG1
    .\fget.exe -extract C:\Windows\System32\config\SOFTWARE.LOG2 C:\resptools\Reports\Raw_Registry_Hives\SOFTWARE.LOG2

    .\fget.exe -extract C:\Windows\System32\config\SYSTEM C:\resptools\Reports\Raw_Registry_Hives\SYSTEM
    .\fget.exe -extract C:\Windows\System32\config\SYSTEM.LOG1 C:\resptools\Reports\Raw_Registry_Hives\SYSTEM.LOG1
    .\fget.exe -extract C:\Windows\System32\config\SYSTEM.LOG2 C:\resptools\Reports\Raw_Registry_Hives\SYSTEM.LOG2

    .\fget.exe -extract C:\Windows\appcompat\Programs\Amcache.hve C:\resptools\Reports\Raw_Registry_Hives\Amcache.hve
    .\fget.exe -extract C:\Windows\appcompat\Programs\Amcache.hve.LOG1 C:\resptools\Reports\Raw_Registry_Hives\Amcache.hve.LOG1
    .\fget.exe -extract C:\Windows\appcompat\Programs\Amcache.hve.LOG2 C:\resptools\Reports\Raw_Registry_Hives\Amcache.hve.LOG2

}

#Copy registry hives 
FGET-Registry-Hives

Process-SRUMDB