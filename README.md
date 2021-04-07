# nSpellTracker

```lua
addon.cfg = {
	highlightPlayerSpells = true, -- Player spells will have a blue border
	refreshInterval = 0.1, -- How fast to scan the auras (buff/debuffs)
}
```

## Example

To add a debuff, buff or cooldown to track just open the class specific config
file under the `classes` folder and add one of the following: `addon:Debuff(...)`
`addon:Buff(...)` `addon:Cooldown(...)`, where `...` is a table containing
various settings. Here's an example for tracking Corruption:

The rootSpellID is the primary spellID that will be used for not only the Icon's texture but to compare it with other spellID's.
The rootSpellID is REQUIRED.

```lua
addon:Debuff(rootSpellID, {
	spellID = 172,
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', 150, 0},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
})
```

To track multiple spells you just add a table of spell ids like so:

```lua
addon:Buff(rootSpellID, {
	spellID = {172, 234, 2356},
})
```

The same goes with the `spec` option:

```lua
addon:Buff(rootSpellID, {
	spec = {1, 3},
})
```

NOTE: Please note that the buff/debuff duration will be grabbed from the first spellID that matches, if a spellID table is used.  So it may not match exactly with the duration for the rootSpellID.


## Settings

```lua
{
	-- The talent tree you want to track the spell (nil will make it work in
	-- any tree).  
	spec = nil, -- you can use a table as well, like {1,3} for specs 1 and 3

	-- Attribute that lets you show/hide the frame on a given state condition.
	-- example: '[stance:2] show; hide'
	visibilityState = '[petbattle] hide; show',

	-- The spellid to track this will represent the icon to be used.  If no spellID is given then the rootSpellID is used.
	spellID = 469, -- a table can be used as well {12345, 435, 2586674} the first spellID that matches will be used. 
	spellID = {12345, 435, 2586674}, -- a table can be used as well, the first spellID that matches will be used. This table will always include the rootSpellID.
	
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

	-- Set the alpha values of your icons (transparency).
	
	-- Debuffs and Buffs
	alpha = {
		found = {
			icon = 1, --buff/debuff was found
		},
		notFound = {
			icon = 0.6, --buff/debuff was not found
		},
	},

	-- Cooldowns
	alpha = {
		cooldown = {
			icon = 0.6, --spell on cooldown
		},
		notCooldown = {
			icon = 1, --spell not on cooldown
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
