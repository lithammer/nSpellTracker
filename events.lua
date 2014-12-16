local _, addon = ...

local function GetSpell(aura)
    for _, spellId in pairs(aura._spellIds) do
        local name, _, icon = GetSpellInfo(spellId)
        local _, _, _, count, debuffType, _, expirationTime, _, _, _, found, _, _, isCastByPlayer = UnitAura(aura.unit, name, nil, aura._filter)

        if found then
            return found, icon, count, expirationTime, isCastByPlayer, debuffType
        end
    end
end

local function ScanAuras()
    local now = GetTime()

    for _, aura in pairs(addon.auras) do
        local found, icon, count, expirationTime, isCastByPlayer, debuffType = GetSpell(aura)

        if found and (aura.isMine and isCastByPlayer) then
            if count > 0 then
                aura.Icon.Count:SetText(count)
            end

            if aura:IsUsable() or addon:Round(expirationTime) ~= addon:Round(aura._triggerTime) then
                aura._triggerTime = expirationTime
                aura.Icon.Cooldown:SetCooldown(now, expirationTime - now)

                if icon ~= aura.Icon.Texture:GetTexture() then
                    aura.Icon.Texture:SetTexture(icon)
                end
            end

            aura._show = true
        end

        if debuffType then
            local color = DebuffTypeColor[debuffType]
            aura.Icon.Border:SetVertexColor(color.r, color.g, color.b)
        end

        aura:SetVisibility()

        if found and aura.PostUpdateHook then
            aura:PostUpdateHook(expirationTime, count)
        end
    end
end

local function ScanCooldowns()
    for _, aura in pairs(addon.cooldowns) do
        if aura:IsCurrentSpec() then
            -- Since related cooldowns trigger eachother we naively pick the first one
            local start, duration = GetSpellCooldown(aura._spellIds[1])

            if duration > 2 then
                if start > aura._triggerTime then
                    aura._triggerTime = start
                    aura.Icon.Cooldown:SetCooldown(start, duration)
                end
                aura._show = true
            end

            aura:SetVisibility()

            if duration and aura.PostUpdateHook then
                aura:PostUpdateHook(expirationTime)
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
