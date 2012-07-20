if select(2, UnitClass('player')) ~= 'WARLOCK' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

--[ Debuffs ]----------------------------------------------------------------

addon:Debuff({
	spellid = 30108, -- Unstable Affliction
	spec = 1,
	pos = {a1 = 'CENTER', a3 = 'CENTER', af = 'UIParent', x = -150, y = 42},
	unit = 'target',
	is_mine = true,
	move_ingame = false,
})

addon:Debuff({
	spellid = 348, -- Immolate
	pos = {a1 = 'CENTER', a3 = 'CENTER', af = 'UIParent', x = -150, y = 42},
	unit = 'target',
	is_mine = true,
	move_ingame = true,
})

addon:Debuff({
	spellid = 172, -- Corruption
	spec = {1, 2},
	size = 36,
	pos = {a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = -150, y = 0},
	unit = 'target',
	validate_unit = true,
	is_mine = true,
	desaturate = true,
	move_ingame = false,
})

addon:Debuff({
	spellid = 980, -- Agony
	spec = 1,
	pos = {a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = -150, y = -42},
	unit = 'target',
	validate_unit = true,
	is_mine = true,
	move_ingame = false,
})

addon:Debuff({
	spellid = addon.debuffs.magicVulnerability,
	pos = {a1 = 'BOTTOM', a2 = 'BOTTOM', af = 'UIParent', x = 0, y = 200},
	unit = 'target',
})

--[ Buffs ]------------------------------------------------------------------

--[[
addon:Buff({
	spellid = addon.buffs.spellPower,
	pos = {a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = 150, y = 0},
})
]]--

--[ Cooldowns ]--------------------------------------------------------------

addon:Cooldown({
	spellid = 17962, -- Conflagrate
	spec = 3,
	pos = {a1 = 'CENTER', a3 = 'CENTER', af = 'UIParent', x = -192, y = 42},
	move_ingame = false,
	hide_ooc = true,
})
