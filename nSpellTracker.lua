local _, addon = ...

addon.auras = {}
addon.cooldowns = {}
addon.playerClass = select(2, UnitClass('player'))

local CreateIcon, TrackSpell, UpdateConfig

-- Public methods

function addon:Buff(spellID, config)
    local aura = TrackSpell(spellID, 'HELPFUL')
    aura.verifySpell = false
    UpdateConfig(aura, config)
    CreateIcon(aura)
    table.insert(self.auras, aura)
end

function addon:Debuff(spellID, config)
    local aura = TrackSpell(spellID, 'HARMFUL')
    aura.unit = 'target'
    UpdateConfig(aura, config)
    CreateIcon(aura)
    table.insert(self.auras, aura)
end

function addon:Cooldown(spellID, config)
    local cd = TrackSpell(spellID, nil)
    -- cd.desaturate = true
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

TrackSpell = function(spellID, filter)
    local t = {}
    setmetatable(t, spell)

    -- Internal values
    t.spellID = spellID
    t.filter = filter

    -- Set default values
    t.caster = 'player'
    t.desaturate = false
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

local function GetFrameName(spellID)
    return string.format('%s%s%s', 'nSpellTracker', #addon.auras, spellID)
end

CreateIcon = function(self)
    local _, _, iconTexture = GetSpellInfo(self.spellID)

    self.Icon = CreateFrame('Frame', GetFrameName(self.spellID), UIParent, 'SecureHandlerStateTemplate')
    self.Icon:SetPoint(unpack(self.position))
    self.Icon:SetSize(self.size, self.size)
    self.Icon:SetAlpha(0)

    -- Create cooldown
    local cooldown = CreateFrame('Cooldown', '$parentCooldown', self.Icon, 'CooldownFrameTemplate')
    cooldown:SetAllPoints(self.Icon)
    cooldown:SetEdgeTexture('Interface\\Cooldown\\edge')
    cooldown:SetSwipeColor(0, 0, 0)
    cooldown:SetHideCountdownNumbers(false)
    self.Icon.Cooldown = cooldown  -- Needs lowercase 'c' because of ActionButton_UpdateCooldown

    local chargeCooldown = CreateFrame('Cooldown', '$parentChargeCooldown', self.Icon, 'CooldownFrameTemplate')
    chargeCooldown:SetAllPoints(self.Icon)
    chargeCooldown:SetHideCountdownNumbers(true)
    chargeCooldown:SetDrawSwipe(false)
    chargeCooldown:SetFrameStrata('TOOLTIP')
    self.Icon.chargeCooldown = chargeCooldown

    -- Create texture
    local texture = self.Icon:CreateTexture('$parentTexture', 'BACKGROUND', nil, -6)
    texture:SetAllPoints(self.Icon)
    texture:SetTexture(iconTexture)
    self.Icon.Texture = texture

    -- Create border
    -- if self.Icon.CreateBeautyBorder then
    --     self.Icon:CreateBeautyBorder(12)
    -- end

    -- Create border glow
    local glow = self.Icon:CreateTexture('$parentGlow', 'BACKGROUND', nil, -8)
    glow:SetTexture('Interface\\AddOns\\nSpellTracker\\media\\simplesquare_glow')
    glow:SetVertexColor(0, 0, 0, 1)
    glow:SetPoint('TOPLEFT', self.Icon, 'TOPLEFT', -self.size*3.3/32, self.size*3.3/32)
    glow:SetPoint('BOTTOMRIGHT', self.Icon, 'BOTTOMRIGHT', self.size*3.3/32, -self.size*3.3/32)
    self.Icon.Glow = glow

    -- Create border
    local border = self.Icon:CreateTexture('$parentBorder', 'BACKGROUND', nil, -4)
    border:SetTexture('Interface\\AddOns\\nSpellTracker\\media\\simplesquare_roth')
    border:SetVertexColor(0.37, 0.3, 0.3, 1)
    border:SetAllPoints(self.Icon)
    self.Icon.Border = border

    -- Stacks/count
    local count = self.Icon:CreateFontString('$parentCount', 'OVERLAY')
    count:SetFontObject(NumberFontNormal)
    count:SetPoint('BOTTOMRIGHT', self.Icon, 'BOTTOMRIGHT', 0, 0)
    self.Icon.Count = count

    -- Duration (auras only)
    local duration = self.Icon:CreateFontString('$parentDuration', 'OVERLAY')
    duration:SetFontObject(NumberFontNormal)
    duration:SetPoint('CENTER', self.Icon, 'CENTER', 0, 0)
    self.Icon.Duration = duration

    -- Set visibility
    if self.visibilityState then
        RegisterStateDriver(self.Icon, 'visibility', self.visibilityState)
    end
end
