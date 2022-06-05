function RecycleBinGathering {
    cd C:\resptools\RBCmd
    .\RBCmd.exe -d 'C:\$Recycle.Bin' --csv "..\Reports" --csvf Recycle_Bin.csv
}

#Gather Recycle Bin information and save it to C:\resptools\Reports
RecycleBinGathering