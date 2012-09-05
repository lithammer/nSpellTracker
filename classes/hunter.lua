if select(2, UnitClass('player')) ~= 'HUNTER' then return end

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
	spellID = 1978, -- Serpent Sting
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0},
	isMine = true,
	unit = 'target',
	validateUnit = true,
	movable = false,
})

addon:Debuff({
	spellID = 53301, -- Explosive Shot
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -252, -42},
	isMine = true,
	unit = 'target',
	validateUnit = true,
	movable = false,
	alpha = {
		notFound = {
			frame = 0,
			icon = 0
		}
	}
})

addon:Cooldown({
	spellID = 34026, -- Kill Command
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	movable = false,
})

addon:Cooldown({
	spellID = 53209, -- Chimera Shot
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	movable = false,
})

addon:Cooldown({
	spellID = 53301, -- Explosive Shot
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	movable = false,
})

addon:Cooldown({
	spellID = 3674, -- Black Arrow
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 42},
	movable = false,
})
