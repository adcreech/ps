<#
.SYNOPSIS
  Converts strings into base64 encoded strings.
.DESCRIPTION
  The ConvertTo-Base64String function returns a base64 encoded string for a string input.
.PARAMETER PlainText
  Specifies the string input to return in an encoded base64 format. Use single quotes to encapsulate strings containing spaces.
.INPUTS
  None
.OUTPUTS
  System.String
  The base64 encoded string is output as a System.String.
.NOTES
  Version:        0.1
  Author:         Adam Creech
  Creation Date:  5/29/2018
  Purpose/Change: Initial script development
  
.EXAMPLE
  PS C:\>ConvertTo-Base64String 'Username'

  This command converts the UTF8 plaintext string "Username" (without quotes) into a base64 encoded string.
#>
function ConvertTo-Base64String {
param(
    [Parameter(
        Mandatory = $true
    )]
    [string]$PlainText
)

$encoded = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($PlainText))
Write-Output -InputObject $encoded
}