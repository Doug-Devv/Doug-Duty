-- client.lua
local onDuty = false

RegisterNetEvent('duty:on')
AddEventHandler('duty:on', function(data)
    onDuty = true
    TriggerEvent('ox_lib:notify', {type = 'success', description = 'You are now on duty as ' .. data.name .. ' with callsign ' .. data.callsign})
    
    -- Example weapon loadout
    local loadouts = {
        LSPD = {"WEAPON_PISTOL", "WEAPON_STUNGUN", "WEAPON_CARBINERIFLE"},
        EMS = {"WEAPON_FLASHLIGHT", "WEAPON_FIREEXTINGUISHER"},
        SHERIFF = {"WEAPON_PUMPSHOTGUN", "WEAPON_COMBATPISTOL"}
    }

    if loadouts[data.department] then
        for _, weapon in ipairs(loadouts[data.department]) do
            GiveWeaponToPed(PlayerPedId(), GetHashKey(weapon), 999, false, true)
        end
    end
end)

RegisterNetEvent('duty:off')
AddEventHandler('duty:off', function()
    onDuty = false
    TriggerEvent('ox_lib:notify', {type = 'info', description = 'You are now off duty'})
    RemoveAllPedWeapons(PlayerPedId(), true)
end)

-- Duty UI through /duty command
RegisterCommand('duty', function()
    local input = lib.inputDialog('Go On Duty', {
        {type = 'select', label = 'Department', options = {'LSPD', 'EMS', 'SHERIFF'}},
        {type = 'input', label = 'Name', placeholder = 'John Doe'},
        {type = 'input', label = 'Callsign', placeholder = '123'}
    })

    if input then
        TriggerServerEvent('duty:toggle', {
            department = input[1],
            name = input[2],
            callsign = input[3]
        })
    else
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'Duty initiation canceled or invalid input.'})
    end
end, false)
 
