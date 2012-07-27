if select(2, UnitClass('player')) ~= 'WARRIOR' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

-----------------------------------------------------------------------------

addon:Debuff({
	spellID = addon.debuffs.mortalWounds, -- Mortal Wounds debuff
	position = {'CENTER', 'UIParent', 'CENTER', -150, -42},
	unit = 'target',
	hideOutOfCombat = false,
	movable = false,
	alpha = {
		found = {
			frame = 1,
			icon = 1,
		},
		notFound = {
			frame = 0.4,
			icon = 0.6,
		},
	},
})

addon:Buff({
	spellID = 6673,
	position = {'CENTER', 'UIParent', 'CENTER', 150, 0},
})

addon:Cooldown({
	spellID = 6229,
})
