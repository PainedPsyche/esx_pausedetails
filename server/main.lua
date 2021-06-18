ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

local playerData = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300)
        for k, v in pairs(playerData) do
            local name = v.name
            if v.firstname and v.lastname then
                name = v.firstname .. ' ' .. v.lastname
            end
            local data = {
                name = name,
                job = v.job,
                accounts = {
                    cash = v.getAccount('money'),
                    bank = v.getAccount('bank'),
                    black = v.getAccount('black_money'),
                }
            }
            TriggerClientEvent('esx:refreshDetailsData', v.source, data)
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    Citizen.CreateThread(function()
        if not playerData[source] then
            local queryComplete = false
            playerData[source] = xPlayer
            MySQL.ready(function()
                MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
                    ['@identifier'] = xPlayer.identifier
                }, function(result)
                    if result then
                        playerData[source].firstname = result[1].firstname
                        playerData[source].lastname = result[1].lastname
                    end
                    queryComplete = true
                end)
            end)

            while not queryComplete do
                Citizen.Wait(0)
            end
        end
    end)
end)

AddEventHandler('esx:playerDropped', function(source, reason)
    if playerData[source] then
        playerData[source] = nil
    end
end)
