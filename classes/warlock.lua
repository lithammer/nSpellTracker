if select(2, UnitClass('player')) ~= 'WARLOCK' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

--[ Debuffs ]----------------------------------------------------------------

addon:Debuff({
	spellID = 48181, -- Haunt
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 42},
	unit = 'target',
	movable = false,
})

addon:Debuff({
	spellID = 30108, -- Unstable Affliction
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 42},
	unit = 'target',
	movable = false,
})

addon:Debuff({
	spellID = 348, -- Immolate
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 42},
	unit = 'target',
	movable = true,
})

addon:Debuff({
	spellID = 172, -- Corruption
	spec = {1, 2},
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0},
	unit = 'target',
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 980, -- Agony
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	unit = 'target',
	movable = false,
})

addon:Debuff({
	spellID = 47960, -- Shadowflame
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 42},
	unit = 'target',
	movable = false,
})

addon:Debuff({
	spellID = 603, -- Doom
	spec = 2,
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	unit = 'target',
	desaturate = true,
	movable = false,
	alpha = {
		notFound = {
			frame = 0,
			icon = 0,
		}
	},
})

addon:Debuff({
	spellID = addon.debuffs.magicVulnerability,
	position = {'BOTTOM', 'UIParent', 'BOTTOM', 0, 210},
	unit = 'target',
})

--[ Buffs ]------------------------------------------------------------------

--[[
addon:Buff({
	spellID = addon.buffs.spellPower,
	position = {'CENTER', 'UIParent', 'CENTER', 210, 0},
})
]]--

addon:Buff({
	spellID = 117896,
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 0},
})

--[ Cooldowns ]--------------------------------------------------------------

addon:Cooldown({
	spellID = 17962, -- Conflagrate
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 42},
	movable = false,
})

addon:Cooldown({
	spellID = 105174, -- Hand of Gul'dan
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 42},
	movable = false,
})
