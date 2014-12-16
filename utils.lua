local _, addon = ...

function addon:Round(n)
    return math.floor(n + 0.5)
end
