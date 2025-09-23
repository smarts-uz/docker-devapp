cat ca_bundle.crt ssl.crt > fullchain.crt
Get-Content ssl.crt, ca_bundle.crt | Set-Content fullchain.crt
