if select(2, UnitClass('player')) ~= 'DRUID' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

addon:Debuff({
	spellID = {8921, 93402}, -- Moonfire & Sunfire
	spec = 1,
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 1822, -- Rake
	spec = 2,
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 1079, -- Rip
	spec = 2,
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Buff({
	spellID = 52610, -- Savage Roar
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 42},
	hideOutOfCombat = true,
	movable = false,
})

addon:Cooldown({
	spellID = 78674, -- Starsurge
	spec = 1,
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0},
	hideOutOfCombat = true,
	desaturate = true,
	movable = false,
})

addon:Cooldown({
	spellID = 48505, -- Starfall
	spec = 1,
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 0},
	hideOutOfCombat = true,
	desaturate = true,
	movable = false,
})
