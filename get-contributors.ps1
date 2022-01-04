function Convert-FromUnixDate ($UnixDate)
{
   [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate))
}

function Get-ContributorsStatistics($Repositories)
{
    foreach ($repository in $Repositories)
    {
        Write-Host "Getting statistics for repository $($repository.name)"
        $contributors = Get-GitHubRepositoryContributor -OwnerName 'EQWorks' -RepositoryName $repository.name -IncludeStatistics

        foreach ($contributor in $contributors)
        {
            $contributor.weeks |
                Sort-Object -Descending w |
                ForEach-Object {
                    [pscustomobject]@{
                        Author     = $contributor.author.login;
                        Repository = $repository.name;
                        Fork       = $repository.fork;
                        Private    = $repository.private;
                        Week       = Convert-FromUnixDate $_.w;
                        Added      = $_.a;
                        Deleted    = $_.d;
                        Commits    = $_.c;
                    }
                }
        }
    }
}

Get-ContributorsStatistics -Repositories $args[0] | Where-Object { $_.Week -ge "${args[1]}-01-01" } | Sort-Object -Descending Week | Export-Csv ./$args[1]/contributors.csv
