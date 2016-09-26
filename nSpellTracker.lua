local _, addon = ...

addon.auras = {}
addon.cooldowns = {}
addon.playerClass = select(2, UnitClass('player'))

local CreateIcon, TrackSpell, UpdateConfig

-- Public methods

function addon:Buff(spellId, config)
    local aura = TrackSpell(spellId, 'HELPFUL')
    aura.verifySpell = false
    UpdateConfig(aura, config)
    CreateIcon(aura)
    table.insert(self.auras, aura)
end

function addon:Debuff(spellId, config)
    local aura = TrackSpell(spellId, 'HARMFUL')
    aura.unit = 'target'
    UpdateConfig(aura, config)
    CreateIcon(aura)
    table.insert(self.auras, aura)
end

function addon:Cooldown(spellId, config)
    local cd = TrackSpell(spellId, nil)
    cd.desaturate = true
    UpdateConfig(cd, config)
    CreateIcon(cd)
    table.insert(self.cooldowns, cd)
end

-- Private

local spell = {}
spell.__index = spell

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

TrackSpell = function(spellId, filter)
    local t = {}
    setmetatable(t, spell)

    -- Internal values
    t._spellId = spellId
    t._filter = filter
    t._expirationTime = GetTime()  -- For {de}buffs
    t._startTime = GetTime()       -- For cooldowns

    -- Set default values
    t.caster = 'player'
    t.desaturate = true
    t.glowOverlay = true
    t.hideOutOfCombat = true
    t.position = {'CENTER'}
    t.size = 36
    t.spec = nil
    t.unit = 'player'
    t.verifySpell = true
    t.visibilityState = '[petbattle] [vehicleui] hide; show'

    t.alpha = {
        active = 1,
        inactive = 0.4
    }

    return t
end

UpdateConfig = function(old, new)
    for k, v in pairs(new) do
        old[k] = v
    end
end

local function GetFrameName(spellId)
    return string.format('%s%s%s', 'nSpellTracker', #addon.auras, spellId)
end

CreateIcon = function(self)
    -- Just use the first available texture, will be updated in
    -- Scan{Auras,Cooldowns} later on
    local _, _, iconTexture = GetSpellInfo(self._spellId)

    self.Icon = CreateFrame('Frame', GetFrameName(self._spellId), UIParent, 'SecureHandlerStateTemplate')
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
    texture:SetTexture(iconTexture)
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

    -- Duration (auras only)
    local duration = self.Icon:CreateFontString(nil, 'OVERLAY')
    duration:SetFontObject(NumberFontNormal)
    duration:SetPoint('CENTER', self.Icon, 'CENTER', 0, 0)
    self.Icon.Duration = duration

    -- Set visibility
    if self.visibilityState then
        RegisterStateDriver(self.Icon, 'visibility', self.visibilityState)
    end
end
