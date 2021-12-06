#EXAMPLE if the service has dependent services
#Get-Service -Name "Splunkd" | Format-List -Property Name, DependentServices
#Stop-Service -Name "iisadmin" -Force -Confirm

#check which app node is online
$service = 'WpnService'

$nodes = @('google.com', 'asidoihdooifwa.com')
foreach ($node in $nodes){
$nodenames = $node
$testConnection = Test-Connection $nodenames -ErrorAction SilentlyContinue

If ($testconnection -ne $null){
    Write-Host "$nodenames app is online, now turning off it's services for the switchover."
    Write-Host "----Attempting to stop $service services----"
    Stop-Service -Name $service -ErrorAction stop
    Start-Sleep 3
    Write-Host "----$service Services stopped----"
}
Else{
    Write-Host "$nodenames app is offline, now turning on it's services for the switchover."
    Write-Host "----Attempting to start $service services----"
    Start-Service -Name $service -ErrorAction stop
    Start-Sleep 3
    Write-Host "----$service Services started----"
}
}

<#
#Basic stop and start service if it has no dependencies
#Has to run script on administrator
$service = 'Splunkd'

Write-Host "----Stopping the $service services----"
Stop-Service -Name $service
Write-Host "----$service Services stopped----"
Write-Host "----Starting the $service services----"
Start-Service -Name $service
Write-Host "----$service Services started----"
#>
