<#
.Synopsis
   Script to create junctions between directories.

.DESCRIPTION
   This script is used to create junctions between directories.
   It is assumed that a lot of Arma3 groups use the same mods or at least have 
   a certain overlap regarding their modset.
   
   In order to prevent loading the same mods multiple times links (so called 
   junctions) between folders can be created such that multiple modset folders 
   can share the same files that are on your disk.

   Imagine the mod @rhsusaf is used by your primary group and a lot of other 
   groups you sometimes play with.
   Also imagine that you usually separate modset of different groups in 
   different folders (e.g. c:\a3_mods\group_A\ and c:\a3_mods\group_B\).
   Then you can download @rhsusaf just once and use it either modset folder.

.EXAMPLE
   There are no parameters supported as of now.

   Open the script in a text editor in order to see what you can/need 
   to configure. 
#>

# Set path to your main mod folder here
$MainModsFolder = "F:\Games\Steam\Arma 3\Mods\GruppeAdler"
if (-not (Test-Path -Path $MainModsFolder) )
{
    throw '"{0}" does not exist.' -f $MainModsFolder
}

# Set path to your maps mod folder here
$MapsModsFolder = "F:\Games\Steam\Arma 3\Mods\Maps"
if (-not (Test-Path -Path $MapsModsFolder) )
{
    throw '"{0}" does not exist.' -f $MapsModsFolder
}

# list of junctions for different Arma3 groups
$RollingThunder_JunctionList = `
"@cup_terrains_core", `
"@Gruppe Adler Admin Messages", `
"@rosche"

$3CB_JunctionList = `
#"@3cb_factions", `
"@3cb_baf_equipment", `
"@3cb_baf_vehicles", `
"@3cb_baf_weapons", `
#"@ace", `
"@cup_terrains_core", `
"@cup_terrains_maps", `
"@diwako_dui", `
"@lythium", `
"@rhsafrf", `
"@rhsgref", `
"@rhssaf", `
"@rhsusaf", `
#"@TFAR", `
"@anizay", `
"@gunkizli", `
"@hellanmaa", `
"@kujari", `
"@Leskovets", `
"@rosche", `
"@ruha", `
"@pulau", `
#"@kujari", `
"@virolahti", `
"@vinjesvingen"

$AFI_JunctionList = `
"@3cb_factions", `
"@cba_a3", `
"@cup_terrains_core", `
#"@grad_trenches", `
#"@lambs_danger", `
#"@lambs_suppression", `
"@vet_unflipping", `
#"@ruha", `
#"@zen", `
#"@zen_compat_ace", `
"@rhs_afrf3", `
"@rhs_gref", `
"@rhs_saf", `
"@rhs_usf3"

$TTT_JunctionList = `
"@3CB_Factions", `
"@ace", `
"@ace_nouniformrestrictions", `
"@backpackonchest", `
"@cba_a3", `
"@lambs_suppression", `
"@lythium", `
"@rhsafrf", `
"@rhsgref", `
"@rhspkl", `
"@rhssaf", `
"@rhsusaf", `
"@suppress"

$DAA_JunctionList = `
"@3CB_Factions", `
"@rhspkl", `
"@rhsafrf", `
"@rhsgref", `
"@rhssaf", `
"@rhsusaf", `
"@ace_compat-rhsafrf", `
"@ace_compat-rhsgref", `
"@ace_compat-rhssaf", `
"@ace_compat-rhsusaf", `
"@cup_terrains-core", `
"@cup_terrains-maps", `
"@vet_unflipping", `
"@splendid_smoke", `
"@enhanced_movement", `
"@Enhanced_Movement_Rework", `
"@advanced_towing", `
"@advanced_sling_loading", `
"@backpackonchest", `
"@cba_a3", `
"@dui-squad_radar", `
"@task_force_arrowhead_radio_beta", `
# "@grad_sling_helmet", `
# "@gruppe_adler_trenches", `
"@ILBE_Assault_Pack-Rewrite", `
"@virolahti-valtatie_7", `
"@TacControl", `
"@zeus_enhanced", `
"@zeus_enhanced-ace3_compatibility"


# select which list you actually want to apply here
#$JunctionList = $3CB_JunctionList
$JunctionList = Get-ChildItem -Path $MapsModsFolder | select -Property Name


foreach ($DirectoryJunction in $JunctionList)
{
    if ($DirectoryJunction.PSobject.Properties.name -match "Name")
    {   # remove Name property if it exists (we don't want a hashtable but plain strings)
        $DirectoryJunction = $DirectoryJunction.Name
    }
    if (Test-Path -Path $DirectoryJunction) 
    {
        Write-Host "Keeping already existing junction for:", $DirectoryJunction -ForegroundColor Red
    }
    else
    {
        Write-Host "Creating junction for:", $DirectoryJunction -ForegroundColor Green
        #New-Item -Path $DirectoryJunction -ItemType Junction -Value $MainModsFolder\$DirectoryJunction
        New-Item -Path $DirectoryJunction -ItemType Junction -Value $MapsModsFolder\$DirectoryJunction
    }
}
