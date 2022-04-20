$global:Folder = "$env:TEMP\routetable"
if (Test-Path -Path $Folder) {
""
} else {
mkdir $env:TEMP\routetable
}

$filename1 = "logintonsx.ps1"
Invoke-WebRequest -uri "https://raw.githubusercontent.com/Trevor-Davis/nsxt/main/$filename1" `
-OutFile $Folder\$filename1

$filename2 = "routetable.ps1"
Invoke-WebRequest -uri "https://raw.githubusercontent.com/Trevor-Davis/nsxt/main/$filename2" `
-OutFile $Folder\$filename2

#Copy-Item "C:\Users\avs-admin\Documents\GitHub\nsxt\*" -Destination "$Folder"

Clear-host
Invoke-Expression -Command $Folder\$filename1
Clear-host
Invoke-Expression -Command $Folder\$filename2
