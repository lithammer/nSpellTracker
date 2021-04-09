local _, addon = ...
local cfg = addon.cfg

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

	if not self.showOnCooldown then
		local start, duration, enable = GetSpellCooldown(spellID)
		if (start and start > 0) or (duration and duration > 0) then alpha = 0 end
	end
	
	if self.hideOutOfCombat and not InCombatLockdown() then
		alpha = 0
	end
	
	return alpha or 0
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
	
	addon:SetGlow(self, alpha)
	
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
