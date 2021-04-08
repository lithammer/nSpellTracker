local _, addon = ...
local cfg = addon.cfg

local LibGlow = LibStub("LibCustomGlow-1.0")
local decimalThreshold = 3

local function GetAlpha(self, duration)
    -- local alpha = self.alpha.inactive

    -- if self.Icon.Cooldown:GetCooldownDuration() > 0 then
    --     alpha = self.alpha.active
    -- end

    local alpha = self.alpha.active

    if self.Icon.Cooldown:GetCooldownDuration() == 0 and not InCombatLockdown() then
        alpha = 0
    end
	
	if self.alpha then
		if self.alpha.notCooldown and self.Icon.Cooldown:GetCooldownDuration() <= 0 then
			--spell not on cooldown
			alpha = self.alpha.notCooldown.icon or alpha
		elseif self.alpha.cooldown and self.Icon.Cooldown:GetCooldownDuration() > 0 then
			--spell on cooldown
			alpha = self.alpha.cooldown.icon or alpha
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

local function UpdateCooldown(self)

	local start, duration, enable
	 
	if not self.cdType or self.cdType == 'spell' then
		start, duration, enable = GetSpellCooldown(self.spellID)
	elseif self.cdType and self.cdType == 'item' then
		start, duration, enable = GetItemCooldown(self.spellID)
	end
	
    local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(self.spellID)

	if maxCharges ~= nil and maxCharges > 1 then
		self.Icon.Count:SetText(charges)
	else
		self.Icon.Count:SetText('')
	end

    if charges and maxCharges and maxCharges > 1 and charges < maxCharges then
        StartChargeCooldown(self.Icon, chargeStart, chargeDuration)
    else
        ClearChargeCooldown(self.Icon)
    end

	if not self.globalCooldown or (self.globalCooldown and duration > self.globalCooldown) then
		CooldownFrame_Set(self.Icon.Cooldown, start, duration, enable)
	end

    if self.desaturate and self.Icon.Cooldown:GetCooldownDuration() > 0 then
        self.Icon.Texture:SetDesaturated(true)
    else
        self.Icon.Texture:SetDesaturated(false)
    end

    local alpha = GetAlpha(self, duration)
    self.Icon:SetAlpha(alpha)
	
    SetGlow(self, alpha)

    if duration and self.PostUpdateHook then
        self:PostUpdateHook()
    end

end

local function ScanCooldowns()
	for _, self in pairs(addon.cooldowns) do
		if self:IsCurrentSpec() or (self.verifySpell and FindSpellBookSlotBySpellID(self.spellID)) then
			UpdateCooldown(self)
		else
			self.Icon:SetAlpha(0)
		end
	end
end

addon.ScanCooldowns = ScanCooldowns

