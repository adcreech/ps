Function ConvertFrom-UnixTime {  
    param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [Int32]$UnixTime
    )
    begin {
        $startdate = Get-Date –Date '01/01/1970' 
    }
    process {
        $timespan = New-Timespan -Seconds $UnixTime
        $startdate + $timespan
    }
}