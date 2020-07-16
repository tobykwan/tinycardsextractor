param(
    [System.IO.FileInfo]
    $RawDeckFilename="decks.csv"
)
<#
    .SYNOPSIS
    TinyCards Deck Extractor
#>
$rawDecks = Import-Csv $RawDeckFilename
Write-Host ("{0} decks found ... " -f $rawDecks.Count)
for ( $i = 0; $i -lt $rawDecks.Count; $i++ )  {
    $rawDeck = $rawDecks[$i]
    $deckName = $rawDeck.name
    Write-Host ("Processing deck {0} of {1} titled {2} ... " -f $i, $rawDecks.Count, $deckName)
    $outputFilename = "{0}.csv" -f $rawDeck.name
    # Split jumbled card texts into lines
    $cardLines = $rawDeck[0].cards -split '\r\n'
    # Initialize cards for this deck
    $cards = @()

    # For each line in the deck text
    for ($j = 0; $j -lt $cardLines.Count; $j++)  {
        # Save the card when reaching a '### Card' line
        if ( $cardLines[$j] -like '### Card*' )  {
            $frontText = $cardLines[$j+2]
            $backText = $cardLines[$j+5]
            # Remove the leading '* '
            $cards += [PSCustomObject]@{
                Front = $frontText.Substring(2,$frontText.Length-2)
                Back = $backText.Substring(2,$backText.Length-2)
            }
        }
        # All other lines are skipped
        continue
    }
    Write-Host ("Saving {0} cards to file '{1}' ..." -f $cards.Count, $outputFilename)
    $cards | Export-Csv -Path $outputFilename -NoTypeInformation
}
Write-Host
Write-Host ("==========================")
Write-Host ("End of script; bye Cardlo!")
Write-Host ("==========================")