local _, addon = ...

if addon.playerClass ~= 'WARLOCK' then return end

-- Haunt
addon:Debuff(48181, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Unstable Affliction
addon:Debuff(30108, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})

-- Immolate
addon:Debuff(348, {
    spec = 3,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})

-- Corruption
addon:Debuff(172, {
    spec = {1, 2},
    position = {'CENTER', 'UIParent', 'CENTER', -210, 0}
})

-- Agony
addon:Debuff(980, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Shadowflame
addon:Debuff(47960, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Doom
addon:Debuff(603, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Backdraft
addon:Buff(117896, {
    spec = 3,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0}
})

-- Burning Rush
addon:Buff(111400, {
    position = {'CENTER', 'UIParent', 'CENTER', 100, -42},
    hideOutOfCombat = false
})

-- Dark Soul: Misery
addon:Cooldown(113860, {
    position = {'CENTER', 'UIParent', 'CENTER', -294, 42},
    spec = 1,
})

-- Dark Soul: Knowledge
addon:Cooldown(113861, {
    position = {'CENTER', 'UIParent', 'CENTER', -294, 42},
    spec = 2
})

-- Dark Soul: Instability
addon:Cooldown(113858, {
    position = {'CENTER', 'UIParent', 'CENTER', -294, 42},
    spec = 3
})

-- Grimoire: Felguard
addon:Cooldown(111898, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -294, 0}
})

-- Conflagrate
addon:Cooldown(17962, {
    spec = 3,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Hand of Gul'dan
addon:Cooldown(105174, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})

-- Wrathstorm, Felstorm
addon:Cooldown({119914, 119915}, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 84}
})
