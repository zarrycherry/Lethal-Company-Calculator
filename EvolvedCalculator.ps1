# Powershell script to calculate OT for Lethal Company
# made by zarrycherry

try {
    $continue = $true
    while($continue)
    {
        Write-Host -ForeGroundcolor DarkGreen 
        "Main Menu: 
        
Enter 1: 
Calculates the Overtime bonus and credit amount 
that needs to be sold to achieve the players chosen total

Enter 2: 
Exits the program"

        $choice = Read-Host "Enter your choice"
        switch ($choice) {
            1 {
                # Prompts user input for the total credit amount he'd like to achieve including OT bonus and current quota and stores
                # the results in their respective variables
                
                $creditsNeeded = Read-Host "Enter the total credit amount you need "
                $quota = Read-Host "Enter the current quota "
                
                # evaluates whether the string input value contains any numbers between 0-9, 
                # with ^ checking the beginning of the string and until the end, + indicates multiple values
                if ($creditsNeeded -match '^[0-9]+$') 
                {
                    if ($quota -match '^[0-9]+$')
                    {
                        # calculates amount needed to be sold
                        $itemsToSell = ([float]$creditsNeeded * 5 + [float]$quota + 75) / 6
                        # Formula to calculate OT bonus itemsSold subracted by quota divided by 5 and substracted by 15 
                        $OT = ([float]$itemsToSell - [float]$quota) / 5 - 15
        
                        # conditional statement checks whether the OT bonus is above 0
                        # if it is less than 0 or equal to 0 the player is informed that he 
                        # wont receive an OT bonus
                        if ([float]$OT -le 0)
                        {
                            Write-Host -ForegroundColor DarkRed "No Overtime Bonus received"
                            $continue = $false
                        } else {
                            $OT = [math]::Round($OT,2)
                            # informs user how much credits the OT bonus is
                            Write-Host -ForegroundColor DarkGreen "The calculated OT bonus is: $OT credits"
                            
                            $itemsToSell = [math]::Ceiling($itemsToSell)
                            # informs user to sell the rounded value of $creditsNeeded
                            Write-Host -ForegroundColor DarkGreen "Scrap amount to be sold $itemsToSell credits"
                            $continue = $false
                        }
                    } else {
                            Write-Host -ForegroundColor DarkRed "Wrong input, ensure input only contains positive integers. Try again."
                    }   
                } else {
                    Write-Host -ForegroundColor DarkRed "Wrong input, ensure input only contains positive integers. Try again."
                }}
            2 {$continue = $false}
            Default {Write-Host "Wrong input, please select 1 or 2"}
        }

    } 
}
catch {
    Write-Host  -ForegroundColor DarkRed "Error: $($PSItem.ToString())"
    Write-Host "$($PSItem.ScriptStackTrace)"
}

