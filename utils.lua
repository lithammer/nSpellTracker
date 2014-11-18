local _, addon = ...

-- Recursive merging of table t2 into table t1
function addon:MergeTables(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == 'table') and (type(t1[k] or false) == 'table') then
            MergeTables(t1[k], t2[k])
        else
            t1[k] = v
        end
    end

    return t1
end

function addon:Round(n)
    return math.floor(n + 0.5)
end
