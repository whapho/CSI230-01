do {
    Write-Host "Menu:"
    Write-Host "[1] List All Services"
    Write-Host "[2] List Running Services"
    Write-Host "[3] List Stopped Services"
    Write-Host "[4] Exit"
    
    $choice = Read-Host "Enter your choice (1-4)"

    switch ($choice) {
        "1" {
            Get-Service
            Read-Host "Press Enter to continue..."
        }
        "2" {
            Get-Service | Where-Object { $_.Status -eq 'Running' }
            Read-Host "Press Enter to continue..."
        }
        "3" {
            Get-Service | Where-Object { $_.Status -eq 'Stopped' }
            Read-Host "Press Enter to continue..."
        }
        "4" {
            Write-Host "Exiting the menu."
            break
        }
        default {
            Write-Host "Invalid choice. Please enter a valid option (1-4)."
            Read-Host "Press Enter to continue..."
        }
    }
} until ($choice -eq '4')