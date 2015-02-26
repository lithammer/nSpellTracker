local _, addon = ...

local function GetSpell(aura)
    for _, id in pairs(aura._spellIds) do
        local name, _, icon = GetSpellInfo(id)
        local _, _, _, count, debuffType, duration, expirationTime, caster, _, _, spellId = UnitAura(aura.unit, name, nil, aura._filter)

        if spellId then
            return spellId, icon, count, duration, expirationTime, caster, debuffType
        end
    end
end

local function ScanAuras()
    local now = GetTime()

    for _, aura in pairs(addon.auras) do
        local spellId, icon, count, duration, expirationTime, caster, debuffType = GetSpell(aura)

        if spellId and aura.caster == caster then
            if count > 0 then
                aura.Icon.Count:SetText(count)
            end

            if aura:IsUsable() or addon.Round(expirationTime) ~= addon.Round(aura._expirationTime) then
                aura._expirationTime = expirationTime
                aura.Icon.Cooldown:SetCooldown(now, expirationTime - now)

                if icon ~= aura.Icon.Texture:GetTexture() then
                    aura.Icon.Texture:SetTexture(icon)
                end
            end

            aura._show = true
        end

        -- Use debuff type as border color (if available)
        if debuffType then
            local color = DebuffTypeColor[debuffType]
            aura.Icon.Border:SetVertexColor(color.r, color.g, color.b)
        end

        -- Change border color when a DoT is safe to refresh
        if aura._filter == 'HARMFUL' and caster == 'player' and duration then
            local refreshThreshold = 0.3
            if expirationTime - now < duration * refreshThreshold then
                aura.Icon.Border:SetVertexColor(1, 1, 0)
            end
        end

        aura:SetVisibility()

        if spellId and aura.PostUpdateHook then
            aura:PostUpdateHook(expirationTime, count)
        end
    end
end

local function ScanCooldowns()
    for _, aura in pairs(addon.cooldowns) do
        if aura:IsCurrentSpec() then
            -- Since related cooldowns trigger eachother we naively pick the first one
            local start, duration = GetSpellCooldown(aura._spellIds[1])

            local charges, maxCharges, _, _ = GetSpellCharges(aura._spellIds[0])

            if duration > 2 then
                if start > aura._startTime then
                    aura._startTime = start
                    aura.Icon.Cooldown:SetCooldown(start, duration)
                end
                aura._show = true
            end

            aura:SetVisibility()

            if duration and aura.PostUpdateHook then
                aura:PostUpdateHook(start, duration)
            end
        end
    end
end

local function OnEvent(self, event, ...)
    ScanAuras()
    ScanCooldowns()
end

local f = CreateFrame('Frame')

for _, e in pairs({
    'UNIT_AURA',
    'SPELL_UPDATE_COOLDOWN',
    'SPELL_UPDATE_USABLE',
    'PLAYER_REGEN_DISABLED',
    'PLAYER_REGEN_ENABLED',
    'PLAYER_TARGET_CHANGED'
}) do
    f:RegisterEvent(e)
end

f:SetScript('OnEvent', OnEvent)
