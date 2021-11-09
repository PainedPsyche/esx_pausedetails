ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local charData = {}

RegisterNetEvent('esx:refreshDetailsData')
AddEventHandler('esx:refreshDetailsData', function(data)
    charData = data
end)

function SetHeadingDetailsCustom(slot, str)
    BeginScaleformMovieMethodOnFrontendHeader('SET_HEADING_DETAILS_CUSTOM')
    ScaleformMovieMethodAddParamInt(slot)
    ScaleformMovieMethodAddParamTextureNameString(str)
    EndScaleformMovieMethod()
end 

function SetHeadingDetailsAddition(slot, str)
    BeginScaleformMovieMethodOnFrontendHeader('SET_HEADING_DETAILS_ADDITION')
    ScaleformMovieMethodAddParamInt(slot)
    ScaleformMovieMethodAddParamTextureNameString(str)
    EndScaleformMovieMethod()
end 

function SetHeaderTitle(title)
    Citizen.InvokeNative(GetHashKey('ADD_TEXT_ENTRY'), 'FE_THDR_GTAO', title)
end

Citizen.CreateThread(function()
    while true do
        SetHeaderTitle('Custom ESX Dev Server')
        if GetPauseMenuState() > 0 then
            local accounts = charData.accounts
            local charInfo = charData.name .. ', ' .. charData.job.label .. ' ' .. charData.job.grade_label
            local accountsInfo = accounts.cash.label .. ' $' .. accounts.cash.money .. ' ' .. accounts.bank.label .. ' $' .. accounts.bank.money .. ' ' .. accounts.black.label .. ' $' .. accounts.black.money
            SetHeadingDetailsCustom(0, charInfo)
            SetHeadingDetailsCustom(2, string.upper(accountsInfo))
        end

        local playerBlip = GetMainPlayerBlipId()
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(charData.name)
        EndTextCommandSetBlipName(playerBlip)
        Citizen.Wait(100)
    end
end)