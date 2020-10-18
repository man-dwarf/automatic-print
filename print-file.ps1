
$filter = '*.pdf'
# $dirpath = $args[0]
$dirpath = 'C:\Users\mgapc\Downloads'

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $dirpath
$watcher.Filter = "*.pdf"
$watcher.EnableRaisingEvents = $true

# $watcher = New-Object IO.FileSystemWatcher $dirpath, $filter -Property @{IncludeSubdirectories = $false}
$action =
{
    $path = $event.SourceEventArgs.FullPath
    Write-Host $path
    
    # $changeType = $Event.SourceEventArgs.ChangeType
    # Write-Host $changeType

    # $ext = [System.IO.Path]::GetExtension($path)
    # if ($ext -like '*.pdf') { 
    start-process -FilePath $path -Verb Print
    # }
}   

Register-ObjectEvent $watcher 'Created' -Action $action
# Downloaded files are renamed from .tmp -> .pdf
Register-ObjectEvent $watcher 'Renamed' -Action $action
# Register-ObjectEvent $watcher 'Changed' -Action $action
# Register-ObjectEvent $watcher 'Deleted' -Action $action