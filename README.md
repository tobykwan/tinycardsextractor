# Tinycards Extractor

Like many of you fellow Duolingo/Tinycards users, I'm sad to see Tinycards go.

While Duolingo has given [instructions](https://support.duolingo.com/hc/en-us/articles/360043909772) how to save our decks, the result turns out to be in its raw, computer-readable-only format, with all the decks packed in one single CSV file and all cards detailed saved in a single CSV field.  (As a system adminitrator) I've written this simple script to export each individual deck into its own CSV file.  Easy for possible import to other platforms ([Memrise](https://www.memrise.com/), for example, allows bulk edit via CSV.)

## A little warning to non-IT guys
You **SHOULD NOT** just download and run any script you find on the Internet, without fully understanding what it does.  That said, you may be here simply because you're using Duolingo/Tinycards, not because you're a seasoned programmer/system administrator (and Duolingo sure doesn't teach PowerShell :-P).  If you're not sure, ask a "tech guy" (with a complementary cup of latte ready) to help you read the script to make sure it's safe to run.  (The same goes for any other scripts you find online, in general.)

## Instruction
* Follow Duolingo's [instructions](https://support.duolingo.com/hc/en-us/articles/360043909772) to obtain your personal data, which turns out to be a single 'duolingo.zip'.
* Unzip the file to find the 'decks.csv' file, save it to your preferred folder, e.g. `c:\temp\duolingo`
* Go to this link to find the script [Get-Deck.ps1](https://github.com/tobykwan/tinycardsextractor/blob/master/Get-Deck.ps1)
* Save the Powershell script `Get-Deck.ps1` to the same folder above
* Open PowerShell (Press the 'Windows' key, type PowerShell, <Enter>)
* Go to the above folder
  
  ` cd c:\temp\duolingo`
* At this point, there are two files in the folder:

  `c:\temp\duolingo\decks.csv`

  `c:\temp\duolingo\Get-Deck.ps1`

* Run the script

  `.\Get-Deck.ps1`

* Result (for me)
  `Abstract Nouns.csv`
  `Adjectifs Pour Les Objets.csv`
  `All About Animals.csv`
  `Conjonction Française 1.csv`
  `Conjonction Française 2.csv`
  `decks.csv`
  `English Expressions and Idioms.csv`
  `French subjective verbs.csv`

## Remarks/Limitations
* Supports up to to 3 Fronts and Backs
* Images are saved as URLs
* Not much testing has been done to cover different scenarios (e.g. my cards have no double-byte characters, such as Chinese, Japanese)
* This sure also works on Mac, as you can install PowerShell6/7 on macOS

