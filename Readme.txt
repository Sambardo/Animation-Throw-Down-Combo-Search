I made this because I couldn't find an existing site to search for specific traits on combos. 
I grabbed the xml data from the data mining on reddit, so it might be out dated. 
Its pretty sloppy and thrown together, but if its used I can cleanup issues and such later. 

Files:
* Search.ps1 has a function that lets you look for combos with specific traits via switch params. 
Then I use https://cartoon-battle.cards/recipes to find the recepies for them. 

* Allskills.ps1 and the xml files were used to generate the skill maps from the XML to the in-game names. 

Note: Some of the skills might not be mapped correctly, but a few quick tests has it working. 

HowTo: easiest way if you don't know PowerShell is to
1. open Search.PS1 in the ISE
2. Scroll to the bottom with "SearchSkills -leech -crazed" and just change the flags for what you want like "SearchSkills -leech -healall"
