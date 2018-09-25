# GoDaddy Powershell DDNS

A simple PowerShell script that checks your current public IP address and updates the nominated A record of a GoDaddy domain.

Requires a GoDaddy developer API key - register your account here: https://developer.godaddy.com/getstarted

To use, simply populate the following four fields in the script:

`$domain = 'yourdomain.com'`<br/>
The domain name to be updated.

`$name = 'your.subdomain'`<br/>
The A record to be updated.  Don't incude the domain name here.

`$key = 'yourapikey'`<br/>
The API key provided when you register your GoDaddy developer account.

`$secret = 'yourapisecret'`<br/>
The secret that is supplied when requesting the API key above.<br/><br/>

This can be registered as a scheduled task to run at a specified frequency using the following code:
```
$trigger = New-JobTrigger -Once -At "01/01/2018 0:00:00" -RepetitionInterval (New-TimeSpan -Minutes 5) -RepeatIndefinitely
Register-ScheduledJob -Trigger $trigger -FilePath C:\Scripts\godaddy_ddns.ps1 -Name "GoDaddy DDNS"
```


