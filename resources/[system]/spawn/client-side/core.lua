-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("spawn",cRP)
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Peds = {}
local Locate = {}
local Camera = nil
local Destroy = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local pedCoords = {
	{ -858.19,-109.25,28.19,209.77,"random@shop_tattoo","_idle_a" },
	{ -857.28,-108.79,28.19,209.77,"anim@heists@heist_corona@single_team","single_team_loop_boss" },
	{ -859.02,-109.78,28.19,209.77,"jh_1_ig_3-2","cs_jewelass_dual-2" },
	{ -856.44,-108.26,28.19,209.77,"oddjobs@taxi@","idle_a" },
	{ -859.95,-110.17,28.19,209.77,"amb@world_human_bum_standing@twitchy@base","base" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OTHERLOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local otherLocates = {
	{ 55.26,-879.78,30.35,"Great Ocean Highway" },
	{ 1622.56,3568.96,35.15,"Duluoz Avenue" },
	{ -133.74,6353.28,31.49,"Grapedseed Avenue" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

	DoScreenFadeOut(0)
	ShutdownLoadingScreen()

	Wait(1000)

	local ped = PlayerPedId()
	Camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",667.43,1025.9,378.87,340.0,0.0,342.0,60.0,false,0)
	SetCamActive(Camera,true)
	RenderScriptCams(true,false,1,true,true)
	SendNUIMessage({ action = "openSystem" })
	TriggerEvent("player:playerInvisible",true)
	SetEntityVisible(ped,false,false)
	SetEntityHealth(ped,101)
	SetNuiFocus(true,true)

	Wait(1000)

	DoScreenFadeIn(1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("generateDisplay",function(data,cb)
	cb({ result = vSERVER.initSystem() })
	
	DoScreenFadeIn(1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("characterChosen",function(data)
	for k,v in pairs(Peds) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end

	vSERVER.characterChosen(data["id"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("newCharacter",function(data)
	vSERVER.newCharacter(data["name"],data["name2"],data["sex"],data["loc"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("generateSpawn",function(data,cb)
	cb({ result = Locate })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JUSTSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:justSpawn")
AddEventHandler("spawn:justSpawn",function(Spawned)
	DoScreenFadeOut(0)

	local Ped = PlayerPedId()
	RenderScriptCams(false,false,0,true,true)
	SetCamActive(Camera,false)
	DestroyCam(Camera,true)
	Camera = nil

	if Spawned then
		LocalPlayer["state"]["Invisible"] = true
		SetEntityVisible(Ped,false,false)

		Locate = {}
		local Number = 0
		for k,v in pairs(otherLocates) do
			Number = Number + 1
			Locate[Number] = { x = v[1], y = v[2], z = v[3], name = v[4], hash = Number }
		end

		Wait(2000)

		local Coords = GetEntityCoords(Ped)
		Camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",Coords["x"],Coords["y"],Coords["z"] + 200.0,270.00,0.0,0.0,80.0,0,0)
		SetCamActive(Camera,true)
		RenderScriptCams(true,false,1,true,true)

		SendNUIMessage({ action = "openSpawn" })

		DoScreenFadeIn(1000)
	else
		LocalPlayer["state"]["Invisible"] = false
		SetEntityVisible(Ped,true,false)
		TriggerEvent("hudActived",true)
		SetNuiFocus(false,false)
		Destroy = false

		Wait(1000)

		DoScreenFadeIn(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSENEW
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.closeNew()
	SendNUIMessage({ action = "closeNew" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("spawnChosen",function(data)
	local ped = PlayerPedId()

	if data["hash"] == "spawn" then
		DoScreenFadeOut(0)

		SendNUIMessage({ action = "closeSpawn" })
		TriggerEvent("hudActived",true)
		SetNuiFocus(false,false)

		LocalPlayer["state"]["Invisible"] = false
		RenderScriptCams(false,false,0,true,true)
		SetCamActive(Camera,false)
		DestroyCam(Camera,true)
		SetEntityVisible(ped,true,false)
		Camera = nil
		Destroy = false

		Wait(1000)

		DoScreenFadeIn(1000)
	else
		Destroy = false
		DoScreenFadeOut(0)

		Wait(1000)

		SetCamRot(Camera,270.0)
		SetCamActive(Camera,true)
		Destroy = true
		local speed = 0.7
		weight = 270.0

		DoScreenFadeIn(1000)

		SetEntityCoords(ped,Locate[data["hash"]]["x"],Locate[data["hash"]]["y"],Locate[data["hash"]]["z"],false,false,false,false)
		local coords = GetEntityCoords(ped)

		SetCamCoord(Camera,coords["x"],coords["y"],coords["z"] + 200.0)
		local i = coords["z"] + 200.0

		while i > Locate[data["hash"]]["z"] + 1.5 do
			i = i - speed
			SetCamCoord(Camera,coords["x"],coords["y"],i)

			if i <= Locate[data["hash"]]["z"] + 35.0 and weight < 360.0 then
				if speed - 0.0078 >= 0.05 then
					speed = speed - 0.0078
				end

				weight = weight + 0.75
				SetCamRot(Camera,weight)
			end

			if not Destroy then
				break
			end

			Wait(0)
		end
	end
end)