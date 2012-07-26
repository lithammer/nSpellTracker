if select(2, UnitClass('player')) ~= 'PALADIN' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

addon:Debuff({
	spellID = 172, -- Corruption
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -150, 0},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 980, -- Agony
	position = {'CENTER', 'UIParent', 'CENTER', -150, -42},
	unit = 'target',
	validateUnit = true,
	hideOutOfCombat = true,
	isMine = true,
	movable = false,
})

addon:Buff({
	spellID = 109773,
	position = {'CENTER', 'UIParent', 'CENTER', 150, 0},
})

addon:Cooldown({
	spellID = 6229,
})
