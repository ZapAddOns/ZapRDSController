# File to save the name of active user
$file = '<Common used path>\TPS.txt'

# IP address of TPS (when behind a firewall, IP address of firewall)
$ipaddress = '<IP of TPS>'
$port = '<Port of TPS>'

# Username and password on TPS
$tpsuser = '<User TPS>'
$tpspassword ='<Password TPS>'

# Domain for the users
$domain = '<Domain>'

### Don't make changes below this line ###

# Name of active user
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

if (test-path -Path $file) 
{
    # There is already a file with the above name, so someone is already logged in
	$wshell = New-Object -ComObject Wscript.Shell 
	$username = Get-Content $file
    # Replace domain and points in name
    $username = $username.Replace("${domain}\", "").Replace(".", " ") 
    $TextInfo = (Get-Culture).TextInfo
    $username = $TextInfo.ToTitleCase($username)
	$message = "User " + $username + " is already logged in"
	$output = $wshell.Popup($message)
    exit
}

# Save username in text file
echo $user > $file
cmdkey /generic:TERMSRV/$ipaddress /user:$tpsuser /password:$tpspassword
start-process -FilePath "mstsc" -ArgumentList "/v:${ipaddress}:${port}" -Wait -WindowStyle Maximized
cmdkey /delete:TERMSRV/$ipaddress
remove-item $file
