-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = "Santos"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERTABLET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:enterTablet")
AddEventHandler("tablet:enterTablet",function(Select)
	if LocalPlayer["state"]["Route"] < 900000 then
		local ped = PlayerPedId()
		if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and GetEntityHealth(ped) > 100 and MumbleIsConnected() then
			Open = Select
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "openSystem" })


			if not IsPedInAnyVehicle(Ped) then
				vRP.removeObjects()
				vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "closeSystem" })
	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarros",function(data,cb)
	cb({ result = GlobalState["Cars"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMotos",function(data,cb)
	cb({ result = GlobalState["Bikes"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestAluguel",function(data,cb)
	cb({ result = GlobalState["Rental"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSERVICOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestServicos",function(data,cb)
	cb({ result = GlobalState["Works"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPossuidos",function(data,cb)
	cb({ result = vSERVER.requestPossuidos() })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTAX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestTax",function(data,cb)
	vSERVER.requestTax(data["name"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestSell",function(data,cb)
	vSERVER.requestSell(data["name"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestBuy",function(data)
	if MumbleIsConnected() then
		vSERVER.requestBuy(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestRental",function(data)
	if MumbleIsConnected() then
		vSERVER.requestRental(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Update")
AddEventHandler("tablet:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVEABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehDrive = nil
local benDrive = false
local benCoords = { -55.27,-1096.4,26.42 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestDrive",function(data,cb)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(benCoords[1],benCoords[2],benCoords[3]))

	if distance <= 3 then
		vRP.removeObjects()
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "closeSystem" })

		local driveIn,vehPlate = vSERVER.startDrive()
		if driveIn then
			TriggerEvent("races:insertList",true)
			LocalPlayer["state"]["Commands"] = true
			TriggerEvent("Notify","azul","Teste iniciado, para finalizar saia do veículo.",5000)

			Wait(1000)

			vehCreate(data["name"],vehPlate)

			Wait(1000)

			SetPedIntoVehicle(ped,vehDrive,-1)
			benDrive = true
		end
	else
		TriggerEvent("Notify","amarelo","Dirija-se até a <b>Benefactor</b> para efetuar o teste.",2000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName,vehPlate)
	local mHash = GetHashKey(vehName)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Wait(1)
	end

	if HasModelLoaded(mHash) then
		vehDrive = CreateVehicle(mHash,-53.9,-1110.5,26.34,68.04,false,false)

		SetEntityInvincible(vehDrive,true)
		SetVehicleNumberPlateText(vehDrive,vehPlate)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if benDrive then
			timeDistance = 1
			DisableControlAction(1,69,false)

			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				Wait(1000)

				benDrive = false
				vSERVER.removeDrive()
				TriggerEvent("races:insertList",false)
				LocalPlayer["state"]["Commands"] = false
				SetEntityCoords(ped,benCoords[1],benCoords[2],benCoords[3],false,false,false,false)
				DeleteEntity(vehDrive)
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local initVehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicles = {
	{
		["coords"] = vec3(-42.39,-1101.32,26.98),
		["heading"] = 19.85,
		["model"] = "sunrise",
		["distance"] = 100
	},{
		["coords"] = vec3(-54.61,-1096.86,26.98),
		["heading"] = 31.19,
		["model"] = "teslamodels",
		["distance"] = 100
	},{
		["coords"] = vec3(-47.57,-1092.05,26.98),
		["heading"] = 283.47,
		["model"] = "corvettec7",
		["distance"] = 100
	},{
		["coords"] = vec3(-37.02,-1093.42,26.98),
		["heading"] = 206.93,
		["model"] = "bugattiatlantic",
		["distance"] = 100
	},{
		["coords"] = vec3(-49.78,-1083.86,26.98),
		["heading"] = 65.2,
		["model"] = "dodgechargerrt69",
		["distance"] = 100
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(Vehicles) do
			local distance = #(coords - v["coords"])
			if distance <= v["distance"] then
				if initVehicles[k] == nil then
					local mHash = GetHashKey(v["model"])

					RequestModel(mHash)
					while not HasModelLoaded(mHash) do
						Wait(1)
					end

					if HasModelLoaded(mHash) then
						local Color = math.random(112)
						initVehicles[k] = CreateVehicle(mHash,v["coords"],v["heading"],false,false)
						SetVehicleNumberPlateText(initVehicles[k],"PDMSPORT")
						SetVehicleColours(initVehicles[k],Color,Color)
						FreezeEntityPosition(initVehicles[k],true)
						SetVehicleDoorsLocked(initVehicles[k],2)
						SetModelAsNoLongerNeeded(mHash)
					end
				end
			else
				if initVehicles[k] then
					if DoesEntityExist(initVehicles[k]) then
						DeleteEntity(initVehicles[k])
						initVehicles[k] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)