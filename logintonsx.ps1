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