local _, addon = ...

local decimalThreshold = 3

function Round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function CalculateDuration(expires)
    if expires == nil then
        return 0
    end

    local duration = expires - GetTime()
    if duration < 0 then
        return math.huge
    end

    local idp = (duration < decimalThreshold) and 1 or 0
    return Round(duration, idp)
end

local function GetAlpha(self, duration, caster)
    local alpha = self.alpha.active

    if duration == 0 then
        alpha = self.alpha.inactive
    end

    if self.caster ~= caster then
        alpha = self.alpha.inactive
    end

    if self.hideOutOfCombat and not InCombatLockdown() then
        alpha = 0
    end

    if self.verifySpell and not FindSpellBookSlotBySpellID(self.spellID) then
        alpha = 0
    end
    return alpha
end

local function UpdateAura(self)
    local name, _, icon = GetSpellInfo(self.spellID)
    local _, _, _, count, debuffType, _, expires, caster = UnitAura(self.unit, name, nil, self.filter)

    local duration = CalculateDuration(expires)

    if duration > 0 and duration < decimalThreshold then
        self.Icon.Duration:SetTextColor(1, 0, 0, 1)
    else
        self.Icon.Duration:SetTextColor(1, 1, 1, 1)
    end

    local durationText = ''
    if duration > 0 and self.caster == caster then
        durationText = (duration == math.huge) and 'Inf' or duration
    end
    self.Icon.Duration:SetText(durationText)

    if self.desaturate then
        self.Icon.Texture:SetDesaturated(not durationText)
    end

    if self.caster == caster and count and count > 0 then
        self.Icon.Count:SetText(count)
    else
        self.Icon.Count:SetText()
    end

    if icon and icon ~= self.Icon.Texture:GetTexture() then
        self.Icon.Texture:SetTexture(icon)
    end

    -- Use debuff type as border color (if available)
    if debuffType then
        local color = DebuffTypeColor[debuffType]
        self.Icon.Border:SetVertexColor(color.r, color.g, color.b)
    end

    local alpha = GetAlpha(self, duration, caster)
    self.Icon:SetAlpha(alpha)

    if duration and self.PostUpdateHook then
        self:PostUpdateHook()
    end
end

local function ScanAuras()
    for _, self in pairs(addon.auras) do
        if self:IsCurrentSpec() then
            UpdateAura(self)
        else
            self.Icon:SetAlpha(0)
        end
    end
end

-- local events = CreateFrame('Frame')
-- events:RegisterEvent('PLAYER_REGEN_DISABLED')
-- events:RegisterEvent('PLAYER_REGEN_ENABLED')
-- events:RegisterEvent('PLAYER_TARGET_CHANGED')
-- events:RegisterEvent('SPELL_UPDATE_USABLE')
-- events:RegisterEvent('UNIT_AURA')
-- events:SetScript('OnEvent', function(self, event, ...)
--     ScanAuras()
-- end)

local refreshInterval = 0.1
CreateFrame('Frame'):SetScript('OnUpdate', function(self, elapsed)
    self.delta = (self.delta or 0) + elapsed
    if self.delta >= refreshInterval then
        self.delta = self.delta - refreshInterval
        ScanAuras()
    end
end)
