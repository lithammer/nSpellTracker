
# rFilter3

```lua
-- Player spells will have a blue border
highlightPlayerSpells = true

-- How fast should the timer update itself
updatetime = 0.1
```

## Example

To add a debuff, buff or cooldown to track just open the class specific config
file under the `classes` folder and add one of the following: `addon:Debuff(...)`
`addon:Buff(...)` `addon:Cooldown(...)`, where `...` is a table containing
various settings. Here's an example for tracking Corruption:

```lua
addon:Debuff({
	spellid = 172,
	size = 36,
	pos = { a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = -150, y = 0},
	unit = 'target',
	validate_unit = true,
	hide_ooc = true,
	is_mine = true,
	desaturate = true,
	move_ingame = false,
})
```

## Settings

Field | Values | Description
-------- | -------- | 
spellid (required) | int or {int, int, ...} | The spellid to track this will represent the icon if none is found
spec   | nil, 1, 2 or 3 | The talent tree you want to track the spell (nil will make it work in any tree)
visibility_state   | "[combat] show; hide" | Attribute that lets you show/hide the frame on a given state condition. example: "[stance:2] show; hide"
size | int | The size of the icon
pos | table | The position of the icon ([www.wowwiki.com/API_Region_SetPoint](http://www.wowwiki.com/API_Region_SetPoint))
unit | 'player' | UnitID ([www.wowwiki.com/UnitId](http://www.wowwiki.com/UnitId)), the unit that should be tracked
validate_unit | true/false | Only show the icon if unit is found
hide_ooc | true/false | Hide icon out of combat
ismine | true/false | Track if the spell casted is actually MY spell (hide same buffs/debuffs from other players)
desaturate | true/false | Desaturate the icon if not found
match_spellid | true/false (optional) | In case you not only match the name but the spell id of the buff/debuff
move_ingame | true/false (optional) | In case you want to move the frame ingame, the size will be the MINIMUM frame size you can resize to, so adjust the size in case you need lower minimum size ingame
alpha | {found={frame=1, icon=1}, not_found={frame=0.4, icon=0.6}} | Set the alpha values of your icons (transparency)
alpha | {cooldown={frame=1, icon=1}, no_cooldown={frame=0.4, icon=0.6}} | Set the alpha values of your icons (transparency)
