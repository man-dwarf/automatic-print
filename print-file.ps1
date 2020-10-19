
# $dirpath = $args[0]
$dirpath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $dirpath
$watcher.Filter = "*.pdf"
$watcher.EnableRaisingEvents = $true

$action =
{
    $path = $event.SourceEventArgs.FullPath
    Write-Host $path
    
    start-process -FilePath $path -Verb Print
}   

Register-ObjectEvent $watcher 'Created' -Action $action
# Downloaded files are renamed from .tmp -> .pdf
Register-ObjectEvent $watcher 'Renamed' -Action $action
# Register-ObjectEvent $watcher 'Changed' -Action $action
# Register-ObjectEvent $watcher 'Deleted' -Action $action
