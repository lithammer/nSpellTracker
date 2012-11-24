if select(2, UnitClass('player')) ~= 'MAGE' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

addon:Debuff({
	spellID = 44457, -- Living Bomb
	spec = 2,
	size = 50,
	unit = 'target',
	position = {'CENTER', 'UIParent', 'CENTER', 0, -250},
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 12654, -- Ignite
	spec = 2,
	size = 36,
	unit = 'target',
	position = {'CENTER', 'UIParent', 'CENTER', -50, -250},
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 11366, -- Pyroblast
	spec = 2,
	size = 36,
	unit = 'target',
	position = {'CENTER', 'UIParent', 'CENTER', 50, -250},
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 36032, -- Arcane Charge
	spec = 1,
	size = 50,
	position = {'CENTER', 'UIParent', 'CENTER', 0, -250},
	unit = 'player',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 114923, -- Nether Tempest
	spec = 1,
	size = 36,
	unit = 'target',
	position = {'CENTER', 'UIParent', 'CENTER', 50, -250},
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 112948, -- Frost Bomb
	spec = 3,
	size = 50,
	unit = 'target',
	position = {'CENTER', 'UIParent', 'CENTER', 0, -250},
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})
