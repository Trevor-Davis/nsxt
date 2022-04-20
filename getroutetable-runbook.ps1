Param(
  [Parameter(Mandatory=$true)]
  [string]$nsxtip,[String]$nsxtpassword,[string]$t0routername
  )


#########################################
# Encode the NSX-T Credentials
#########################################
$global:nsxtusername = "admin"
Write-Host -ForegroundColor Yellow "NSX-T Manager IP Address: " -NoNewline
$global:nsxtip = Read-Host
Write-Host -ForegroundColor Yellow "NSX-T Manager Password: " -NoNewline
$global:nsxtpassword = Read-Host
Write-Host -ForegroundColor Yellow "T0 Router Name (Example TNT58-T0): " -NoNewline
$global:t0routername = Read-Host

$global:nsxtcredentials = "$nsxtusername"+":"+"$nsxtpassword"
$global:nsxbytes = [System.Text.Encoding]::UTF8.GetBytes($nsxtcredentials)
$global:nsxtcredentialsencoded =[Convert]::ToBase64String($nsxbytes)

function global:logintonsx {
    param (
    )
  
  $global:headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
  $global:headers.Add("Authorization", "Basic $nsxtcredentialsencoded")
  $global:headers.Add("Content-Type", "application/json")
  }
  
  logintonsx

  $body = ""

$response = Invoke-RestMethod https://$nsxtip/policy/api/v1/infra/tier-0s/$t0routername/routing-table?format=csv -Method 'GET' -Headers $headers -Body $body -SkipCertificateCheck
$response | Out-String | Set-Content $Folder\routetable.csv
Write-Host -ForegroundColor Green "You can find the routetable.csv file here $Folder" 
Write-Host -ForegroundColor Yellow "
Do you want to open the file? (Y/N): " -NoNewline
$question = Read-Host

if ($question -eq "y"){

    Invoke-Expression -Command $Folder\routetable.csv

}
