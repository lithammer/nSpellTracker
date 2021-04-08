local _, addon = ...
local cfg = addon.cfg

local LibGlow = LibStub("LibCustomGlow-1.0")
local decimalThreshold = 3

local function Round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function GetAlpha(self, duration, hasEnchant)
	local alpha = self.alpha.active
	
	if duration == 0 then
		alpha = self.alpha.inactive
	end
	
	if self.peekAlpha then
		if self.peekAlpha.notFound and not hasEnchant then
			--enchant not found
			alpha = self.peekAlpha.notFound.icon or alpha
		elseif self.peekAlpha.found and hasEnchant then
			--enchant found
			alpha = self.peekAlpha.found.icon or alpha
		end
	end
	
	if self.hideOutOfCombat and not InCombatLockdown() then
		alpha = 0
	end
	
	return alpha or 0
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

local function UpdateTempEnchant(self)
	if not self.spellID then return end
	if self.validateUnit and not UnitExists(self.unit) then return end
	
	local duration, iconTexture
	local hasEnchant = false
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
	local mhExp = mainHandExpiration and (mainHandExpiration / 1000)
	local ohExp = offHandExpiration and (offHandExpiration / 1000)
	
	if mainHandEnchantID and mainHandEnchantID == self.spellID then
		duration = mhExp
		hasEnchant = true
		iconTexture = GetInventoryItemTexture("player", GetInventorySlotInfo("MainHandSlot"))
	elseif offHandEnchantID and offHandEnchantID == self.spellID then
		duration = ohExp
		hasEnchant = true
		iconTexture = GetInventoryItemTexture("player", GetInventorySlotInfo("SecondaryHandSlot"))
	end
	
	if duration and duration > 0 and duration < decimalThreshold then
		self.Icon.Duration:SetTextColor(1, 0, 0, 1)
	else
		self.Icon.Duration:SetTextColor(1, 1, 1, 1)
	end
	
	local durationText = ''
	if duration and duration > 0 then
		durationText = (duration == math.huge) and 'Inf' or duration
	end
	self.Icon.Duration:SetText(addon:GetTimeText(durationText))
	
	if self.desaturate then
		self.Icon.Texture:SetDesaturated(not durationText)
	end
	
	if not self.iconTexture and iconTexture and iconTexture ~= self.Icon.Texture:GetTexture() then
		self.Icon.Texture:SetTexture(iconTexture)
	end
	
	local alpha = GetAlpha(self, duration, hasEnchant)
	self.Icon:SetAlpha(alpha)
	
	SetGlow(self, alpha)
	
	if duration and self.PostUpdateHook then
		self:PostUpdateHook()
	end
	
end

local function ScanTempEnchants()
	for _, self in pairs(addon.tempenchants) do
		if self:IsCurrentSpec() then
			UpdateTempEnchant(self)
		else
			self.Icon:SetAlpha(0)
		end
	end
end

addon.ScanTempEnchants = ScanTempEnchants
