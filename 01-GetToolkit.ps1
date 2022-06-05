Add-Type -AssemblyName System.IO.Compression.FileSystem

#The below function unzips a zip file to a directory at the specified filepath
function Unzip {
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

#Get the zip from my github
wget https://github.com/tjobarow/Incident_Reponse_Toolkit/blob/main/resptools.zip?raw=true -OutFile C:\resptools.zip

#Unzip resptools zip, which contains executables
Unzip "C:\resptools.zip" "C:\resptools"

#Make dir to hold all reports
mkdir "C:\resptools\Reports"

systeminfo > "C:\resptools\Reports\$(hostname)-specs.txt"


