ESX = exports.es_extended:getSharedObject()

CreateThread(function()
    for i = 1, #richy.Popolare, 1 do
        local richy = richy.Popolare[i]

        if richy.blip.active then 
			local blip = AddBlipForCoord(richy.position.x, richy.position.y, richy.position.z)
			SetBlipSprite (blip, richy.blip.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, richy.blip.size)
			SetBlipColour (blip, richy.blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(richy.blip.name)
			EndTextCommandSetBlipName(blip)
        end
    end
end)

Citizen.CreateThread(function() 
    if not HasModelLoaded(richy.NomeNpc) then
       RequestModel(richy.NomeNpc)
       while not HasModelLoaded(richy.NomeNpc) do
          Citizen.Wait(5)
       end
    end
npc = CreatePed(4, richy.NomeNpc, richy.PosizioneNpc, false, true)
FreezeEntityPosition(npc, true)
SetEntityInvincible(npc, true)
SetBlockingOfNonTemporaryEvents(npc, true)

local VenditaChiave = false
local options = {
    
    {
        icon = 'fa-solid fa-key',
        label = 'Acquista Chiave',
		onSelect = function(data)
		TriggerEvent('richy:acquista')
		end,
        canInteract = function(entity)
            return not IsEntityDead(entity)
        end
    }
}

exports.ox_target:addLocalEntity(npc,options)

end)

local VenditaChiave = nil

RegisterNetEvent('richy:acquista')
AddEventHandler('richy:acquista', function(value)
    VenditaChiave = value
end)

RegisterNetEvent('richy:acquista') 
AddEventHandler('richy:acquista', function()
    local Ped = PlayerPedId()
    local input = lib.inputDialog('Parla con il venditore di case per acquistare la chiave', {
        {type = 'select', label = '$ Vendita di chiavi', options = {
            {label = "Vorrei Acquistare Una Casa Popolare (2.000$)", value = "key"},
        }},
    })
    
    if input and #input > 0 then
        TriggerServerEvent('richy:acquista', input[1])
    end
end)


-- Definisci la zona di entrata nella casa popolare
local casaPopolareEntrata = {
    coords = richy.EntrataCasa,
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'casepopolari',
            icon = 'fa-solid fa-home',
            label = richy.Traduzione["entra"],
            onSelect = function(data)
                -- Controlla se il giocatore ha la chiave per entrare nella casa popolare
                if HasKey("key") then -- Item 
                    DoScreenFadeOut(800)
                    while not IsScreenFadedOut() do
                        Citizen.Wait(0)
                    end
                    TriggerServerEvent('entraincasa')
                    SetEntityCoords(PlayerPedId(), richy.TeleportEntrata)
                    DoScreenFadeIn(800)
                else
                    -- Mostra un messaggio di errore se il giocatore non ha la chiave
					lib.notify({
						title = 'Casa Popolare',
						description = 'Non hai la chiave per entrare in casa!',
						type = 'error'
					})
                    
                end
            end,
        },
    },
}


-- Definisci la zona di uscita dalla casa popolare
local casaPopolareUscita = {
    coords = richy.UscitaCasa,
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'casepopolariuscita',
            icon = 'fa-solid fa-home',
            label = richy.Traduzione["esci"],
            onSelect = function(data)
                -- Controlla se il giocatore ha la chiave per entrare nella casa popolare
                if HasKey("key") then -- Item 
                    DoScreenFadeOut(800)
                    while not IsScreenFadedOut() do
                        Citizen.Wait(0)
                    end
                    TriggerServerEvent('escidallacasa')
                    SetEntityCoords(PlayerPedId(), richy.TeleportUscita)
                    DoScreenFadeIn(800)
                else
                    -- Mostra un messaggio di errore se il giocatore non ha la chiave
					lib.notify({
						title = 'Casa Popolare',
						description = 'Non hai la chiave per uscire di casa!',
						type = 'error'
					})
                    
                end
            end,
        },
    },
}


-- Aggiungi le zone al sistema di trigger della mappa
Citizen.CreateThread(function()
    exports.ox_target:addBoxZone(casaPopolareEntrata)
    exports.ox_target:addBoxZone(casaPopolareUscita)
end)

-- Controlla se il giocatore ha la chiave "CasaPopolare" nell'inventario
function HasKey(keyName)
    local player = GetPlayerPed(-1)
    local inventory = ESX.GetPlayerData().inventory
    for i = 1, #inventory do
        local item = inventory[i]
        if item and item.name == keyName then
            return true
        end
    end
    return false
end


exports.ox_target:addBoxZone({
	coords = richy.FrigoPopolare,
	size = vec3(2, 2, 2),
	rotation = 45,
	debug = drawZones,
	options = {
		{
			name = 'casepopolari',
			icon = 'fa-solid fa-home',
			label = richy.Traduzione["frigobar"],
			onSelect = function(data)
				-- Frigo Bar delle case popolari
			exports.ox_inventory:openInventory('shop', { type = 'CasaPopolare', id = 1})
			
			end,
		}
	}
})

exports.ox_target:addBoxZone({
	coords = richy.InventarioPopolare,
	size = vec3(2, 2, 2),
	rotation = 45,
	debug = drawZones,
	options = {
		{
			name = 'casepopolari',
			icon = 'fa-solid fa-home',
			label = richy.Traduzione["inventario"],
			onSelect = function(data)
				ESX.TriggerServerCallback('karos:inventario', function(Karos)
					if(Karos) then
						-- Apre il deposito della casa popolare
						exports.ox_inventory:openInventory('stash', Karos)
					end
				end)
			end,
		}
	}
})


exports.ox_target:addBoxZone({
	coords = richy.Guardaroba,
	size = vec3(2, 2, 2),
	rotation = 45,
	debug = drawZones,
	options = {
		{
			name = 'casepopolari',
			icon = 'fa-solid fa-home',
			label = richy.Traduzione["camerino"],
			onSelect = function(data)
				-- Apre il guardaroba della casa popolare
                exports['fivem-appearance']:openWardrobe()
			end,
		}
	}
})
