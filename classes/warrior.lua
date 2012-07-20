if select(2, UnitClass('player')) ~= 'WARRIOR' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

-----------------------------------------------------------------------------

addon:Debuff({
	spellid = addon.debuffs.mortalWounds, -- Mortal Wounds debuff
	pos = { a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = -150, y = -42},
	unit = 'target',
	hide_ooc = false,
	move_ingame = false,
	alpha = {
		found = {
			frame = 1,
			icon = 1,
		},
		not_found = {
			frame = 0.4,
			icon = 0.6,
		},
	},
})

addon:Buff({
	spellid = 6673,
	pos = { a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = 150, y = 0},
})

addon:Cooldown({
	spellid = 6229,
})
