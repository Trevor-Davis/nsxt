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
