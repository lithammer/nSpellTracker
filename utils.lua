local _, addon = ...

addon.config = {}
addon.config.BuffList = {}
addon.config.DebuffList = {}
addon.config.CooldownList = {}

local function GenerateDefault()
	local default = {
		spec = nil,
		spellID = nil,
		size = 36,
		position = {'CENTER'},
		unit = 'player',
		visibilityState = nil,
		validateUnit = true,
		hideOutOfCombat = false,
		isMine = false,
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
	}
	return default
end

-- Recursive merging of table t2 into table t1
local function MergeTables(t1, t2)
	for k, v in pairs(t2) do
        if (type(v) == 'table') and (type(t1[k] or false) == 'table') then
            MergeTables(t1[k], t2[k])
        else
            t1[k] = v
        end
    end

    return t1
end

function addon:Round(num, idp)
	local mult = 10^(idp or 0)
	return floor(num * mult + 0.5) / mult
end

function addon:AddSpell(list, spell)
	function spell:IsCurrentSpec()
		if type(self.spec) == 'table' then
			for _, v in ipairs(self.spec) do
				if v == GetSpecialization() then
					return true
				end
			end

			return false
		end

		return self.spec == GetSpecialization()
	end

	function spell:GetSpellID()
		return type(self.spellID) == 'table' and self.spellID[1] or self.spellID
	end

	spell = MergeTables(GenerateDefault(), spell)
	table.insert(list, spell)
end

function addon:Debuff(debuff)
	self:AddSpell(self.config.DebuffList, debuff)
end

function addon:Buff(buff)
	self:AddSpell(self.config.BuffList, buff)
end

function addon:Cooldown(cooldown)
	self:AddSpell(self.config.CooldownList, cooldown)
end

addon.buffs = {
	stats = {1126, 115921, 20217, 90363},
	stamina = {21562, 103127, 469, 90364},
	attackPower = {57330, 19506, 6673},
	spellPower = {109773, 1459, 61316, 77747, 126309},
	haste = {113742, 30809, 55610, 128432, 128433},
	spellHaste = {24907, 49868, 51470},
	criticalStrike = {116781, 17007, 1459, 61316, 97229, 24604, 90309, 126373, 126309},
	mastery = {19740, 116956, 93435, 128997}
}

addon.debuffs = {
	weakenedArmor = 113746,
	physicalVulnerability = 81326,
	magicVulnerability = {1490, 104225, 116202, 93068, 34889, 24844},
	weakenedBlows = {115798, 50256, 24423},
	slowCasting = {73975, 5760, 109466, 50274, 90314, 126402, 58604},
	mortalWounds = {115804, 8680, 82654, 54680}
}
