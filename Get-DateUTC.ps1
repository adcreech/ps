function Get-DateUTC {
    [datetime]::Now.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
}