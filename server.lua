local dutyStatus = {}

RegisterNetEvent('duty:toggle')
AddEventHandler('duty:toggle', function(data)
    local src = source
    local identifier = GetPlayerIdentifier(src, 1)

    if IsPlayerAceAllowed(src, "duty." .. data.department) then
        dutyStatus[identifier] = not dutyStatus[identifier]
        if dutyStatus[identifier] then
            TriggerClientEvent('duty:on', src, data)
        else
            TriggerClientEvent('duty:off', src)
        end
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You do not have permission for this department!'})
    end
end)
