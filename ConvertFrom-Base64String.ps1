<#
.SYNOPSIS
  Converts strings from base64 encoded strings into plaintext.
.DESCRIPTION
  The ConvertFrom-Base64String function returns a plaintext string for a base64 encoded string input.
.PARAMETER Base64String
  Specifies the base64 encoded string input to return in a decoded plaintext format.
.INPUTS
  None
.OUTPUTS
  System.String
  The plaintext decoded string is output as a System.String.
.NOTES
  Version:        0.1
  Author:         Adam Creech
  Creation Date:  5/29/2018
  Purpose/Change: Initial script development
  
.EXAMPLE
  PS C:\>ConvertFrom-Base64String 'VXNlcm5hbWU='

  This command decodes the base64 encoded string "VXNlcm5hbWU=" (without quotes) into a plaintext string.
#>
function ConvertFrom-Base64String {
param(
    [Parameter(
        Mandatory = $true
    )]
    [string]$Base64String
)

$decoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Base64String))
Write-Output -InputObject $decoded
}