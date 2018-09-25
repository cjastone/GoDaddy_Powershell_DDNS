<#
godaddy_ddns.ps1

Checks and updates a nominated GoDaddy DNS A record to your current IP address of your current Internet connection.  

A fork of the original project at https://github.com/markafox/GoDaddy_Powershell_DDNS which at the time of forking was non-functional.

Requires GoDaddy developer account to obtain key and secret: https://developer.godaddy.com/getstarted

To use, simply update the first four variables with your domain, A record, API key and API secret.
#>

$domain = 'yourdomain.com'	 # domain name to update
$name = 'your.subdomain'  	 # A record to update
$key = 'yourapikey'		       # key for GoDaddy Developer API
$secret = 'yourapisecret'	  # secret for GoDaddy Developer API

# build request headers and perform lookup of current address of nominated A record
$headers = @{}
$headers["Authorization"] = 'sso-key ' + $key + ':' + $secret
$result = Invoke-WebRequest -uri "https://api.godaddy.com/v1/domains/$domain/records/A/$name" -method "GET" -headers $headers
$content = ConvertFrom-Json $result.content
$current_ip = $content.data

# obtain current external IP address
$new_ip = Invoke-RestMethod -uri "http://ipinfo.io/json" | Select -exp ip

# check exernal IP against DNS record and update if necessary
if ( $new_ip -ne $current_ip) {
    $body = ConvertTo-Json @(@{data=$new_ip;ttl=3600})
    Invoke-WebRequest -uri "https://api.godaddy.com/v1/domains/$domain/records/A/$name" -method "PUT" -headers $headers -Body $body -ContentType "application/json"
}
