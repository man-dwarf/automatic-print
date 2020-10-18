# $files = Get-ChildItem "c:\printable\*.pdf"

# foreach ($file in $files){
#     start-process -FilePath $file.fullName -Verb Print
#     # Write-Host $file.fullName
# }
# start-process -FilePath C:\printable\sample.pdf –Verb Print


$filter = '*.pdf'


# $watcher = New-Object System.IO.FileSystemWatcher
# $watcher.Path = $args[0] 
# $watcher.EnableRaisingEvents = $true

$watcher = New-Object IO.FileSystemWatcher $args[0], $filter -Property @{IncludeSubdirectories = $false;NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'}
$action =
{
    $path = $event.SourceEventArgs.FullPath
    # $ext = [System.IO.Path]::GetExtension($path)
    # Write-Host $path
    # if ($ext -like '*.pdf') { 
        start-process -FilePath $path -Verb Print
    # }
}

Register-ObjectEvent $watcher 'Created' -Action $action