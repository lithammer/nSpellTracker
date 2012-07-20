local _, addon = ...

addon.config = {}
addon.config.BuffList = {}
addon.config.DebuffList = {}
addon.config.CooldownList = {}

local GenerateDefault = function()
	local default = {
		spec = nil,
		spellid = nil,
		size = 36,
		pos = {a1 = 'CENTER', a2 = 'CENTER', af = 'UIParent', x = 0, y = 0},
		unit = 'player',
		visibility_state = nil,
		validate_unit = true,
		hide_ooc = false,
		is_mine = false,
		desaturate = true,
		match_spellid = true,
		move_ingame = true,
		alpha = {
			found = {
				frame = 1,
				icon = 1,
			},
			not_found = {
				frame = 0.4,
				icon = 0.6,
			},
			cooldown = {
				frame = 1,
				icon = 0.6,
			},
			no_cooldown = {
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

function addon:Debuff(debuff)
	debuff = MergeTables(GenerateDefault(), debuff)
	table.insert(self.config.DebuffList, debuff) 
end

function addon:Buff(buff)
	buff = MergeTables(GenerateDefault(), buff)
	table.insert(self.config.BuffList, buff) 
end

function addon:Cooldown(cooldown)
	cooldown = MergeTables(GenerateDefault(), cooldown)
	table.insert(self.config.CooldownList, cooldown) 
end

addon.buffs = {
	stats = {1126, 115921, 20217},
	stamina = {21562, 103127, 469},
	attackPower = {57330, 19506, 6673},
	spellPower = {109773, 1459, 61316, 77747},
	haste = {113742, 30809, 55610},
	spellHaste = {24907, 15473, 51470},
	criticalStrike = {17007, 1459, 61316},
	mastery = {116781, 19740, 116956}
}

addon.debuffs = {
	weakenedArmor = 113746,
	physicalVulnerability = 81326,
	magicVulnerability = {1490, 93068},
	weakenedBlows = 115798,
	slowCasting = {73975, 5760, 109466},
	mortalWounds = 115804
}
