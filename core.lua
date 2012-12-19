--[[

	Heavily modified and refactored addon based on Zork's rFilter3.

]]--

local _, addon = ...
local config = addon.config

-- Table to hold created icons for easy access
local Frames = {}

local floor = math.floor
local format = string.format

local function GetFormattedTime(time)
	local hr, m, s, text

	if time <= 0 then
		text = ''
	elseif config.updatetime <= 0.1 and time < 3 then
		text = format('%.1f', time)
	elseif time < 60 then
		m = floor(time / 60)
		s = mod(time, 60)
		text = m == 0 and format('%ds', s)
	elseif time < 3600 then
		hr = floor(time / 3600)
		m = floor(mod(time, 3600) / 60 + 1)
		text = format('%dm', m)
	else
		hr = floor(time / 3600 + 1)
		text = format('%dh', hr)
	end

	return text
end

local FormatNumber = function(v)
	if v > 1E10 then
		return floor(v / 1E9)..'b'
	elseif v > 1E9 then
		return floor((v / 1E9) * 10 / 10)..'b'
	elseif v > 1E7 then
		return floor(v / 1E6)..'m'
	elseif v > 1E6 then
		return floor((v / 1E6) * 10 / 10)..'m'
	elseif v > 1E4 then
		return floor(v / 1E3)..'k'
	elseif v > 1E3 then
		return floor((v / 1E3) * 10 / 10)..'k'
	else
		return v
	end
end


local function ApplySize(i)
	local w = i:GetWidth()

	if w < i.data.size then
		w = i.data.size
	end

	i:SetSize(w, w)

	i.glow:SetPoint('TOPLEFT', i, 'TOPLEFT', -w*3.3/32, w*3.3/32)
	i.glow:SetPoint('BOTTOMRIGHT', i, 'BOTTOMRIGHT', w*3.3/32, -w*3.3/32)

	i.icon:SetPoint('TOPLEFT', i, 'TOPLEFT', w*3/32, -w*3/32)
	i.icon:SetPoint('BOTTOMRIGHT', i, 'BOTTOMRIGHT', -w*3/32, w*3/32)

	i.time:SetFont(STANDARD_TEXT_FONT, w * 16 / 36, 'THINOUTLINE')
	i.time:SetPoint('BOTTOM', 0, 0)

	i.count:SetFont(STANDARD_TEXT_FONT, w * 18 / 32, 'OUTLINE')
	i.count:SetPoint('TOPRIGHT', 0, 0)

	i.value:SetFont(STANDARD_TEXT_FONT, w * 16 / 36, 'THINOUTLINE')
	i.value:SetPoint('TOPLEFT', 0, 0)
end

local function GenerateFrameName(f, t)
	local _, class = UnitClass('player')
	local spec = type(f.spec) == 'table' and f.spec[1] or f.spec and f.spec or 'None'

	return 'nSpellTracker'..t..'Frame'..f:GetSpellID()..'Spec'..spec..class
end

local function UnlockFrame(i)
	-- Only show icons that are visible for the current spec
	if i.data.spec and not i.data:IsCurrentSpec() then
		return
	end

	i.locked = false
	i.dragtexture:SetAlpha(0.2)

	if i.data.movable then
		i:EnableMouse(true)
		i:RegisterForDrag('LeftButton','RightButton')

		i:SetScript('OnEnter', function(self)
			GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT')
			GameTooltip:AddLine(self:GetName(), 0, 1, 0.5, 1, 1, 1)
			GameTooltip:AddLine('Left mouse + alt + shift to drag', 1, 1, 1, 1, 1, 1)
			GameTooltip:AddLine('Right mouse + alt + shift to size', 1, 1, 1, 1, 1, 1)
			GameTooltip:Show()
		end)

		i:SetScript('OnLeave', function(self)
			GameTooltip:Hide()
		end)

		i:SetScript('OnDragStart', function(self, button)
			if IsAltKeyDown() and IsShiftKeyDown() and button == 'LeftButton' then
				self:StartMoving()
			end

			if IsAltKeyDown() and IsShiftKeyDown() and button == 'RightButton' then
				self:StartSizing()
			end
		end)

		i:SetScript('OnDragStop', function(self)
			self:StopMovingOrSizing()
		end)
	end
end

local function LockFrame(i)
	i:EnableMouse(nil)
	i.locked = true
	i.dragtexture:SetAlpha(0)
	i:RegisterForDrag(nil)
	i:SetScript('OnEnter', nil)
	i:SetScript('OnLeave', nil)
	i:SetScript('OnDragStart', nil)
	i:SetScript('OnDragStop', nil)
end

local function ApplyMoveFunctionality(i)
	if not i.data.movable then
		if i:IsUserPlaced() then
			i:SetUserPlaced(false)
		end
	end

	local t = i:CreateTexture(nil, 'OVERLAY', nil, 6)
	t:SetAllPoints(i)
	t:SetTexture(0, 1, 0)
	if not i.data.movable then
		t:SetTexture(1, 0, 0)
	end
	t:SetAlpha(0)
	i.dragtexture = t

	if i.data.movable then
		i:SetHitRectInsets(-5, -5, -5, -5)
		i:SetClampedToScreen(true)
		i:SetMovable(true)
		i:SetResizable(true)
		i:SetUserPlaced(true)

		i:SetScript('OnSizeChanged', function(self)
			ApplySize(self)
		end)
	end

	-- Lock frame by default
	LockFrame(i)

	table.insert(Frames, i:GetName())
end

local function UnlockAllFrames()
	for i, v in ipairs(Frames) do
		UnlockFrame(_G[v])
	end
end

local function LockAllFrames()
	for i, v in ipairs(Frames) do
		LockFrame(_G[v])
	end
end

local function ResetAllFrames()
	for i, v in ipairs(Frames) do
		local f = _G[v]
		if f:IsUserPlaced() then
			f:SetPoint(unpack(f.data.position))
			f:SetSize(f.data.size, f.data.size)
		end
	end
end

local framesLocked = true
local function SlashCmd(cmd)
	if cmd:match('reset') then
		ResetAllFrames()
		return
	end

	if framesLocked then
		UnlockAllFrames()
		framesLocked = false
	else
		LockAllFrames()
		framesLocked = true
	end
end

SlashCmdList['nspelltracker'] = SlashCmd;
SLASH_nspelltracker1 = '/nspelltracker';
SLASH_nspelltracker2 = '/nst';
print('|c0033AAFF\/nspelltracker|r or |c0033AAFF\/nst|r to lock/unlock the frames or |c0033AAFF\/nst reset|r to reset frame positions.')

local function CreateIcon(f, type)
	local spellName, _, spellIcon = GetSpellInfo(f:GetSpellID())

	local i = CreateFrame('Frame', GenerateFrameName(f, type), UIParent, 'SecureHandlerStateTemplate')
	i:SetSize(f.size, f.size)
	i:SetPoint(unpack(f.position))

	local glow = i:CreateTexture(nil, 'BACKGROUND', nil, -8)
	glow:SetTexture('Interface\\AddOns\\nSpellTracker\\media\\simplesquare_glow')
	glow:SetVertexColor(0, 0, 0, 1)

	local back = i:CreateTexture(nil, 'BACKGROUND',nil,-7)
	back:SetAllPoints(i)
	back:SetTexture('Interface\\AddOns\\nSpellTracker\\media\\d3portrait_back2')

	local icon = i:CreateTexture(nil, 'BACKGROUND', nil, -6)
	icon:SetTexture(spellIcon)
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon:SetDesaturated(f.desaturate and 1 or nil)

	local border = i:CreateTexture(nil, 'BACKGROUND', nil, -4)
	border:SetTexture('Interface\\AddOns\\nSpellTracker\\media\\simplesquare_roth')
	border:SetVertexColor(0.37, 0.3, 0.3, 1)
	border:SetAllPoints(i)

	local time = i:CreateFontString(nil, 'BORDER')
	time:SetTextColor(1, 1, 1)

	local count = i:CreateFontString(nil, 'BORDER')
	count:SetTextColor(1, 1, 1)
	count:SetJustifyH('RIGHT')

	local value = i:CreateFontString(nil, 'BORDER')
	value:SetTextColor(1, 1, 1)
	value:SetJustifyH('CENTER')


	i.glow = glow
	i.back = back
	i.icon = icon
	i.border = border
	i.time = time
	i.count = count
	i.value = value

	i.data = f

	ApplySize(i)
	ApplyMoveFunctionality(i)

	if f.visibilityState then
		RegisterStateDriver(i, 'visibility', f.visibilityState)
	end

	f.iconframe = i
	f.name = spellName
	f.texture = spellIcon
end

local function CheckAura(f, spellID, filter)
	-- Make the icon visible in case we want to move it
	if not f.iconframe.locked then
		f.iconframe:SetAlpha(1)
		f.iconframe.icon:SetAlpha(1)
		f.iconframe.icon:SetDesaturated(nil)
		f.iconframe.time:SetText('30m')
		f.iconframe.count:SetText('3')
		f.iconframe.value:SetText('')
		return
	end

	if f.spec and not f:IsCurrentSpec() then
		f.iconframe:SetAlpha(0)
		return
	end

	if not UnitExists(f.unit) and f.validateUnit then
		f.iconframe:SetAlpha(0)
		return
	end

	if not InCombatLockdown() and f.hideOutOfCombat then
		f.iconframe:SetAlpha(0)
		return
	end

	local tmp_spellID = f.spellID
	if spellID then
		-- spellID gets overwritten for spell_lists
		tmp_spellID = spellID

		local name, _, icon = GetSpellInfo(spellID)
		if name then
			f.name = name
			f.iconframe.icon:SetTexture(icon)
		end
	end

	if f.name then
		local name, _, _, count, _, _, expires, caster, _, _, auraID, _, _, isCastByPlayer, value1, value2, value3 = UnitAura(f.unit, f.name, nil, filter)
		if name and (not f.isMine or (f.isMine and caster == 'player')) and (not f.matchspellID or (f.matchspellID and auraID == tmp_spellID)) then
			if caster == 'player' and config.highlightPlayerSpells then
				f.iconframe.border:SetVertexColor(0.2, 0.6, 0.8, 1)
			elseif config.highlightPlayerSpells then
				f.iconframe.border:SetVertexColor(0.37, 0.3, 0.3, 1)
			end

			f.iconframe.icon:SetAlpha(f.alpha.found.icon)
			f.iconframe:SetAlpha(f.alpha.found.frame)

			-- Exit the spell list search loop
			if spellID then
				f.auraFound = true
			end

			if f.desaturate then
				f.iconframe.icon:SetDesaturated(nil)
			end

			if count and count > 1 then
				f.iconframe.count:SetText(count)
			else
				f.iconframe.count:SetText('')
			end

			local timeRemaining = expires - GetTime()
			if timeRemaining < 3 then
				--f.iconframe.time:SetTextColor(1, 0.4, 0)
				f.iconframe.time:SetTextColor(1, 0, 0)
			else
				--f.iconframe.time:SetTextColor(1, 0.8, 0)
				f.iconframe.time:SetTextColor(1, 1, 1)
			end

			f.iconframe.time:SetText(GetFormattedTime(timeRemaining))

			if f.showValue then
				local value
				if f.showValue == 1 then
					value = value1
				elseif f.showValue == 2 then
					value = value2
				elseif f.showValue == 3 then
					value = value3
				end
				f.iconframe.value:SetText(FormatNumber(value) or '')
			end

			if f.PostUpdateHook then
				f.PostUpdateHook(f.iconframe, name, count)
			end
		else
			f.iconframe:SetAlpha(f.alpha.notFound.frame)
			f.iconframe.icon:SetAlpha(f.alpha.notFound.icon)

			if spellID then
				f.iconframe.icon:SetTexture(f.texture)
			end

			f.iconframe.time:SetText('')
			f.iconframe.count:SetText('')
			f.iconframe.value:SetText('')
			f.iconframe.time:SetTextColor(1, 0.8, 0)

			if config.highlightPlayerSpells then
				f.iconframe.border:SetVertexColor(0.37, 0.3, 0.3, 1)
			end

			if f.desaturate then
				f.iconframe.icon:SetDesaturated(1)
			end
		end
	end
end

local function CheckCooldown(f)
	-- Make the icon visible in case we want to move it
	if not f.iconframe.locked then
		f.iconframe:SetAlpha(1)
		f.iconframe.icon:SetAlpha(1)
		f.iconframe.icon:SetDesaturated(nil)
		f.iconframe.time:SetText('30m')
		f.iconframe.count:SetText('3')
		return
	end

	if f.spec and not f:IsCurrentSpec() then
		f.iconframe:SetAlpha(0)
		return
	end

	if not InCombatLockdown() and f.hideOutOfCombat then
		f.iconframe:SetAlpha(0)
		return
	end

	if f.name and f.spellID then
		local start, duration, _ = GetSpellCooldown(f:GetSpellID())

		if start and duration then
			local now = GetTime()
			local value = start + duration - now

			if value > 0 and duration > 2 then
				-- Item is on cooldown show time
				f.iconframe.icon:SetAlpha(f.alpha.cooldown.icon)
				f.iconframe:SetAlpha(f.alpha.cooldown.frame)
				f.iconframe.count:SetText('')
				f.iconframe.border:SetVertexColor(0.37, 0.3, 0.3, 1)

				if f.desaturate then
					f.iconframe.icon:SetDesaturated(1)
				end

				if value < 3 then
					--f.iconframe.time:SetTextColor(1, 0.4, 0)
					f.iconframe.time:SetTextColor(1, 0, 0)
				else
					--f.iconframe.time:SetTextColor(1, 0.8, 0)
					f.iconframe.time:SetTextColor(1, 1, 1)
				end

				f.iconframe.time:SetText(GetFormattedTime(value))
			else
				f.iconframe:SetAlpha(f.alpha.notCooldown.frame)
				f.iconframe.icon:SetAlpha(f.alpha.notCooldown.icon)
				f.iconframe.time:SetText('RDY')
				f.iconframe.count:SetText('')
				f.iconframe.time:SetTextColor(0, 0.8, 0)
				f.iconframe.border:SetVertexColor(0.4, 0.6, 0.2, 1)

				if f.desaturate then
					f.iconframe.icon:SetDesaturated(nil)
				end
			end

			if f.PostUpdateHook then
				f.PostUpdateHook(f.iconframe, duration)
			end
		end
	end
end

local function SearchAuras(list, filter)
	for i, _ in ipairs(list) do
		local f = list[i]

		if not f.iconframe:IsShown() then
			return
		end

		if type(f.spellID) == 'table' then
			f.auraFound = false

			for _, spellID in ipairs(f.spellID) do
				if not f.auraFound then
					CheckAura(f, spellID, filter)
				end
			end
		else
			CheckAura(f, nil, filter)
		end
	end
end

local function SearchCooldowns()
	for i, _ in ipairs(config.CooldownList) do
		local f = config.CooldownList[i]

		if not f.iconframe:IsShown() then
			return
		end

		if type(f.spellID) == 'table' then
			for _, spellID in ipairs(f.spellID) do
				local name, _, icon = GetSpellInfo(spellID)

				if GetSpellBookItemName(name) then
					f.spellID = spellID
					f.iconframe.icon:SetTexture(icon)
					break
				end
			end
		end

		CheckCooldown(f)
	end
end

local count = 0
local function GenerateIcons(list, type)
	for i, _ in ipairs(list) do
		local f = list[i]

		if not f.icon then
			CreateIcon(f, type)
		end

		count = count + 1
	end
end

GenerateIcons(config.BuffList, 'Buff')
GenerateIcons(config.DebuffList, 'Debuff')
GenerateIcons(config.CooldownList, 'Cooldown')

if count > 0 then
	local lastUpdate = 0
	CreateFrame('Frame'):SetScript('OnUpdate', function(self, elapsed)
		lastUpdate = lastUpdate + elapsed

		if lastUpdate > config.updatetime then
			SearchAuras(config.BuffList, 'HELPFUL')
			SearchAuras(config.DebuffList, 'HARMFUL')
			SearchCooldowns()
			lastUpdate = 0
		end
	end)
end
