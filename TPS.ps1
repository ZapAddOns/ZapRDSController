# File to save the name of active user
$file = '<Common used path>\TPS.txt'

# Name of active user
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

if (test-path -Path $file) 
{
    # There is already a file with the above name, so someone is already logged in
	$wshell = New-Object -ComObject Wscript.Shell 
	$username = Get-Content $file
    # Replace domain and points in name
    $username = $username.Replace("<Domain>\", "").Replace(".", " ") 
    $TextInfo = (Get-Culture).TextInfo
    $username = $TextInfo.ToTitleCase($username)
	$message = "User " + $username + " is already logged in"
	$output = $wshell.Popup($message)
    exit
}

# Save username in text file
echo $user > $file
cmdkey /generic:TERMSRV/<IP of TPS> /user:<User TPS> /password:<Password TPS>
start-process -FilePath "mstsc" -ArgumentList "/v:<IP of TPS>:3390" -Wait -WindowStyle Maximized
cmdkey /delete:TERMSRV/<IP of TPS>
remove-item $file
