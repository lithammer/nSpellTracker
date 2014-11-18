local _, addon = ...
if addon.playerClass ~= 'HUNTER' then return end

-- Explosive Shot
addon:Debuff(53301, {
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -252, -42}
})

-- Kill Command
addon:Cooldown(34026, {
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Chimera Shot
addon:Cooldown(53209, {
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Explosive Shot
addon:Cooldown(53301, {
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Black Arrow
addon:Cooldown(3674, {
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})
