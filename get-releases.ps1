function Get-Releases($repositories)
{
    foreach ($repository in $repositories)
    {
        Write-Host "Getting statistics for repository $($repository.name)"
        $releases = Get-GitHubRelease -OwnerName 'EQWorks' -RepositoryName $repository.name

        foreach ($release in $releases)
        {
            $release | Add-Member -Name 'Repository' -Value $repository.name -MemberType NoteProperty
            $release
        }
    }
}

Get-Releases -Repositories $args[0] |
    Where-Object { $_.published_at -ge (Get-Date "2021-01-01") } |
    Sort-Object -Descending published_at |
    Export-Csv -Path "./2021/releases.csv"
