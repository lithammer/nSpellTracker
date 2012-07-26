if select(2, UnitClass('player')) ~= 'PRIEST' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

addon:Debuff({
	spellID = 34914, -- Vampiric Touch
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 589, -- Shadow Word: Pain
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
	spellID = 2944, -- Devouring Plague
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -84},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Cooldown({
	spellID = 8092, -- Mind Blast
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 0},
	hideOutOfCombat = true,
	desaturate = true,
	movable = false,
})
