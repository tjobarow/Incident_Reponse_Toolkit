function RetrieveUserProfilePaths {
    $profiles = Get-ChildItem 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList' | ForEach-Object { $_.GetValue('ProfileImagePath') } | Select-String 'C:\\Users\\*'
    return $profiles
}

function GetChromeData {
    
    #Accept list of profiles as param
    param($profiles)

    #make directory to store chrome data
    mkdir C:\resptools\Reports\ChromeData

    #for each user profile, we will check if user has chrome data and gather it if so
    foreach ($profile in $profiles) {

        #split path into array to get username
        $pathSplit = $profile -Split "\\"

        #username is at index 2 of the array
        $userName = $pathSplit[2]

        #The user profile is concatinated with the directory where chrome data lives
        $chromeUserPath = "$($profile)\AppData\Local\Google\Chrome\User Data\Default\"

        #If the user does have chrome data (if the chrome directory exists)
        if (Test-Path -Path $chromeUserPath) {
            Write-Host "$($userName) has a Chrome directory!"

            #Make a directory under C:\resptools\Reports\ChromeData with the username as the directory name
            mkdir "C:\resptools\Reports\ChromeData\$($userName)"

            #Get Chrome 
            Copy-Item -Path "$($chromeUserPath)Preferences" -Destination "C:\resptools\Reports\ChromeData\$($userName)\Preferences.json"
            #Get Chrome History
            Copy-Item -Path "$($chromeUserPath)History" -Destination "C:\resptools\Reports\ChromeData\$($userName)\History.sql"
            #Get Chrome Cache
            Copy-Item -Path "$($chromeUserPath)Cache\Cache_Data" -Destination "C:\resptools\Reports\ChromeData\$($userName)"
            #Get Chrome Web Data
            Copy-Item -Path "$($chromeUserPath)Web Data" -Destination "C:\resptools\Reports\ChromeData\$($userName)\Web Data.sql"
            #Get Bookmarks
            Copy-Item -Path "$($chromeUserPath)Bookmarks" -Destination "C:\resptools\Reports\ChromeData\$($userName)\Bookmarks.json"
            #Get Cookies
            Copy-Item -Path "$($chromeUserPath)Network\Cookies" -Destination "C:\resptools\Reports\ChromeData\$($userName)\Cookies.sql"
            #Get Top Sites
            Copy-Item -Path "$($chromeUserPath)Top Sites" -Destination "C:\resptools\Reports\ChromeData\$($userName)\Top Sites.sql"

        }
        else {
            Write-Host "$($userName) DOES NOT have a Chrome directory!"
        }

    }

}

$profiles = RetrieveUserProfilePaths
GetChromeData $profiles