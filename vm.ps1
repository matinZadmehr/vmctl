param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet(
        "list",
        "start",
        "stop",
        "force-stop",
        "pause",
        "resume",
        "status"
    )]
    [string]$Action,

    [Parameter(Position = 1)]
    [string]$Name,

    [switch]$Running
)

switch ($Action) {

    "list" {
        if ($Running) {
            VBoxManage list runningvms
        }
        else {
            VBoxManage list vms
        }
    }

    "start" {
        VBoxManage startvm $Name --type headless
    }

    "stop" {
        VBoxManage controlvm $Name acpipowerbutton
    }

    "force-stop" {
        VBoxManage controlvm $Name poweroff
    }

    "pause" {
        VBoxManage controlvm $Name pause
    }

    "resume" {
        VBoxManage controlvm $Name resume
    }

    "status" {
        VBoxManage showvminfo $Name
    }

}