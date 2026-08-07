param(
    [Parameter(Position = 0)]
    [string]$Action,

    [Parameter(Position = 1)]
    [string]$Name,

    [Parameter(Position = 2)]
    [string]$Option
)

# Reload module every execution
Import-Module $PSScriptRoot\Modules\VirtualBox.psm1 -Force
Import-Module $PSScriptRoot\Modules\SSH.psm1 -Force

switch ($Action.ToLower()) {

    "ssh" {

    if (-not $Name) {
        Write-Host "Usage: vm ssh <VM Name>"
        exit 1
    }

    Connect-VMSSH -Name $Name

    }
    "list" {

    if ($Name -eq "running") {
        Get-VMList -Running
    }
    else {
        Get-VMList
    }
}

    "start" {

        if (-not $Name) {
            Write-Host "Usage: vm start <VM Name>"
            exit 1
        }

        Start-VM -Name $Name

    }


    "stop" {

        if (-not $Name) {
            Write-Host "Usage: vm stop <VM Name>"
            exit 1
        }

        Stop-VM -Name $Name

    }


    "restart" {

        if (-not $Name) {
            Write-Host "Usage: vm restart <VM Name>"
            exit 1
        }

        Restart-VM -Name $Name

    }


    "status" {

        if (-not $Name) {
            Write-Host "Usage: vm status <VM Name>"
            exit 1
        }

        Get-VMStatus -Name $Name

    }


    "info" {

        if (-not $Name) {
            Write-Host "Usage: vm info <VM Name>"
            exit 1
        }

        Get-VMInfo -Name $Name

    }


    "ip" {

        if (-not $Name) {
            Write-Host "Usage: vm ip <VM Name>"
            exit 1
        }

        Get-VMIP -Name $Name

    }


    default {

        Write-Host ""
        Write-Host "vmctl - Virtual Machine Control"
        Write-Host ""
        Write-Host "Commands:"
        Write-Host ""
        Write-Host "  vm list"
        Write-Host "  vm start <name>"
        Write-Host "  vm stop <name>"
        Write-Host "  vm restart <name>"
        Write-Host "  vm status <name>"
        Write-Host "  vm info <name>"
        Write-Host "  vm ip <name>"
        Write-Host ""

    
    }
}