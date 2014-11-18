local _, addon = ...
if addon.playerClass ~= 'WARRIOR' then return end

-- Shield Block
addon:Buff(132404, {
    position = {'CENTER', 'UIParent', 'CENTER', 0, -250},
    spec = 3,
    size = 52
})
