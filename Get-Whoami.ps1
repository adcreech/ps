$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$identity | Select-Object Name,AuthenticationType
