if select(2, UnitClass('player')) ~= 'WARRIOR' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

--[[
Default values:

spec = nil,
spellID = nil,
size = 36,
position = {'CENTER'},
unit = 'player',
visibilityState = nil,
validateUnit = true,
hideOutOfCombat = true,
isMine = true,
desaturate = true,
matchSpellID = true,
movable = true,
alpha = {
	found = {
		frame = 1,
		icon = 1,
	},
	notFound = {
		frame = 0.4,
		icon = 0.6,
	},
	cooldown = {
		frame = 1,
		icon = 0.6,
	},
	notCooldown = {
		frame = 1,
		icon = 1,
	},
},
]]--

addon:Debuff({
	spellID = addon.debuffs.weakenedArmor, -- Mortal Wounds debuff
	position = {'CENTER', 'UIParent', 'CENTER', -52, -250},
	spec = 3,
	unit = 'target',
	hideOutOfCombat = true,
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
	spellID = 132404, -- Shield Block
	position = {'CENTER', 'UIParent', 'CENTER', 0, -250},
	spec = 3,
	size = 52,
	movable = false,
})
