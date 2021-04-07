# nSpellTracker

```lua
addon.cfg = {
	highlightPlayerSpells = true, -- Player spells will have a blue border
	refreshInterval = 0.1, -- How fast to scan the auras (buff/debuffs)
}

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
	spec = nil, -- you can use a table as well, like {1,3} for specs 1 and 3

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
	
	--verify if the spellID is in our spellbook
	verifySpell = true,

	-- Desaturate the icon if not found.
	desaturate = true,

	-- Match only spell IDs (instead of spell names extracted for a spell ID)
	matchSpellID = false,

	-- Set the alpha values of your icons (transparency).

	-- Debuffs and Buffs
	alpha = {
		found = {
			icon = 1,
		},
		notFound = {
			icon = 0.6,
		},
	},

	-- Cooldowns
	alpha = {
		cooldown = {
			icon = 0.6,
		},
		notCooldown = {
			icon = 1,
		},
	}
	
	-- Set the types of GLOW you want
	
	glowOverlay = {
		shineType = 'Blizzard',
		reqAlpha = 0, --required alpha level to show, default is zero
		color = {r,g,b,a}, --  Default value is {0.95, 0.95, 0.32, 1}
		frequency = 0.125, --  Default value is 0.125
	},
	glowOverlay = {
		shineType = 'PixelGlow',
		reqAlpha = 0.5, --required alpha level to show, default is zero
		color = {242, 5/255, 5/255, 1}, --  Default value is {0.95, 0.95, 0.32, 1}
		numLines = 8, --default is 8
		frequency = 0.25, -- frequency, set to negative to inverse direction of rotation. Default value is 0.25;
		lineLength = nil, --length of lines, common is 10-15. Default = nil, will set line length depending on dimensions of glow frame
		lineThickness = 2, --line thickness, default value is 1
		xOffset = 0, --- offset of glow relative to region border;
		yOffset = 0, --- offset of glow relative to region border;
		border = false,  -- set to true to create border under lines;
	},
	glowOverlay = {
		shineType = 'AutoCastGlow',
		reqAlpha = 0.5, --required alpha level to show, default is zero
		color = {242, 5/255, 5/255, 1}, --  Default value is {0.95, 0.95, 0.32, 1}
		numParticle = 8, --default is 8, number of particles to show
		frequency = 0.25, -- frequency, set to negative to inverse direction of rotation. Default value is 0.25;
		particleScale = 1, --scale of the particles, default is 1
		xOffset = 0, --- offset of glow relative to region border;
		yOffset = 0, --- offset of glow relative to region border;
	},
	glowOverlay = {
		shineType = 'ButtonGlow',
		reqAlpha = 0.5, --required alpha level to show, default is zero
		color = {242, 5/255, 5/255, 1}, --  Default value is {0.95, 0.95, 0.32, 1}
		frequency = 0.25, -- frequency, set to negative to inverse direction of rotation. Default value is 0.25;
	},
	
}
```
