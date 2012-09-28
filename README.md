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
	spellID = 172,
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', 150, 0},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})
```

To track multiple spells you just add a table of spell ids like so:

```lua
addon:Buff({
	spellID = {172, 234, 2356},
})
```

The same goes with the `spec` option:

```lua
addon:Buff({
	spec = {1, 3},
})
```

There's also a helper buff/debuff table so that you can easily target
buff/debuff groups like Mortal Wounds or Spell Power buffs. Just assign
`spellID` any of the following values:

```lua
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
	visibilityState = '[petbattle] hide; show',

	-- The spellid to track this will represent the icon if none is found.
	spellID = 469,

	-- The size of the icon.
	size = 26,

	-- The position of the icon (http://www.wowwiki.com/API_Region_SetPoint).
	position = {'CENTER', 'UIParent', 'CENTER', 150, 0},

	--Unit ID (http://www.wowwiki.com/UnitId), the unit that should be tracked.
	unit = 'player',

	-- Only show the icon if unit is found.
	validateUnit = true,

	-- Hide icon out of combat.
	hideOutOfCombat = true,

	-- Hide if the buff/debuff isn't mine.
	isMine = false,

	-- Desaturate the icon if not found.
	desaturate = true,

	-- Match only spell IDs (instead of spell names extracted for a spell ID)
	matchSpellID = false,

	-- In case you want to move the frame in-game, the size will be the MINIMUM
	-- frame size you can resize to, so adjust the size in case you need lower
	-- minimum size ingame.
	movable = true,

	-- Set the alpha values of your icons (transparency).

	-- Debuffs and Buffs
	alpha = {
		found = {
			frame = 1,
			icon = 1,
		},
		notFound = {
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
		notCooldown = {
			frame = 1,
			icon = 1,
		},
	}
}
```
