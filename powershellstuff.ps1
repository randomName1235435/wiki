function Find-InPath {
    <#
    .EXAMPLE 
    Find-InPath "C:\Temp\logTemp\" 'XXX'
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $True)]
        [string]$path,
        [string]$filter
        #[Switch]$asPlain
    )
    $searchableFileExtensions = '.xml', '.txt', '.log', '.java', '.cs', 'csproj'
        
    $FileCount = ((Get-ChildItem $path -r -file) | Measure-Object ).Count
    $currentFileCount = 0
        
    $result = @()
    foreach ($item in Get-ChildItem $path -r -file) {
        if ($searchableFileExtensions -contains $item.Extension ) {
            $LineNumbers = Select-String $filter -path $item.fullname | Select-Object -ExpandProperty LineNumber

            $LineNumbers | Where-Object { $result += New-Object PSObject -Property @{
                    LineNumber    = $_
                    FullName      = $item.FullName
                    FileCreated   = $item.CreationTime
                    LastWriteTime = $item.LastWriteTime
                    FileName      = $item.Name
                    Line          = Get-Content $item.FullName | Select-Object -Index ($_ - 1)                    
                } }
        }
        $currentFileCount++
        $percentComplete = [math]::Round(($currentFileCount * 100) / $FileCount)
        Write-Progress -Activity "Search in Progress" -Status "$percentComplete% Complete:" -PercentComplete $percentComplete 
    }
    Write-Output $result
}

function Watch-Ping {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Hostname,

        [int]$Duration = 0
    )

    $lastSuccess = $null
    $startTime = Get-Date

    while ($Duration -eq 0 -or (New-TimeSpan -Start $startTime).TotalSeconds -lt $Duration) {
        $ping = Test-Connection -ComputerName $Hostname -Count 1 -Quiet
        $ipAddress = ""

        if ($ping) {
            $lastSuccess = Get-Date
            $elapsed = 1

            try {
                $ipAddress = [System.Net.Dns]::GetHostAddresses($Hostname) | Where-Object { $_.AddressFamily -eq "InterNetwork" } | Select-Object -First 1
            } catch {
                $ipAddress = "Unknown"
            }
 
            Write-Host "`r$( ' '.PadRight(60) )`r" -NoNewline
            Write-Host "`rLast reached $elapsed sec ago (with IP $ipAddress)   " -ForegroundColor Green -NoNewline
        } else {
            if ($lastSuccess) {
                $notReached = [math]::Round((New-TimeSpan -Start $lastSuccess).TotalSeconds, 1)
                $color = if ($notReached -le 1) { "Green" } else { "Yellow" }

                try {
                    $ipAddress = [System.Net.Dns]::GetHostAddresses($Hostname) | Where-Object { $_.AddressFamily -eq "InterNetwork" } | Select-Object -First 1
                } catch {
                    $ipAddress = "Unknown"
                }

                Write-Host "`r$( ' '.PadRight(60) )`r" -NoNewline
                Write-Host "`rLast reached $notReached sec ago (with IP $ipAddress)   " -ForegroundColor $color -NoNewline
            } else {
                Write-Host "`r$( ' '.PadRight(60) )`r" -NoNewline
                Write-Host "`rNot reached yet   " -ForegroundColor Red -NoNewline
            }
        }
        Start-Sleep -Seconds 1
    }
}

function Log-TimeToRedmine {
    param (
        [int]$issueId ='',
        [int]$projectId = $defaultProjectId,
        [string]$activity = 5, # implementation
        [double]$hours = 0.5,
        [string]$action = 'done something'
    )

    $apiUrl = "http://redmineserver"
    $apiKey = ''

    $headers = @{ "X-Redmine-API-Key" = $apiKey }
    
    $timeEntry = @{ 
        hours = $hours
        activity_id = $activity
        comments = $action
    }

    if ($issueId) {
        $timeEntry["issue_id"] = $issueId
    } else {
        $timeEntry["project_id"] = $projectId
    }

    $body = @{ time_entry = $timeEntry } | ConvertTo-Json -Depth 2
    $response = Invoke-RestMethod -Uri "$apiUrl/time_entries.json" -Method Post -Headers $headers -Body $body -ContentType "application/json"
    
    return $response
}

function Close-RemoteSmbOpenFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ComputerName,

        [Parameter(Mandatory = $true)]
        [pscredential]$Credential,

        [Parameter(Mandatory = $true)]
        [int]$FileId
    )

    try {
        Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
            param ($FileId)
            Close-SmbOpenFile -FileId $FileId -Force
        } -ArgumentList $FileId

        Write-Host "Successfully closed SMB open file with ID $FileId on $ComputerName" -ForegroundColor Green
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}
