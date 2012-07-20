if select(2, UnitClass('player')) ~= 'SHAMAN' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

addon:Debuff({
	spellid = 172, -- Corruption
	size = 36,
	pos = { a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = -150, y = 0},
	unit = 'target',
	validate_unit = true,
	hide_ooc = true,
	is_mine = true,
	desaturate = true,
	move_ingame = false,
})

addon:Debuff({
	spellid = 980, -- Agony
	pos = { a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = -150, y = -42},
	unit = 'target',
	validate_unit = true,
	hide_ooc = true,
	is_mine = true,
	move_ingame = false,
})

addon:Buff({
	spellid = 109773,
	pos = { a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = 150, y = 0},
})

addon:Cooldown({
	spellid = 6229,
})
