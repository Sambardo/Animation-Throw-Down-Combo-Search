$str = @" 
Games
Movies
TV
Wikis

Search

My Account
START A WIKI
 Animation Throwdown Wikia
Animation Throwdown Wikia
506
PAGES
ADD NEW PAGE
CARDS
GAMEPLAY
EVENTS
COMMUNITY
EXPLORE
FORUM
in:
Skills
Skills
EDIT
 
COMMENTS (2)
 
SHARE
The Skills

Skills are the special buffs each card has.

Card skills
icon	name	effect
Skill jab
Jab	Reduces the effects that prevent damage by X when attacking.
Skill punch
Punch	A random enemy card takes X damage.
Skill sturdy
Sturdy	Blocks X damage when directly attacked.
Skill payBack
Payback	Deals X damage to any card that directly attacks this.
Skill cripple
Cripple	Reduces attack of a random card by X for a turn.
Skill crippleAll
Crippe All	Reduces attack of all enemy cards by X for a turn.
Skill fart
Gas	If direct damage is dealt, attacked enemy card takes X additional damage at end of each turn.
Skill shield
Shield	Prevent X damage dealt to another random card. Can be specified by trait or show.
Skill shieldAll
Shield All	Prevents X damage dealt to all friendly cards. Can be specified by trait or show.
Skill boost
Boost	Card gets +X attack whenever you play a combo.
Skill recover
Recover	Gets +X max health whenever you play a combo.
Skill cheer
Cheer	Increases attack of a random friendly unit to the right of this card by X for a turn. Can be specified by trait or show.
Skill cheerAll
Cheer All	Increases attack of all friendly units to the right of this card by X for a turn. Can be specified by trait or show.
Skill heal
Heal	Restore X health to a damaged card. Can be specified by trait or show.
Skill healAll
Heal All	Restores X health to all damaged cards. Can be specified by trait or show.
Skill leech
Leech	If attacking card, heals self X after dealing attack damage.
Skill inspire
Motivate	Cards adjacent to this get +X extra attack. Can be specified by trait or show.
Skill bomb
Bomb	If attacking card, deal X damage to enemies adjacent to the one this attacks
Skill crazed
Crazed	Gain +X attack after dealing direct damage.
Skill fast
Haste	???
Skill slow
Sleep	The enemy plays their card first, but the card takes an additional turn to activate
Show Specific	Skills with the show specific symbol means that the effect applies to cards of a particular show only. (e.g. Family Guy Only, Futurama Only) Always same as the card that holds the skill.
Skill special
Trait Specific	Skills with the trait specific symbol means that the effect applies to cards of a particular trait only. (e.g. Drunk Only, Artistic Only) Always same as the card that holds the skill.
Skill hijack
Hijack	Temporarily steal at most X points of attack increase (e.g. from Motivate or Crazed) from card directly across from this card each turn.
Skill bodyguard
Bodyguard	Block X amount of damage from skills to this card and adjacent cards passively. Uses the highest Bodyguard available.
Skill give
Give	Give a random card specified skill with X value. E.g. Give a random card Punch 5.
"@

$results = [regex]::matches($str, "(?im)^skill\s+(?<skill>\w+)")
$allSkills = @()
foreach ($result in $results)
{
    $allSkills += $result.groups["skill"].value
}

$file = "$PSScriptRoot\cards_finalform.xml"
[xml]$data = get-content $file
$cards = $data.root.unit

[System.Collections.arraylist]$xmlSkills = $cards.skill.id | select -unique

$skillMap = @{}

$missingSkills = New-Object System.Collections.ArrayList

foreach($skill in $allSkills)
{
    if($skill -in $xmlSkills)
    {
        $skillMap.add($skill,$skill)
        $xmlSkills.Remove($skill)
    }
    else
    {
        $skillMap.add($skill,$null)
        $missingSkills.Add($skill) | out-null
    }
}

#$missingSkills |  sort | % {"`$skillMap[`"$_`"] = `"`""}

$skillMap["bomb"] = "shrapnel"
#$skillMap["boost"] = "invigorate" #is this right?
$skillMap["cheer"] = "rally"
$skillMap["cheerAll"] = "rallyall"
$skillMap["crazed"] = "berserk"
$skillMap["cripple"] = "weaken"
$skillMap["crippleAll"] = "weakenall"
$skillMap["fart"] = "poison"
#$skillMap["give"] = "" #is this right?
$skillMap["jab"] = "pierce"
$skillMap["payBack"] = "counter"
$skillMap["punch"] = "strike"
#$skillMap["recover"] = "outlast" #is this right?
$skillMap["shield"] = "barrier"
$skillMap["shieldAll"] = "barrierall"
$skillMap["sturdy"] = "armored"

$skillMap | Export-Clixml "$PSScriptRoot\skillMap.xml"