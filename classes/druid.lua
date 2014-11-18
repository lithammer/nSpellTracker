local _, addon = ...
if addon.playerClass ~= 'DRUID' then return end

-- Moonfire
addon:Debuff(164812, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 0}
})

-- Sunfire
addon:Debuff(164815, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Starsurge
addon:Cooldown(78674, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0}
})

-- Starfall
addon:Cooldown(48505, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -252, -42}
})
