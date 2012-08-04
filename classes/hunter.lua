if select(2, UnitClass('player')) ~= 'HUNTER' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

addon:Debuff({
	spellID = 1978,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0}
	isMine = true,
	unit = 'target',
	validateUnit = true,
	movable = false,
})
