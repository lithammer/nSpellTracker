if select(2, UnitClass('player')) ~= 'ROGUE' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

addon:Debuff({
	spellID = 1943, -- Rupture
	spec = {1, 3},
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
	spellID = 84617, -- Revealing Strike
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	unit = 'target',
	hideOutOfCombat = true,
	movable = false,
})

addon:Buff({
	spellID = 5171, -- Slice and Dice
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0},
	hideOutOfCombat = true,
	movable = false,
})

addon:Buff({
	spellID = 32645, -- Envenom
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -84},
	hideOutOfCombat = true,
	movable = false,
})
