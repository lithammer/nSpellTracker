local _, addon = ...
if addon.playerClass ~= 'ROGUE' then return end

-- Rupture
addon:Debuff(1943, {
	spec = {1, 3},
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Revealing Strike
addon:Debuff(84617, {
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Slice and Dice
addon:Buff(5171, {
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0}
})

-- Envenom
addon:Buff(32645, {
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -84}
})
