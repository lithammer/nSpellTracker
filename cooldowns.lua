local _, addon = ...

local globalCooldown = 1.5

local function GetAlpha(self, duration)
    -- local alpha = self.alpha.inactive

    -- if self.Icon.Cooldown:GetCooldownDuration() > 0 then
    --     alpha = self.alpha.active
    -- end

    local alpha = self.alpha.active

    if self.Icon.Cooldown:GetCooldownDuration() == 0 and not InCombatLockdown() then
        alpha = 0
    end

    return alpha
end

local function UpdateCooldown(self, event, ...)
    -- if event == 'PLAYER_REGEN_DISABLED' then
    --     self.Icon.Cooldown:SetDrawBling(true)
    -- end

    local start, duration, enable = GetSpellCooldown(self.spellID)
    local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(self.spellID)

    if event == 'SPELL_UPDATE_CHARGES' then
        if maxCharges ~= nil and maxCharges > 1 then
            self.Icon.Count:SetText(charges)
        else
            self.Icon.Count:SetText('')
        end
    end

    if charges and maxCharges and maxCharges > 1 and charges < maxCharges then
        StartChargeCooldown(self.Icon, chargeStart, chargeDuration)
    else
        ClearChargeCooldown(self.Icon)
    end

    if duration > globalCooldown then
        CooldownFrame_Set(self.Icon.Cooldown, start, duration, enable)
    end

    -- if self.Icon.Cooldown:GetCooldownDuration() == 0 then
    --     self.Icon.Duration:SetText('RDY')
    -- else
    --     self.Icon.Duration:SetText()
    -- end

    if self.desaturate and self.Icon.Cooldown:GetCooldownDuration() > 0 then
        self.Icon.Texture:SetDesaturated(true)
    else
        self.Icon.Texture:SetDesaturated(false)
    end

    local alpha = GetAlpha(self, duration)
    self.Icon:SetAlpha(alpha)

    if self.glowOverlay and alpha > 0 and IsSpellOverlayed(self.spellID) then
        ActionButton_ShowOverlayGlow(self.Icon)
    else
        ActionButton_HideOverlayGlow(self.Icon)
    end

    if duration and self.PostUpdateHook then
        self:PostUpdateHook()
    end

    -- if event == 'PLAYER_REGEN_ENABLED' then
    --     self.Icon.Cooldown:SetDrawBling(false)
    -- end
end

local function ScanCooldowns(self, event, ...)
    for _, self in pairs(addon.cooldowns) do
        if self:IsCurrentSpec() and FindSpellBookSlotBySpellID(self.spellID) then
            UpdateCooldown(self, event, ...)
        else
            self.Icon:SetAlpha(0)
        end
    end
end

local events = CreateFrame('Frame')
events:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
events:RegisterEvent('PLAYER_REGEN_DISABLED')
events:RegisterEvent('PLAYER_REGEN_ENABLED')
events:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
events:RegisterEvent('SPELL_UPDATE_CHARGES')
events:RegisterEvent('SPELL_UPDATE_COOLDOWN')
events:RegisterEvent('SPELL_UPDATE_USABLE')
events:SetScript('OnEvent', ScanCooldowns)
