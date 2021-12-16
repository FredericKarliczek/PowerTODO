# Loading and exporting the functions

$moduleFolders = @('private', 'public', 'classes')

# Import everything in these folders
foreach ($folder in $moduleFolders) {
    $root = Join-Path -Path $PSScriptRoot -ChildPath $folder
    Write-Verbose "processing folder $root"
    if (Test-Path -Path $root) {
        $files = Get-ChildItem -Path $root -Filter *.ps1

        # dot source each file
        $files | Where-Object { $_.Name -NotLike '*.Tests.ps1' } | ForEach-Object { 
            Write-Verbose $_.Name
            . $_.FullName
        }
    }
}

Export-ModuleMember -Function (Get-ChildItem -Path "$PSScriptRoot\public\*.ps1").BaseName