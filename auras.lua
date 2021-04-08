local _, addon = ...
local cfg = addon.cfg

local LibGlow = LibStub("LibCustomGlow-1.0")
local decimalThreshold = 3

local function Round(num, idp)
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

local function GetAlpha(self, duration, caster, auraName, spellID)
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

    if self.verifySpell and spellID and not FindSpellBookSlotBySpellID(spellID) then
        alpha = 0
    end
	
	if self.alpha then
		if self.alpha.notFound and not auraName then
			--aura not found
			alpha = self.alpha.notFound.icon or alpha
		elseif self.alpha.found and auraName then
			--aura found
			alpha = self.alpha.found.icon or alpha
		end
	end
	
    return alpha
end

local function SetGlow(self, alpha)
	if not self.glowOverlay then return end
	if not alpha then return end
	
	local reqAlpha = self.glowOverlay.reqAlpha or 0
	local shineType = self.glowOverlay.shineType or 'Blizzard'
	
	local switch = false
	if reqAlpha > 0 and alpha >= reqAlpha then switch = true end
	if reqAlpha == 0 and alpha > reqAlpha then switch = true end --only display by default if we have alpha greather than zero
	
	if shineType == 'Blizzard' then
		if switch then
			ActionButton_ShowOverlayGlow(self.Icon)
		else
			ActionButton_HideOverlayGlow(self.Icon)
		end
	elseif shineType == 'PixelGlow' then
		local opt = self.glowOverlay
		if switch then
			LibGlow.PixelGlow_Start(self.Icon, opt.color, opt.numLines, opt.frequency, opt.lineLength, opt.lineThickness, opt.xOffset, opt.yOffset, opt.border)
		else
			LibGlow.PixelGlow_Stop(self.Icon, nil)
		end
	elseif shineType == 'AutoCastGlow' then
		local opt = self.glowOverlay
		if switch then
			LibGlow.AutoCastGlow_Start(self.Icon, opt.color, opt.numParticle, opt.frequency, opt.particleScale, opt.xOffset, opt.yOffset)
		else
			LibGlow.AutoCastGlow_Stop(self.Icon, nil)
		end
	elseif shineType == 'ButtonGlow' then
		local opt = self.glowOverlay
		if switch then
			LibGlow.ButtonGlow_Start(self.Icon, opt.color, opt.frequency)
		else
			LibGlow.ButtonGlow_Stop(self.Icon, nil)
		end
	end
end

local function UpdateAura(self)
	if not self.spellID then return end
	if self.validateUnit and not UnitExists(self.unit) then return end
	
	local name, icon, count, debuffType, expires, caster, spID
	local spellList = {}

	--check for spell table
    if type(self.spellID) == 'table' then
        for _, value in pairs(self.spellID) do
			spellList[value] = true
        end
		spellList[self.rootSpellID] = true
    end
	
	for i=1, 40 do
		local nameChk, _, _, _, _, _, _, _, _, spellIDChk = UnitAura(self.unit, i, self.filter)
		if not nameChk then break end
		if self.spellID == spellIDChk or spellList[spellIDChk] then
			name, icon, count, debuffType, _, expires, caster, _, _, spID = UnitAura(self.unit, i, self.filter)
			if spID ~= self.rootSpellID then
				name, _, icon = GetSpellInfo(self.rootSpellID)
			end
			break
		end
	end

	if self.isMine and caster and caster ~= "player" then return end

    local duration = CalculateDuration(expires)
    if duration and duration > 0 and duration < decimalThreshold then
        self.Icon.Duration:SetTextColor(1, 0, 0, 1)
    else
        self.Icon.Duration:SetTextColor(1, 1, 1, 1)
    end

    local durationText = ''
    if duration and duration > 0 and self.caster == caster then
        durationText = (duration == math.huge) and 'Inf' or duration
    end
    self.Icon.Duration:SetText(addon:GetTimeText(durationText))

    if self.desaturate then
        self.Icon.Texture:SetDesaturated(not durationText)
    end
	
    if caster and count and self.caster == caster and count > 0 then
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
	
	if caster and caster == "player" and cfg.highlightPlayerSpells then
		self.Icon.Border:SetVertexColor(0.2,0.6,0.8,1)
	end
		
    local alpha = GetAlpha(self, duration, caster, name, spID)
    self.Icon:SetAlpha(alpha)
	
	SetGlow(self, alpha)
	
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

addon.ScanAuras = ScanAuras
