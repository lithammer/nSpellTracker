local _, addon = ...

addon.auras = {}
addon.cooldowns = {}
addon.playerClass = select(2, UnitClass('player'))

local spell = {}

-- Public methods

function addon:Buff(spellId, config)
    local aura = spell.New(spellId, 'HELPFUL')
    aura.alpha.notFound = 0.4
    aura:UpdateConfig(config)
    aura:CreateIcon()
    table.insert(self.auras, aura)
end

function addon:Debuff(spellId, config)
    local aura = spell.New(spellId, 'HARMFUL')
    aura.unit = 'target'
    aura:UpdateConfig(config)
    aura:CreateIcon()
    table.insert(self.auras, aura)
end

function addon:Cooldown(spellId, config)
    local cd = spell.New(spellId, nil)
    cd.desaturate = true
    cd:UpdateConfig(config)
    cd:CreateIcon()
    table.insert(addon.cooldowns, cd)
end

-- Private

spell.__index = spell

function spell.New(spellId, filter)
    local t = {}
    setmetatable(t, spell)

    if type(spellId) ~= 'table' then
        spellId = {spellId}
    end

    -- Internal values
    t._spellIds = spellId
    t._filter = filter
    t._triggerTime = GetTime()

    -- Set default values
    t.desaturate = false
    t.hideOutOfCombat = false
    t.isMine = true
    t.position = {'CENTER'}
    t.size = 36
    t.spec = nil
    t.unit = 'player'
    t.visibilityState = '[petbattle] [vehicleui] hide; show'

    t.alpha = {
        found = 1,
        notFound = 0.4,
        cooldown = 0.6,
        notCooldown = 1
    }

    return t
end

function spell:UpdateConfig(config)
    if type(config) == 'table' then
        for k, v in pairs(config) do
            if self[k] then
                self[k] = v
            end
        end
    end
end

function spell:CreateIcon()
    -- Just use the first available texture, will be updated in
    -- Scan{Auras,Cooldowns} later on
    local _, _, image = GetSpellInfo(self._spellIds[1])

    self.Icon = CreateFrame('Frame', self:GetName(), UIParent, 'SecureHandlerStateTemplate')
    self.Icon:SetPoint(unpack(self.position))
    self.Icon:SetSize(self.size, self.size)
    self.Icon:SetAlpha(0)

    -- Create cooldown
    local cooldown = CreateFrame('Cooldown', nil, self.Icon, 'CooldownFrameTemplate')
    cooldown:SetAllPoints(self.Icon)
    cooldown:SetReverse(true)
    self.Icon.Cooldown = cooldown

    -- Create texture
    local texture = self.Icon:CreateTexture(nil, 'BACKGROUND', nil, -6)
    texture:SetAllPoints(self.Icon)
    texture:SetTexture(image)
    self.Icon.Texture = texture

    -- Create border
    -- if self.Icon.CreateBeautyBorder then
    --     self.Icon:CreateBeautyBorder(12)
    -- end

    -- Create border glow
    local glow = self.Icon:CreateTexture(nil, 'BACKGROUND', nil, -8)
    glow:SetTexture('Interface\\AddOns\\nSpellTracker\\media\\simplesquare_glow')
    glow:SetVertexColor(0, 0, 0, 1)
    glow:SetPoint('TOPLEFT', self.Icon, 'TOPLEFT', -self.size*3.3/32, self.size*3.3/32)
    glow:SetPoint('BOTTOMRIGHT', self.Icon, 'BOTTOMRIGHT', self.size*3.3/32, -self.size*3.3/32)
    self.Icon.Glow = glow

    -- Create border
    local border = self.Icon:CreateTexture(nil, 'BACKGROUND', nil, -4)
    border:SetTexture('Interface\\AddOns\\nSpellTracker\\media\\simplesquare_roth')
    border:SetVertexColor(0.37, 0.3, 0.3, 1)
    border:SetAllPoints(self.Icon)
    self.Icon.Border = border

    -- Stacks/count
    local count = self.Icon:CreateFontString(nil, 'OVERLAY')
    count:SetFontObject(NumberFontNormal)
    count:SetPoint('BOTTOMLEFT', self.Icon, 'BOTTOMLEFT', 0, 0)
    self.Icon.Count = count

    -- Set visibility
    if self.visibilityState then
        -- RegisterStateDriver(self.Icon, 'visibility', self.visibilityState)
    end
end

function spell:IsUsable()
    return self.Icon.Cooldown:GetCooldownDuration() == 0
end

function spell:SetVisibility()
    local alpha = self._show and 1 or 0

    if self.desaturate then
        self.Icon.Texture:SetDesaturated(not self:IsUsable())
    end

    if not InCombatLockdown() and self.hideOutOfCombat then
        alpha = 0
    end

    if not self:IsCurrentSpec() then
        alpha = 0
    end

    self.Icon.Cooldown:SetSwipeColor(0, 0, 0, alpha * 0.8)
    self.Icon.Cooldown:SetDrawEdge(alpha > 0)
    self.Icon.Cooldown:SetDrawBling(alpha > 0)
    self.Icon:SetAlpha(alpha)

    self._show = false
end

function spell:GetName()
    return string.format('%s%s%s', 'nSpellTracker', #addon.auras, self._spellIds[1])
end

function spell:IsCurrentSpec()
    if type(self.spec) == 'table' then
        for _, spec in pairs(self.spec) do
            if spec == GetSpecialization() then
                return true
            end
        end

        return false
    end

    if type(self.spec) == 'string' then
        return GetSpecialization() and GetSpecializationRole(GetSpecialization()) == self.spec
    end

    return self.spec == nil or self.spec == GetSpecialization()
end
