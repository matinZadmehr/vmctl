function Get-VMList {

    param(
        [switch]$Running
    )

    if ($Running) {
        $vms = VBoxManage list runningvms
    }
    else {
        $vms = VBoxManage list vms
    }

    foreach ($vm in $vms) {

        if ($vm -match '^"(.+)" \{(.+)\}$') {

            [PSCustomObject]@{
                Name = $matches[1]
                Id   = $matches[2]
            }

        }

    }

}


function Start-VM {

    param(
        [string]$Name
    )

    VBoxManage startvm "$Name" --type headless

}


function Stop-VM {

    param(
        [string]$Name
    )

    VBoxManage controlvm "$Name" acpipowerbutton

}


function Restart-VM {

    param(
        [string]$Name
    )

    VBoxManage controlvm "$Name" acpipowerbutton

    Start-Sleep -Seconds 5

    VBoxManage startvm "$Name" --type headless

}


function Get-VMInfo {

    param(
        [string]$Name
    )

    VBoxManage showvminfo "$Name"

}


function Get-VMStatus {

    param(
        [string]$Name
    )

    $info = VBoxManage showvminfo "$Name" --machinereadable

    $state = $info | Select-String "VMState="

    $state

}


function Get-VMIP {

    param(
        [string]$Name
    )

    VBoxManage guestproperty get "$Name" "/VirtualBox/GuestInfo/Net/0/V4/IP"

}


Export-ModuleMember -Function *