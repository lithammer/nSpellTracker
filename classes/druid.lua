if select(2, UnitClass('player')) ~= 'DRUID' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

addon:Debuff({
	spellID = {8921, 93402}, -- Moonfire & Sunfire
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Cooldown({
	spellID = 78674, -- Starsurge
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0},
	hideOutOfCombat = true,
	desaturate = true,
	movable = false,
})

addon:Cooldown({
	spellID = 48505, -- Starfall
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 0},
	hideOutOfCombat = true,
	desaturate = true,
	movable = false,
})
