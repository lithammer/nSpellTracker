local _, addon = ...

if addon.playerClass ~= 'WARLOCK' then return end

-- Haunt
addon:Debuff(48181, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Soulburn: Haunt
addon:Buff(157698, {
    spec = 1,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0},
    PostUpdateHook = function(self, expirationTime, count)
	local shards = UnitPower('player', SPELL_POWER_SOUL_SHARDS)
	if shards > 1 then
            self.Icon.Count:SetText(shards)
	else
            self.Icon.Count:SetText('')
	end
    end
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

-- Dark Soul
addon:Cooldown({113858, 113860, 113860}, {
    position = {'CENTER', 'UIParent', 'CENTER', -294, 42},
    spec = 1,
})

-- Dark Soul (buff)
addon:Buff({113858, 113860, 113861}, {
    position = {'CENTER', 'UIParent', 'CENTER', 150, 42}
})

-- Grimoire: Synergy
addon:Buff(171982, {
    caster = 'pet',
    position = {'CENTER', 'UIParent', 'CENTER', 150, 84}
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
    position = {'CENTER', 'UIParent', 'CENTER', -252, 42}
})

-- Shadowflame
addon:Debuff(47960, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 42}
})

-- Demonbolt
addon:Debuff(157695, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -252, 0},
    unit = 'player'
})

-- Wrathstorm
addon:Cooldown(119915, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 84}
})

-- Felstorm
addon:Cooldown(119914, {
    spec = 2,
    position = {'CENTER', 'UIParent', 'CENTER', -210, 84}
})

-- Trinkets

-- Furyheart Talisman (Heart of the Fury)
addon:Buff(176980, {
    position = {'CENTER', 'UIParent', 'CENTER', 150, 0}
})
