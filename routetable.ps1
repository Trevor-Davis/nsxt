$body = ""

$response = Invoke-RestMethod https://$nsxtip/policy/api/v1/infra/tier-0s/$t0routername/routing-table?format=csv -Method 'GET' -Headers $headers -Body $body -SkipCertificateCheck
$response | Out-String | Set-Content c:\temp\routetable.csv