function Connect-VMSSH {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )


    $config = Get-Content "$PSScriptRoot\..\vm.config.json" | ConvertFrom-Json


    $vmConfig = $config.vms.$Name


    if (-not $vmConfig) {

        Write-Host "VM configuration not found: $Name"
        return

    }


    $username = $vmConfig.username
    $ip = $vmConfig.ip
    $port = $vmConfig.sshPort


    if (-not $ip) {

        Write-Host "IP address not configured for $Name"
        return

    }


    ssh "$username@$ip" -p $port

}


Export-ModuleMember -Function Connect-VMSSH