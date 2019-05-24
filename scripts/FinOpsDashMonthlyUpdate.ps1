# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' porperty is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"

# Get the current month and year
$currentMonth = (Get-Date).Month
$currentYear = (Get-Date).Year

# Based on Month matchup date monthly windows as a variable to pass for dashboard tiles
switch -Regex ($currentMonth) {

    1 { $dashMonth = "Jan"; $startDate = "$currentYear-01-01"; $endDate = "$currentYear-01-31"; break }
    2 { $dashMonth = "Feb"; $startDate = "$currentYear-02-01"; $endDate = "$currentYear-02-28"; break }
    3 { $dashMonth = "Mar"; $startDate = "$currentYear-03-01"; $endDate = "$currentYear-03-31"; break }
    4 { $dashMonth = "Apr"; $startDate = "$currentYear-04-01"; $endDate = "$currentYear-04-30"; break }
    5 { $dashMonth = "May"; $startDate = "$currentYear-05-01"; $endDate = "$currentYear-05-31"; break }
    6 { $dashMonth = "Jun"; $startDate = "$currentYear-06-01"; $endDate = "$currentYear-06-30"; break }
    7 { $dashMonth = "Jul"; $startDate = "$currentYear-07-01"; $endDate = "$currentYear-07-31"; break }
    8 { $dashMonth = "Aug"; $startDate = "$currentYear-08-01"; $endDate = "$currentYear-08-31"; break }
    9 { $dashMonth = "Sep"; $startDate = "$currentYear-09-01"; $endDate = "$currentYear-09-30"; break }
    10 { $dashMonth = "Oct"; $startDate = "$currentYear-10-01"; $endDate = "$currentYear-10-31"; break }
    11 { $dashMonth = "Nov"; $startDate = "$currentYear-11-01"; $endDate = "$currentYear-11-30"; break }
    12 { $dashMonth = "Dec"; $startDate = "$currentYear-12-01"; $endDate = "$currentYear-12-31"; break }

}

$dashname = "Finacial Ops - " + $dashMonth 

# Create a Run Deployment unique name
$date = Get-Date -Format "yyyyMMddhhmmss"

#deploy Dashboard template passing in parameters
New-AzResourceGroupDeployment -Name $date -ResourceGroupName "dashboards" -Mode Incremental -TemplateUri "URI of ARM Template Here" -monthStart $startDate -monthEnd $endDate -dashboardName $dashName