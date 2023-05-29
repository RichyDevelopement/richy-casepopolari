ESX = exports.es_extended:getSharedObject()



ESX.RegisterServerCallback("karos:inventario", function(playerId, cb)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    exports.ox_inventory:RegisterStash('Deposito:'..xPlayer.identifier, richy.Label, richy.Slots, richy.Peso*1000, nil)
    Citizen.Wait(200)
    cb('Deposito:'..xPlayer.identifier)
end)

RegisterServerEvent('richy:acquista')
AddEventHandler('richy:acquista', function(value)
    local xPlayer = ESX.GetPlayerFromId(source)
    local prezzokey = 2000 -- Prezzo dela chiave

    if value == 'key' then
        if xPlayer.getMoney() >= prezzokey then
            xPlayer.removeMoney(prezzokey)
            xPlayer.addInventoryItem('key', 1)
            TriggerClientEvent('pnpNotify:send', xPlayer.source, '<b><span style="color: #ff8c00;">Notifica</span></b> </br>Hai comprato la chiave')
        else
            TriggerClientEvent('pnpNotify:send', xPlayer.source, '<b><span style="color: #ff8c00;">Notifica</span></b> </br>Non hai abbastanza soldi')
        end
    end
end)


RegisterServerEvent('entraincasa')
AddEventHandler('entraincasa', function()

    SetPlayerRoutingBucket(source, source)
end)

RegisterServerEvent('escidallacasa')
AddEventHandler('escidallacasa', function()

    SetPlayerRoutingBucket(source, 0)
end)