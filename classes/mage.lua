local _, addon = ...
if addon.playerClass ~= 'MAGE' then return end

-- Living Bomb
addon:Debuff(44457, {
    spec = 2,
    size = 50,
    position = {'CENTER', 'UIParent', 'CENTER', 0, -250}
})

-- Ignite
addon:Debuff(12654, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -50, -250}
})

-- Pyroblast
addon:Debuff(11366, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', 50, -250}
})

-- Arcane Charge
addon:Debuff(36032, {
    spec = 1,
    size = 50,
    position = {'CENTER', 'UIParent', 'CENTER', 0, -250},
    unit = 'player'
})

-- Nether Tempest
addon:Debuff(114923, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', 50, -250}
})

-- Frost Bomb
addon:Cooldown(112948, {
    spec = 3,
    size = 50,
    position = {'CENTER', 'UIParent', 'CENTER', 0, -250}
})
