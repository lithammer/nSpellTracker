local _, addon = ...
if addon.playerClass ~= 'PRIEST' then return end

-- Vampiric Touch
addon:Debuff(34914, {
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0}
})

-- Shadow Word: Pain
addon:Debuff(589, {
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Mind Blast
addon:Cooldown(8092, {
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 0}
})
