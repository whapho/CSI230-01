cd C:\Users\max\Desktop

clear

Get-EventLog -list

$readlog = Read-host -Prompt "Please select a log to review"

Get-EventLog -LogName $readlog -Newest 3 | export-csv -NoTypeInformation -Path "C:\Users\max\Desktop\rep.csv"