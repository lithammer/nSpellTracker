if select(2, UnitClass('player')) ~= 'WARLOCK' then return end

local _, addon = ...
local playerName, _ = UnitName('player')

--[[
Default values:

spec = nil,
spellID = nil,
size = 36,
position = {'CENTER'},
unit = 'player',
visibilityState = nil,
validateUnit = true,
hideOutOfCombat = true,
isMine = true,
desaturate = true,
matchSpellID = true,
movable = true,
alpha = {
	found = {
		frame = 1,
		icon = 1,
	},
	notFound = {
		frame = 0.4,
		icon = 0.6,
	},
	cooldown = {
		frame = 1,
		icon = 0.6,
	},
	notCooldown = {
		frame = 1,
		icon = 1,
	},
},
]]--

addon:Debuff({
	spellID = 48181, -- Haunt
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 42},
	unit = 'target',
	movable = false,
})

addon:Debuff({
	spellID = 30108, -- Unstable Affliction
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 42},
	unit = 'target',
	movable = false,
})

addon:Debuff({
	spellID = 348, -- Immolate
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 42},
	unit = 'target',
	movable = false,
})

addon:Debuff({
	spellID = 172, -- Corruption
	spec = {1, 2},
	position = {'CENTER', 'UIParent', 'CENTER', -210, 0},
	unit = 'target',
	desaturate = true,
	movable = false,
})

addon:Debuff({
	spellID = 980, -- Agony
	spec = 1,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	unit = 'target',
	movable = false,
})

addon:Debuff({
	spellID = 47960, -- Shadowflame
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 42},
	unit = 'target',
	movable = false,
})

addon:Debuff({
	spellID = 603, -- Doom
	spec = 2,
	size = 36,
	position = {'CENTER', 'UIParent', 'CENTER', -210, -42},
	unit = 'target',
	desaturate = true,
	movable = false,
	alpha = {
		notFound = {
			frame = 0,
			icon = 0,
		}
	},
})

--[[
addon:Debuff({
	spellID = addon.debuffs.magicVulnerability,
	position = {'BOTTOM', 'UIParent', 'BOTTOM', 0, 210},
	movable = false,
	unit = 'target',
	isMine = false,
})
]]--

addon:Buff({
	spellID = {113858, 113860, 113861}, -- Dark Soul
	position = {'CENTER', 'UIParent', 'CENTER', 150, 42},
	movable = false,
	alpha = {
		notFound = {
			frame = 0,
			icon = 0,
		}
	},
})

addon:Buff({
	spellID = 117896, -- Backdraft
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 0},
	movable = false,
})

addon:Buff({
	spellID = 111400, -- Burning Rush
	position = {'CENTER', 'UIParent', 'CENTER', 100, -42},
	hideOutOfCombat = false,
	movable = false,
	alpha = {
		notFound = {
			frame = 0,
			icon = 0,
		}
	},
})

addon:Cooldown({
	spellID = 113860, -- Dark Soul: Misery
	position = {'CENTER', 'UIParent', 'CENTER', -294, 42},
	spec = 1,
	movable = false,
	matchSpellID = false,
	alpha = {
		cooldown = {
			frame = 0.8,
			icon = 0.4,
		},
		notCooldown = {
			frame = 0.8,
			icon = 0.8,
		}
	}
})

addon:Cooldown({
	spellID = 113858, -- Dark Soul: Instability
	position = {'CENTER', 'UIParent', 'CENTER', -294, 42},
	spec = 3,
	movable = false,
	matchSpellID = false,
	alpha = {
		cooldown = {
			frame = 0.8,
			icon = 0.4,
		},
		notCooldown = {
			frame = 0.8,
			icon = 0.8,
		}
	}
})

addon:Cooldown({
	spellID = 113861, -- Dark Soul: Knowledge
	position = {'CENTER', 'UIParent', 'CENTER', -294, 42},
	spec = 2,
	movable = false,
	matchSpellID = false,
	alpha = {
		cooldown = {
			frame = 0.8,
			icon = 0.4,
		},
		notCooldown = {
			frame = 0.8,
			icon = 0.8,
		}
	}
})

local _, _, _, _, selected = GetTalentInfo(14)
if selected then
	addon:Cooldown({
		spellID = 111898, -- Grimoire: Felguard
		spec = 2,
		position = {'CENTER', 'UIParent', 'CENTER', -294, 0},
		movable = false,
		alpha = {
			cooldown = {
				frame = 0.8,
				icon = 0.4,
			},
			notCooldown = {
				frame = 0.8,
				icon = 0.8,
			}
		}
	})
end

addon:Cooldown({
	spellID = 17962, -- Conflagrate
	spec = 3,
	position = {'CENTER', 'UIParent', 'CENTER', -252, 42},
	movable = false,
})

addon:Cooldown({
	spellID = 105174, -- Hand of Gul'dan
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 42},
	movable = false,
	PostUpdateHook = function(iconframe, duration)
		local charges, _, timeLastCast = GetSpellCharges(105174)
		local name, _, _, count, _, _, expires, caster = UnitAura('target', 'Shadowflame', nil, 'HARMFUL')

		if charges == 1 and GetTime() - timeLastCast < 9 then
			iconframe.border:SetVertexColor(1, 0, 0)
		end

		if charges == 1 and caster then
			iconframe.border:SetVertexColor(0.4, 0.6, 0.2)
		end
	end
})

addon:Cooldown({
	spellID = 119914, -- Felstorm
	spec = 2,
	position = {'CENTER', 'UIParent', 'CENTER', -210, 84},
	movable = false,
	alpha = {
		cooldown = {
			frame = 0,
			icon = 0,
		}
	}
})
