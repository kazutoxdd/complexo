-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("blipsystem")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {}
local Players = {}
local Pause = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLORS
-----------------------------------------------------------------------------------------------------------------------------------------
local Colors = {
	["Corrections"] = 60,
	["Ranger"] = 69,
	["State"] = 7,
	["Police"] = 63,
	["Sheriff"] = 47,
	["Paramedic"] = 6,
	["Prisioneiro"] = 33,
	["Corredor"] = 32
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] then
			if LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Paramedic"] then
				if IsPauseMenuActive() then
					if not Pause then
						Pause = true

						for k,v in pairs(Blips) do
							RemoveBlip(Blips[k])
							Blips[k] = nil
						end
					end

					local playerList = vSERVER.playerList()

					for k,v in pairs(playerList) do
						if Blips[k] then
							SetBlipCoords(Blips[k],v["Coords"])
						else
							Blips[k] = AddBlipForCoord(v["Coords"])
							SetBlipSprite(Blips[k],1)
							SetBlipDisplay(Blips[k],4)
							SetBlipAsShortRange(Blips[k],true)
							SetBlipColour(Blips[k],Colors[v["service"]])
							SetBlipScale(Blips[k],0.7)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString("! "..v["service"])
							EndTextCommandSetBlipName(Blips[k])
						end
					end
				else
					if Pause then
						Pause = false

						for k,v in pairs(Blips) do
							RemoveBlip(Blips[k])
							Blips[k] = nil
						end
					end

					local tableActive = activePlayers()

					for k,v in pairs(Players) do
						if tableActive[k] then
							if Blips[k] == nil then
								local source = GetPlayerFromServerId(k)
								local Ped = GetPlayerPed(source)

								Blips[k] = AddBlipForEntity(Ped)
								SetBlipSprite(Blips[k],1)
								SetBlipDisplay(Blips[k],4)
								SetBlipShowCone(Blips[k],true)
								SetBlipAsShortRange(Blips[k],true)
								SetBlipColour(Blips[k],Colors[v["service"]])
								SetBlipScale(Blips[k],0.7)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("! "..v["service"])
								EndTextCommandSetBlipName(Blips[k])
							end
						else
							if Blips[k] then
								RemoveBlip(Blips[k])
								Blips[k] = nil
							end
						end
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:FULL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:Full")
AddEventHandler("blipsystem:Full",function(Table)
	Players = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:Enter")
AddEventHandler("blipsystem:Enter",function(source,Table)
	Players[source] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:EXIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:Exit")
AddEventHandler("blipsystem:Exit",function(source)
	if Players[source] then
		Players[source] = nil
	end

	if Blips[source] then
		if DoesBlipExist(Blips[source]) then
			RemoveBlip(Blips[source])
			Blips[source] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:CLEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:Clear")
AddEventHandler("blipsystem:Clear",function()
	for k,v in pairs(Blips) do
		RemoveBlip(Blips[k])
	end

	Pause = false
	Players = {}
	Blips = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function activePlayers()
	local PlayerList = {}

	for k,v in ipairs(GetActivePlayers()) do
		PlayerList[GetPlayerServerId(v)] = true
	end

	return PlayerList
end