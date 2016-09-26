local _, addon = ...

local globalCooldown = 1.5

local function GetAlpha(self, duration)
    local alpha = self.alpha.inactive

    if self.Icon.Cooldown:GetCooldownDuration() > 0 then
        alpha = self.alpha.active
    end

    if self.hideOutOfCombat and not InCombatLockdown() then
        alpha = 0
    end

    if not FindSpellBookSlotBySpellID(self._spellId) then
        alpha = 0
    end

    return alpha
end

local function ScanCooldowns(self, event, ...)
    for _, self in pairs(addon.cooldowns) do

        if event == 'PLAYER_REGEN_DISABLED' then
            self.Icon.Cooldown:SetDrawBling(true)
        end

        if self:IsCurrentSpec() then
            local start, duration, enable = GetSpellCooldown(self._spellId)
            local charges, maxCharges, _, _ = GetSpellCharges(self._spellId)

            local forceShowDrawEdge = start > self._startTime
            if duration > globalCooldown then
                self._startTime = start
                CooldownFrame_Set(self.Icon.Cooldown, start, duration, enable, forceShowDrawEdge)
            end

            -- self.Icon.Texture:SetDesaturated(enable and duration)
            self.Icon.Texture:SetDesaturated(duration and duration > 0)

            local alpha = GetAlpha(self, duration)
            self.Icon:SetAlpha(alpha)

            if self.glowOverlay and alpha > 0 and IsSpellOverlayed(self._spellId) then
                ActionButton_ShowOverlayGlow(self.Icon)
            else
                ActionButton_HideOverlayGlow(self.Icon)
            end

            if duration and self.PostUpdateHook then
                self:PostUpdateHook()
            end
        else
            self.Icon:SetAlpha(0)
        end

        if event == 'PLAYER_REGEN_ENABLED' and self.hideOutOfCombat then
            self.Icon.Cooldown:SetDrawBling(false)
        end
    end
end

local events = CreateFrame('Frame')
events:RegisterEvent('PLAYER_REGEN_DISABLED')
events:RegisterEvent('PLAYER_REGEN_ENABLED')
events:RegisterEvent('SPELL_UPDATE_COOLDOWN')
events:RegisterEvent('SPELL_UPDATE_USABLE')
events:SetScript('OnEvent', ScanCooldowns)
