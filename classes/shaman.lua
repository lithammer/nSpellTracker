local _, addon = ...
if addon.playerClass ~= 'SHAMAN' then return end

-- Lightning Shield
addon:Buff(192106, {
    position = {'CENTER', 'UIParent', 'CENTER', 100, -42},
	size = 50,
	hideOutOfCombat = false,
	showMissing = true,
	visibilityState = '[petbattle] [vehicleui] hide; show',
	matchSpellID = true,
	alpha = {
		found = {
			icon = 0,
		},
		notFound = {
			icon = 1,
		},
	},
	-- glowOverlay = {
		-- shineType = 'Blizzard',
		-- reqAlpha = 0, --required alpha level to show, default is zero
		-- color = {r,g,b,a}, --  Default value is {0.95, 0.95, 0.32, 1}
		-- frequency = 0.125, --  Default value is 0.125
	-- },
	-- glowOverlay = {
		-- shineType = 'PixelGlow',
		-- reqAlpha = 0.5, --required alpha level to show, default is zero
		-- color = {242, 5/255, 5/255, 1}, --  Default value is {0.95, 0.95, 0.32, 1}
		-- numLines = 8, --default is 8
		-- frequency = 0.25, -- frequency, set to negative to inverse direction of rotation. Default value is 0.25;
		-- lineLength = nil, --length of lines, common is 10-15. Default = nil, will set line length depending on dimensions of glow frame
		-- lineThickness = 2, --line thickness, default value is 1
		-- xOffset = 0, --- offset of glow relative to region border;
		-- yOffset = 0, --- offset of glow relative to region border;
		-- border = false,  -- set to true to create border under lines;
	-- },
	glowOverlay = {
		shineType = 'AutoCastGlow',
		reqAlpha = 0.5, --required alpha level to show, default is zero
		color = {242, 5/255, 5/255, 1}, --  Default value is {0.95, 0.95, 0.32, 1}
		numParticle = 8, --default is 8, number of particles to show
		frequency = 0.25, -- frequency, set to negative to inverse direction of rotation. Default value is 0.25;
		particleScale = 1, --scale of the particles, default is 1
		xOffset = 0, --- offset of glow relative to region border;
		yOffset = 0, --- offset of glow relative to region border;
	},
	-- glowOverlay = {
		-- shineType = 'ButtonGlow',
		-- reqAlpha = 0.5, --required alpha level to show, default is zero
		-- color = {242, 5/255, 5/255, 1}, --  Default value is {0.95, 0.95, 0.32, 1}
		-- frequency = 0.25, -- frequency, set to negative to inverse direction of rotation. Default value is 0.25;
	-- },
})



	
--local affliction, demonology, destruction = 1, 2, 3

-- -- Ulthalesh, Deadwind Harvester
-- addon:Buff(216708, {
    -- spec = affliction,
    -- position = {'CENTER', 'UIParent', 'CENTER', 150, 42},
    -- PostUpdateHook = function(self)
        -- local count = select(4, UnitBuff('player', 'Tormented Souls'))
        -- if count and count > 0 then
            -- self.Icon.Count:SetText(count)
        -- else
            -- self.Icon.Count:SetText()
        -- end
    -- end
-- })


    -- position = {'CENTER', 'UIParent', 'CENTER', 0, -250},
    -- spec = 3,
    -- size = 52
	
	
-- -- Burning Rush
-- addon:Buff(111400, {
    -- position = {'CENTER', 'UIParent', 'CENTER', 100, -42},
    -- verifySpell = true,
    -- hideOutOfCombat = false
-- })

-- -- Grimoire: Felhunter
-- addon:Cooldown(111897, {
    -- position = {'CENTER', 'UIParent', 'CENTER', -252, 0}
-- })


-- -- Demonic Empowerment
-- addon:Buff(193396, {
    -- spec = demonology,
    -- unit = 'pet',
    -- position = {'CENTER', 'UIParent', 'CENTER', -210, 0}
-- })


-- -- Arcane Charge
-- addon:Debuff(36032, {
    -- spec = 1,
    -- size = 50,
    -- position = {'CENTER', 'UIParent', 'CENTER', 0, -250},
    -- unit = 'player'
-- })


--glowOverlay = true
