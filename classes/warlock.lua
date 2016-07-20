local _, addon = ...

if addon.playerClass ~= 'WARLOCK' then return end

-- Haunt
addon:Cooldown(48181, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Grimoire: Imp
addon:Cooldown(111859, {
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0}
})

-- Unstable Affliction
addon:Debuff(30108, {
    spec = 1,
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

-- Siphon Life
addon:Debuff(63106, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -210, -84}
})

-- Immolate
addon:Debuff(348, {
    spec = 3,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})

-- Doom
addon:Debuff(603, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Burning Rush
addon:Buff(111400, {
    position = {'CENTER', 'UIParent', 'CENTER', 100, -42},
    hideOutOfCombat = false
})

-- Conflagrate
addon:Cooldown(17962, {
    spec = 3,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Backdraft
addon:Buff(117828, {
    spec = 3,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0}
})

-- Demonic Empowerment
addon:Buff(193396, {
    spec = 2,
    unit = 'pet',
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Demonic Calling
addon:Buff(205146, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', 150, 42}
})

-- Shadowflame
addon:Debuff(205181, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})

-- Demonbolt
addon:Debuff(157695, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0},
    unit = 'player'
})


-- Trinkets

-- Shards of Nothing
addon:Buff(176875, {
    position = {'CENTER', 'UIParent', 'CENTER', 150, 0}
})
