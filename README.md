# nSpellTracker

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

To track multiple spells you just add a table of spell ids like so:

```lua
addon:Buff({
	spellid = {172, 234, 2356},
})
```

There's also a helper buff/debuff table so that you can easily target
buff/debuff groups like Mortal Wounds or Spell Power buffs. Just assign
`spellid` any of the following values:

```
-- Buffs
addon.buffs.stats
addon.buffs.stamina
addon.buffs.attackPower
addon.buffs.spellPower
addon.buffs.haste
addon.buffs.spellHaste
addon.buffs.criticalStrike
addon.buffs.master

-- Debuffs
addon.debuffs.weakenedArmor
addon.debuffs.physicalVulnerability
addon.debuffs.magicVulnerability
addon.debuffs.weakenedBlows
addon.debuffs.slowCasting
addon.debuffs.mortalWounds
```

## Settings

```lua
{
	-- The talent tree you want to track the spell (nil will make it work in
	-- any tree).
	spec = nil,

	-- Attribute that lets you show/hide the frame on a given state condition.
	-- example: '[stance:2] show; hide'
	visibility_state = '[combat] show; hide',

	-- The spellid to track this will represent the icon if none is found.
	spellid = 469,

	-- The size of the icon.
	size = 26,

	-- The position of the icon (http://www.wowwiki.com/API_Region_SetPoint).
	pos  = {
		a1 = 'BOTTOM',
		a2 = 'BOTTOM',
		af = 'UIParent',
		x = 130,
		y = 107
	},

	--Unit ID (http://www.wowwiki.com/UnitId), the unit that should be tracked.
	unit = 'player',

	-- Only show the icon if unit is found.
	validate_unit = true,

	-- Hide icon out of combat.
	hide_ooc = true,

	-- Hide if the buff/debuff isn't mine.
	is_mine = false,

	-- Desaturate the icon if not found.
	desaturate = true,

	-- In case you not only match the name but the spell id of the buff/debuff.
	match_spellid = false,

	-- In case you want to move the frame ingame, the size will be the MINIMUM
	-- frame size you can resize to, so adjust the size in case you need lower
	-- minimum size ingame.
	move_ingame = true,

	-- Set the alpha values of your icons (transparency).

	-- Debuffs and Buffs
	alpha = {
		found = {
			frame = 1,
			icon = 1,
		},
		not_found = {
			frame = 0.4,
			icon = 0.6,
		},
	},


	-- Cooldowns
	alpha = {
		cooldown = {
			frame = 1,
			icon = 0.6,
		},
		no_cooldown = {
			frame = 1,
			icon = 1,
		},
	}
}
```
