local _, addon = ...

if addon.playerClass ~= 'WARLOCK' then return end

local affliction, demonology, destruction = 1, 2, 3

    -- Affliction

-- Haunt
addon:Cooldown(48181, {
    spec = affliction,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Grimoire: Felhunter
addon:Cooldown(111897, {
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0}
})

-- Unstable Affliction
addon:Debuff(30108, {
    spec = affliction,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})

-- Corruption
addon:Debuff(172, {
    spec = affliction,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 0}
})

-- Agony
addon:Debuff(980, {
    spec = affliction,
    position = {'CENTER', 'UIParent', 'CENTER', -210, -42}
})

-- Siphon Life
addon:Debuff(63106, {
    spec = affliction,
    position = {'CENTER', 'UIParent', 'CENTER', -210, -84}
})

    -- Destruction

-- Immolate
addon:Debuff(348, {
    spec = destruction,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})

-- Burning Rush
addon:Buff(111400, {
    position = {'CENTER', 'UIParent', 'CENTER', 100, -42},
    verifySpell = true,
    hideOutOfCombat = false
})

-- Conflagrate
addon:Cooldown(17962, {
    spec = destruction,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Backdraft
addon:Buff(117828, {
    spec = destruction,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0},
    verifySpell = true
})

-- Mana Tap
addon:Buff(196104, {
    spec = destruction,
    position = {'CENTER', 'UIParent', 'CENTER', 100, 42},
    verifySpell = true
})

    -- Demonology

-- Demonic Empowerment
addon:Buff(193396, {
    spec = demonology,
    unit = 'pet',
    position = {'CENTER', 'UIParent', 'CENTER', -210, 0}
})

-- Doom
addon:Debuff(603, {
    spec = demonology,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})

-- Shadowflame (debuff)
addon:Debuff(205181, {
    spec = demonology,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 84}
})

-- Shadowflame (cooldown)
addon:Cooldown(205181, {
    spec = demonology,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 84}
})

-- Call Dradstalkers
addon:Cooldown(104316, {
    spec = demonology,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})


-- Trinkets

-- Ulthalesh, Deadwind Harvester
addon:Buff(216708, {
    spec = affliction,
    position = {'CENTER', 'UIParent', 'CENTER', 150, 42},
    PostUpdateHook = function(self)
        local count = select(4, UnitBuff('player', 'Tormented Souls'))
        if count and count > 0 then
            self.Icon.Count:SetText(count)
        else
            self.Icon.Count:SetText()
        end
    end
})

-- Thal'Kiel's Consumption
addon:Cooldown(211714, {
    spec = demonology,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0}
})

-- Dimensional Rift
addon:Cooldown(211714, {
    spec = destruction,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0}
})
