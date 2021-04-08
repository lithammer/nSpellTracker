local _, addon = ...
local cfg = addon.cfg

local LibGlow = LibStub("LibCustomGlow-1.0")
local decimalThreshold = 3

local function GetAlpha(self, spellID, isUsable)
	local alpha = self.alpha.active

	if self.peekAlpha then
		if self.peekAlpha.notUsable and not isUsable then
			--spell not usable
			alpha = self.peekAlpha.notUsable.icon or alpha
		elseif self.peekAlpha.usable and isUsable then
			--spell usable
			alpha = self.peekAlpha.usable.icon or alpha
		end
	end
	
	if self.verifySpell and spellID and not FindSpellBookSlotBySpellID(spellID) then
		alpha = 0
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

local function UpdateSpells(self)
	if not self.spellID then return end
	if self.validateUnit and not UnitExists(self.unit) then return end
	
	local name, _, icon = GetSpellInfo(self.spellID)
	local isUsable = IsUsableSpell(self.spellID) 
	
	if self.desaturate then
		self.Icon.Texture:SetDesaturated(not durationText)
	end
	
	if not self.iconTexture and icon and icon ~= self.Icon.Texture:GetTexture() then
		self.Icon.Texture:SetTexture(icon)
	end
	
	local alpha = GetAlpha(self, self.spellID, isUsable)
	self.Icon:SetAlpha(alpha)
	
	SetGlow(self, alpha)
	
	if duration and self.PostUpdateHook then
		self:PostUpdateHook()
	end
end

local function ScanSpells()
	for _, self in pairs(addon.spells) do
		if self:IsCurrentSpec() then
			UpdateSpells(self)
		else
			self.Icon:SetAlpha(0)
		end
	end
end

addon.ScanSpells = ScanSpells
