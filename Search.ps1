function SearchSkills
{
    param(
    [switch]$shield,
    [switch]$heal,
    [switch]$cheerAll,
    [switch]$payBack,
    [switch]$fart,
    [switch]$punch,
    [switch]$bodyguard,
    [switch]$bomb,
    [switch]$jab,
    [switch]$cheer,
    [switch]$shieldAll,
    [switch]$hijack,
    [switch]$inspire,
    [switch]$crippleAll,
    [switch]$sturdy,
    [switch]$leech,
    [switch]$cripple,
    [switch]$healAll,
    [switch]$crazed
    )


    $file = "$PSScriptRoot\cards_finalform.xml"
    [xml]$data = get-content $file
    $cards = $data.root.unit

    $SkillMap = Import-Clixml "$PSScriptRoot\skillmap.xml"

    $skillSearch = @()

    foreach($param in $PSBoundParameters.Keys)
    {
        $skillSearch += $SkillMap["$param"]
    }

    foreach($card in $cards)
    {
        $match = $true
        $skills = $card.upgrade.skill.id | select -Unique
        foreach ($skill in $skillSearch)
        {
            if($skill -notin $skills)
            {
               $match = $false
               break
            }
        }
        if($match)
        {
            $card.name
        }
    }
}

SearchSkills -leech -crazed