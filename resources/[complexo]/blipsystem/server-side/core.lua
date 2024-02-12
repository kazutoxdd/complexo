-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("blipsystem",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Players = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.playerList()
	for k,v in pairs(Players) do
		local Ped = GetPlayerPed(k)
		if DoesEntityExist(Ped) then
			v["Coords"] = GetEntityCoords(Ped)
		end
	end

	return Players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:Enter")
AddEventHandler("blipsystem:Enter",function(source,Service,Connect)
	Players[source] = {
		["Coords"] = vec3(0,0,0),
		["service"] = Service
	}

	for k,v in pairs(Players) do
		if k ~= source then
			TriggerClientEvent("blipsystem:Enter",k,source,Players[source])
		end
	end

	if Connect then
		TriggerClientEvent("blipsystem:Full",source,Players)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:EXIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("blipsystem:Exit",function(source)
	if Players[source] then
		Players[source] = nil
		TriggerClientEvent("blipsystem:Clear",source)

		for k,v in pairs(Players) do
			if k ~= source then
				TriggerClientEvent("blipsystem:Exit",k,source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id,source)
	if Players[source] then
		Players[source] = nil

		for k,v in pairs(Players) do
			TriggerClientEvent("blipsystem:Exit",k,source)
		end
	end
end)