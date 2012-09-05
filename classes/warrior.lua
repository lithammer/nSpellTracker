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
