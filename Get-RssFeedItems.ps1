<#
.SYNOPSIS
  Retrieves items from an RSS feed to return item title, description, link, and publish date.
.DESCRIPTION
  The Get-RssFeedItems function makes an HTTP GET to the specified RSS feed Uri to return an array of parsed items.
.INPUTS
  None
.OUTPUTS
  PSCustomObject
  The results are output as a PSCustomObject.
.NOTES
  Version:        1.0
  Author:         Adam Creech
  Creation Date:  2020-01-22
  Purpose/Change: Initial script development

  References:
  [1] RSS 2.0 SPECIFICATION - Required channel elements - https://validator.w3.org/feed/docs/rss2.html#requiredChannelElements
  
.EXAMPLE
  PS C:\>Get-RssReleaseNotes -Uri "https://docs.aws.amazon.com/systems-manager/latest/userguide/aws-systems-manager-user-guide-updates.rss"

#>
function Get-RssFeedItems{
param(
    # Specifies the RSS feed from which to retrieve results.
    [Parameter(Mandatory = $true,ValueFromPipeline=$true)]
    [Uri]$Uri,
    # Specifies the max number of results to return. Defaults to 10.
    [Int]$MaxResults = 10,
    # (Optional) Filter results by those published within the last X days.
    [Int]$WithinDays
)

Begin{
    Try{
        $rss = Invoke-WebRequest -Uri $Uri -UseBasicParsing
    }
    Catch [System.Exception]{
        $IwrError = $error[0]
        $IwrErrorException = $IwrError.Exception
        Write-Error "An error occurred while attempting to connect to the requested site. The error was: $IwrErrorException"
        Write-Verbose "Full error details:"
        Write-Verbose $IwrError.ErrorDetails
        }
    }
Process{
    # Parse web response as XML
    [xml]$content = $rss.Content
    
    # If WithinDays parameter specified, filter result items by publish date
    if($WithinDays){
        $results = $content.rss.channel.item | Where-Object {[datetime]$_.pubDate -gt (Get-Date).AddDays(-$WithinDays)} | Select-Object title,pubDate,link,description -First $MaxResults
    }
    else{
        $results = $content.rss.channel.item | Select-Object title,pubDate,link,description -First $MaxResults
    }
    # Output results, removing whitespace and casting pubDate as datetime
    # To do: add fallback for failed datetime cast of pubDate in case value doesn't match expected format
    $results | Select-Object @{n="title";e={($_.title) -replace '\s+', ' '}}, @{n="pubDate";e={([datetime]$_.pubDate)}}, @{n="description";e={($_.description) -replace '\s+', ' '}}, link
    }
}