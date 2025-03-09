-- server.lua
local dutyStatus = {}
local dutyStartTimes = {}

RegisterNetEvent('duty:toggle')
AddEventHandler('duty:toggle', function(data)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)  -- Use index 0 for the primary identifier

    if IsPlayerAceAllowed(src, "duty." .. data.department) then
        dutyStatus[identifier] = not dutyStatus[identifier]
        if dutyStatus[identifier] then
            dutyStartTimes[identifier] = os.time()  -- Record the start time
            TriggerClientEvent('duty:on', src, data)
            TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You are now on duty as ' .. data.name .. ' with callsign ' .. data.callsign})
        else
            if dutyStartTimes[identifier] then
                local dutyDuration = os.time() - dutyStartTimes[identifier]
                local minutes = math.floor(dutyDuration / 60)
                TriggerClientEvent('ox_lib:notify', src, {type = 'info', description = 'You were on duty for ' .. minutes .. ' minutes.'})
                dutyStartTimes[identifier] = nil  -- Clear the start time
            end
            TriggerClientEvent('duty:off', src)
            TriggerClientEvent('ox_lib:notify', src, {type = 'info', description = 'You are now off duty'})
        end
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You do not have permission for this department!'})
    end
end)
