# Setup your github credentials. The following method will prompt you
# for your github access token. You can create an access token
# by going here: https://github.com/settings/tokens
# Set-GitHubAuthentication

# Later, we will call Get-GitHubRepositoryContributor. When the
# statistics are not ready, it waits 30 seconds before re-checking.
# To speed things up, we change the delay to 5 seconds.
Set-GitHubConfiguration -RetryDelaySeconds 5

# Disable telemetry to avoid annoying messages.
Set-GitHubConfiguration -DisableTelemetry

# This function will be helpful later to convert unix timestamps
# to real PowerShell 'DateTime' objects
function Convert-FromUnixDate ($UnixDate)
{
   [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate))
}
