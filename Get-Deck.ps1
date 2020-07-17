param(
    [System.IO.FileInfo]
    $RawDeckFilename="decks.csv"
)
<#
    .SYNOPSIS
    TinyCards Deck Extractor
#>
function Get-DeckText  {
    param(
        [String]
        $RawText
    )
    if ( $rawText -match "\.*\[image\]\((?<imageUrl>.*)\)")  {
        # Extract the image URL
        $Matches["imageUrl"]
    }
    else  {
        # Just chop off the leading '* '
        $rawText.Substring(2,$rawText.Length-2)
    }
}

$rawDecks = Import-Csv $RawDeckFilename
Write-Host ("{0} decks found ... " -f $rawDecks.Count)
for ( $i = 0; $i -lt $rawDecks.Count; $i++ )  {
    $rawDeck = $rawDecks[$i]
    $deckName = $rawDeck.name
    Write-Host ("Processing deck {0} of {1} titled {2} ... " -f $i, $rawDecks.Count, $deckName)
    $outputFilename = "{0}.csv" -f $rawDeck.name
    # Split jumbled card texts into lines
    $cardLines = $rawDeck.cards -split '\r\n'
    # Initialize cards for this deck
    $cards = @()

    # For each line in the deck text
    for ($j = 0; $j -lt $cardLines.Count; $j++)  {
        # Save the card when reaching a '### Card' line
        if ( $cardLines[$j] -like '### Card*' )  {
            $frontTexts = @()
            $backTexts = @()
            # Note that $currentLineNumber is 0-based
            $currentLineNumber = $j+1
            $currentLine = $cardLines[$currentLineNumber]
            while ( ($currentLineNumber -lt $cardLines.Count) -and ($currentLine -notlike '### Card*') )  {
                if ($currentLine -eq "Front")  {
                    # Get the next line
                    $rawText = $cardLines[$currentLineNumber+1]
                    $frontText = Get-DeckText -RawText $rawText
                    $frontTexts += $frontText
                }
                elseif ($currentLine -eq "Back")  {
                    # Get the next line
                    $rawText = $cardLines[$currentLineNumber+1]
                    $backText = Get-DeckText -RawText $rawText
                    $backTexts += $backText
                }
                $currentLineNumber++
                if ( $currentLineNumber -lt $cardLines.Count )  {
                    $currentLine = $cardLines[$currentLineNumber]
                }
                else  {
                    # End of card lines reached
                    $currentLine = $null
                }
            }
            $card = [PSCustomObject]@{
                front1 = $null
                front2 = $null
                front3 = $null
                back1 = $null
                back2 = $null
                back3 = $null
            }
            for ( $k = 1; $k -le 3; $k++)  {
                $property = "front$k"
                $card.$property = $frontTexts[$k-1]
                $property = "back$k"
                $card.$property = $backTexts[$k-1]
            }
            $cards += $card
        }
        continue
    }
    Write-Host ("Saving {0} cards to file '{1}' ..." -f $cards.Count, $outputFilename)
    $cards | Export-Csv -Path $outputFilename -NoTypeInformation
}
Write-Host
Write-Host ("==========================")
Write-Host ("End of script; bye Cardlo!")
Write-Host ("==========================")
