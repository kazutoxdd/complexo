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
cRP = {}
Tunnel.bindInterface("hud",cRP)
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local showHud = false
local clientStress = 0
local showMovie = false
local radioDisplay = ""
local pauseBreak = false
local clientHunger = 100
local clientThirst = 100
local homeInterior = false
local playerActive = true
local flexDirection = "Norte"
local updateFoods = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
local nitroFuel = 0
local nitroFlame = false
local nitroActive = false
local nitroButton = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIGHTTRAILS
-----------------------------------------------------------------------------------------------------------------------------------------
local LightTrails = {}
local LightParticles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
local PurgeSprays = {}
local PurgeParticles = {}
local sprayActive = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local beltSpeed = 0
local beltLock = false
local beltVelocity = vector3(0,0,0)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVINABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local divingMask = nil
local divingTank = nil
local clientOxigen = 100
local divingTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOCKVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local clockHours = 18
local clockMinutes = 0
local weatherSync = "CLEAR"
local timeDate = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function(user_id)
	playerActive = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mumble = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLECONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleConnected",function()
	if not Mumble then
		SendNUIMessage({ mumble = false })
		Mumble = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLEDISCONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleDisconnected",function()
	if Mumble then
		SendNUIMessage({ mumble = true })
		Mumble = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Voip")
AddEventHandler("hud:Voip",function(number)
	local Number = tonumber(number)
	local voiceTarget = { "Baixo","Médio","Alto","Muito Alto" }

	SendNUIMessage({ voice = voiceTarget[Number] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:QrFodase")
AddEventHandler("hud:QrFodase",function(Status)
	SendNUIMessage({ qrcode = Status })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if playerActive then
			if divingMask ~= nil then
				if GetGameTimer() >= divingTimers then
					divingTimers = GetGameTimer() + 35000
					clientOxigen = clientOxigen - 1
					vRPS.clientOxigen()

					if clientOxigen <= 0 then
						ApplyDamageToPed(PlayerPedId(),50,false)
					end
				end
			end
		end

		Wait(5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOODS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if playerActive then
			local ped = PlayerPedId()
			if GetGameTimer() >= updateFoods and GetEntityHealth(ped) > 101 then
				updateFoods = GetGameTimer() + 90000
				clientThirst = clientThirst - 1
				clientHunger = clientHunger - 1
				TriggerEvent("statusHunger",clientHunger)
				TriggerEvent("statusThirst",clientThirst)
				vRPS.clientFoods()
			end
		end

		Wait(30000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if homeInterior then
			SetWeatherTypeNow("CLEAR")
			SetWeatherTypePersist("CLEAR")
			SetWeatherTypeNowPersist("CLEAR")
			NetworkOverrideClockTime(00,00,00)
		else
			SetWeatherTypeNow(GlobalState["Weather"])
			SetWeatherTypePersist(GlobalState["Weather"])
			SetWeatherTypeNowPersist(GlobalState["Weather"])
			NetworkOverrideClockTime(GlobalState["Hours"],GlobalState["Minutes"],00)
		end

		Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	DisplayRadar(false)

	RequestStreamedTextureDict("circlemap",false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics","radarmasksm","circlemap","radarmasksm")

	SetMinimapClipType(1)

	SetMinimapComponentPosition("minimap","L","B",0.0,0.0,0.158,0.28)
	SetMinimapComponentPosition("minimap_mask","L","B",0.155,0.12,0.080,0.164)
	SetMinimapComponentPosition("minimap_blur","L","B",-0.005,0.021,0.240,0.302)

	Wait(5000)

	SetBigmapActive(true,false)

	Wait(100)

	SetBigmapActive(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local timeWait = 500
	while true do
		if homeInterior then
			SetWeatherTypeNow("CLEAR")
			SetWeatherTypePersist("CLEAR")
			SetWeatherTypeNowPersist("CLEAR")
			NetworkOverrideClockTime(00,00,00)
		else
			SetWeatherTypeNow(weatherSync)
			SetWeatherTypePersist(weatherSync)
			SetWeatherTypeNowPersist(weatherSync)
			NetworkOverrideClockTime(clockHours,clockMinutes,00)
		end

		if beltLock then
			timeWait = 0
			DisableControlAction(1,75,true)
		end

		Wait(timeWait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(progressTimer)
	SendNUIMessage({ progress = true, progressTimer = progressTimer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		timeAwait = 1000
		if playerActive then
			if IsPauseMenuActive() then
				SendNUIMessage({ hud = false })
				pauseBreak = true
			else
				if pauseBreak and showHud then
					SendNUIMessage({ hud = true })
					pauseBreak = false
				end
			end

			if showHud then
				local pid = PlayerId()
				local ped = PlayerPedId()
				local armour = GetPedArmour(ped)
				local coords = GetEntityCoords(ped)
				local heading = GetEntityHeading(ped)
				local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords["x"],coords["y"],coords["z"]))

				if heading >= 315 or heading < 45 then
					flexDirection = "Norte"
				elseif heading >= 45 and heading < 135 then
					flexDirection = "Oeste"
				elseif heading >= 135 and heading < 225 then
					flexDirection = "Sul"
				elseif heading >= 225 and heading < 315 then
					flexDirection = "Leste"
				end

				SendNUIMessage({ talking = MumbleIsPlayerTalking(pid), health = GetEntityHealth(ped) - 100, armour = armour, street = streetName, stress = clientStress, direction = flexDirection, radio = radioDisplay, oxigen = clientOxigen, suit = divingMask, hunger = clientHunger, thirst = clientThirst })
			end
		end

		Wait(timeAwait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
--[[---------------------------------------------------------------------------------------------------------------------------------------
function updateDisplayHud()
	local pid = PlayerId()
	local ped = PlayerPedId()
	local armour = GetPedArmour(ped)
	local coords = GetEntityCoords(ped)
	local heading = GetEntityHeading(ped)
	local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords["x"],coords["y"],coords["z"]))

	if heading >= 315 or heading < 45 then
		flexDirection = "Norte"
	elseif heading >= 45 and heading < 135 then
		flexDirection = "Oeste"
	elseif heading >= 135 and heading < 225 then
		flexDirection = "Sul"
	elseif heading >= 225 and heading < 315 then
		flexDirection = "Leste"
	end

	if IsPedInAnyVehicle(ped) then
		if not IsMinimapRendering() then
			DisplayRadar(true)
		end

		timeAwait = 100

		local vehicle = GetVehiclePedIsUsing(ped)
		local fuel = GetVehicleFuelLevel(vehicle)
		local speed = GetEntitySpeed(vehicle) * 3.6
		local plate = GetVehicleNumberPlateText(vehicle)
		local vehClass = GetVehicleClass(vehicle)
		local showBelt = true
		if vehClass == 8 or (vehClass >= 13 and vehClass <= 16) or vehClass == 21 then
			showBelt = false
		end

		local nitroShow = 0
		if nitroActive then
			nitroShow = nitroFuel
		else
			nitroShow = GlobalState["Nitro"][plate] or 0
		end

		SendNUIMessage({ vehicle = true, talking = MumbleIsPlayerTalking(pid), rpm = GetVehicleCurrentRpm(vehicle), nitro = (nitroShow * 100) / 2000, engine = GetVehicleEngineHealth(vehicle), stress = clientStress, health = GetEntityHealth(ped) - 100, armour = armour, street = streetName, direction = flexDirection, radio = radioDisplay, oxigen = clientOxigen, suit = divingMask, fuel = fuel, speed = speed, showbelt = showBelt, seatbelt = beltLock, hunger = clientHunger, thirst = clientThirst })
	else
		if IsMinimapRendering() then
			DisplayRadar(false)
		end

		SendNUIMessage({ vehicle = false, talking = MumbleIsPlayerTalking(pid), health = GetEntityHealth(ped) - 100, armour = armour, street = streetName, stress = clientStress, direction = flexDirection, radio = radioDisplay, oxigen = clientOxigen, suit = divingMask, hunger = clientHunger, thirst = clientThirst })
	end
end]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local InVeh = false
local timeVehAwait = 1000
CreateThread(function()
	while true do
		timeVehAwait = 1000
		if playerActive then
			if showHud then
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped) then
					if not IsMinimapRendering() then
						DisplayRadar(true)
					end

					timeVehAwait = 100

					local player_id = PlayerId()
					local vehicle = GetVehiclePedIsUsing(ped)
					local fuel = GetVehicleFuelLevel(vehicle)
					local speed = GetEntitySpeed(vehicle) * 3.6
					local plate = GetVehicleNumberPlateText(vehicle)
					local vehClass = GetVehicleClass(vehicle)
					local showBelt = true
					if vehClass == 8 or (vehClass >= 13 and vehClass <= 16) or vehClass == 21 then
						showBelt = false
					end
			
					local nitroShow = 0
					if nitroActive then
						nitroShow = nitroFuel
					else
						nitroShow = GlobalState["Nitro"][plate] or 0
					end
			
					SendNUIMessage({ talking = MumbleIsPlayerTalking(player_id), vehicle = true, rpm = GetVehicleCurrentRpm(vehicle), nitro = (nitroShow * 100) / 2000, engine = GetVehicleEngineHealth(vehicle), fuel = fuel, speed = speed, showbelt = showBelt, seatbelt = beltLock })

					if not InVeh then
						InVeh = true
					end
				else
					if IsMinimapRendering() then
						DisplayRadar(false)
					end

					if InVeh then
						InVeh = false
						SendNUIMessage({ vehicle = false })
					end
				end
			end
		end

		Wait(timeVehAwait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function(source,args)
	--if exports["chat"]:statusChat() then
		showHud = not showHud

		--updateDisplayHud()
		SendNUIMessage({ hud = showHud })

		if IsMinimapRendering() and not showHud then
			DisplayRadar(false)
		end
	--end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("movie",function(source,args)
	if exports["chat"]:statusChat() then
		showMovie = not showMovie

		--updateDisplayHud()
		SendNUIMessage({ movie = showMovie })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:toggleHood")
AddEventHandler("hud:toggleHood",function()
	showHood = not showHood

	if showHood then
		SetPedComponentVariation(PlayerPedId(),1,69,0,1)
	else
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end

	SendNUIMessage({ hood = showHood })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:removeHood")
AddEventHandler("hud:removeHood",function()
	if showHood then
		showHood = false
		SendNUIMessage({ hood = showHood })
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusHunger")
AddEventHandler("statusHunger",function(number)
	clientHunger = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSTHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusThirst")
AddEventHandler("statusThirst",function(number)
	clientThirst = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSSTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusStress")
AddEventHandler("statusStress",function(number)
	clientStress = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusOxigen")
AddEventHandler("statusOxigen",function(number)
	clientOxigen = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:rechargeOxigen")
AddEventHandler("hud:rechargeOxigen",function()
	TriggerEvent("Notify","verde","Reabastecimento concluído.",3000)
	vRPS.rechargeOxigen()
	clientOxigen = 100
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUDACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hudActived")
AddEventHandler("hudActived",function(status)
	showHud = status

	--updateDisplayHud()

	SendNUIMessage({ hud = showHud })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUDMOVIEACTIVED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hudMovieActived")
AddEventHandler("hudMovieActived",function(status)
	showMovie = not showMovie

	--updateDisplayHud()
	SendNUIMessage({ movie = showMovie })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIODISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Radio")
AddEventHandler("hud:Radio",function(number)
	if parseInt(number) <= 0 then
		radioDisplay = ""
	else
		radioDisplay = parseInt(number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOWARDPED
-----------------------------------------------------------------------------------------------------------------------------------------
function fowardPed(ped)
	local heading = GetEntityHeading(ped) + 90.0
	if heading < 0.0 then
		heading = 360.0 + heading
	end

	heading = heading * 0.0174533

	return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local shouldCheckForSeatBelt = true

function ChangeCheckForSeatBelt(status)
	shouldCheckForSeatBelt = status
end

CreateThread(function()
	while true do
		local timeDistance = 999
		if playerActive then
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped) then
				if not IsPedOnAnyBike(ped) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) and not LocalPlayer["state"]["CitroenRace"] and shouldCheckForSeatBelt then
					timeDistance = 50

					local vehicle = GetVehiclePedIsUsing(ped)
					local speed = GetEntitySpeed(vehicle) * 3.6
					if speed ~= beltSpeed then
						if (beltSpeed - speed) >= 40 and not beltLock then
							local fowardVeh = fowardPed(ped)
							local coords = GetEntityCoords(ped)
							SetEntityCoords(ped,coords["x"] + fowardVeh["x"],coords["y"] + fowardVeh["y"],coords["z"] + 1,1,0,0,0)
							SetEntityVelocity(ped,beltVelocity["x"],beltVelocity["y"],beltVelocity["z"])
							ApplyDamageToPed(ped,50,false)

							Wait(1)

							SetPedToRagdoll(ped,5000,5000,0,0,0,0)
						end

						beltVelocity = GetEntityVelocity(vehicle)
						beltSpeed = speed
					end
				end
			else
				if beltSpeed ~= 0 then
					beltSpeed = 0
				end

				if beltLock then
					beltLock = false
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seatbelt",function(source,args)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		if not IsPedOnAnyBike(ped) then
			if beltLock then
				TriggerEvent("sounds:source","unbelt",0.5)
				beltLock = false
			else
				TriggerEvent("sounds:source","belt",0.5)
				beltLock = true
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("seatbelt","Colocar/Retirar o cinto.","keyboard","g")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SYNCTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:syncTimers")
AddEventHandler("hud:syncTimers",function(timer)
	clockHours = parseInt(timer[2])
	clockMinutes = parseInt(timer[1])
	weatherSync = timer[3]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:HOURS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Hours")
AddEventHandler("homes:Hours",function(status)
	homeInterior = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local foodTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= foodTimers and playerActive then
			foodTimers = GetGameTimer() + 10000

			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				if clientHunger >= 10 and clientHunger <= 20 then
					ApplyDamageToPed(ped,1,false)
					TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
				elseif clientHunger <= 9 then
					ApplyDamageToPed(ped,2,false)
					TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
				end

				if clientThirst >= 10 and clientThirst <= 20 then
					ApplyDamageToPed(ped,1,false)
					TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
				elseif clientThirst <= 9 then
					ApplyDamageToPed(ped,2,false)
					TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHAKESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if playerActive then
			local ped = PlayerPedId()
			local health = GetEntityHealth(ped)

			if health > 101 then
				if clientStress >= 99 then
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.75)
				elseif clientStress >= 80 and clientStress <= 98 then
					timeDistance = 9990
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.50)
				elseif clientStress >= 60 and clientStress <= 79 then
					timeDistance = 7500
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.25)
				elseif clientStress >= 40 and clientStress <= 59 then
					timeDistance = 9990
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVESCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:removeScuba")
AddEventHandler("hud:removeScuba",function()
	local ped = PlayerPedId()
	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SETDIVING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:setDiving")
AddEventHandler("hud:setDiving",function()
	local ped = PlayerPedId()

	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	else
		local coords = GetEntityCoords(ped)
		local maskModel = GetHashKey("p_s_scuba_mask_s")
		local tankModel = GetHashKey("p_s_scuba_tank_s")

		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Wait(1)
		end

		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Wait(1)
		end

		if HasModelLoaded(tankModel) then
			divingTank = CreateObject(tankModel,coords["x"],coords["y"],coords["z"],true,true,false)
			local netObjs = ObjToNet(divingTank)

			SetNetworkIdCanMigrate(netObjs,true)

			SetEntityAsMissionEntity(divingTank,true,false)
			SetEntityInvincible(divingTank,true)

			AttachEntityToEntity(divingTank,ped,GetPedBoneIndex(ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,1,1,0,0,2,1)

			SetModelAsNoLongerNeeded(tankModel)
		end

		if HasModelLoaded(maskModel) then
			divingMask = CreateObject(maskModel,coords["x"],coords["y"],coords["z"],true,true,false)
			local netObjs = ObjToNet(divingMask)

			SetNetworkIdCanMigrate(netObjs,true)

			SetEntityAsMissionEntity(divingMask,true,false)
			SetEntityInvincible(divingMask,true)

			AttachEntityToEntity(divingMask,ped,GetPedBoneIndex(ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)

			SetModelAsNoLongerNeeded(maskModel)
		end

		SetEnableScuba(ped,true)
		SetPedMaxTimeUnderwater(ped,2000.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITROENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function nitroEnable()
	if GetGameTimer() >= nitroButton then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			nitroButton = GetGameTimer() + 1000

			local Vehicle = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(Vehicle,-1) == ped then
				if GetVehicleTopSpeedModifier(Vehicle) < 30.0 then
					local vehPlate = GetVehicleNumberPlateText(Vehicle)
					nitroFuel = GlobalState["Nitro"][vehPlate] or 0

					if nitroFuel >= 1 then
						if GetIsVehicleEngineRunning(Vehicle) then
							local Speed = GetEntitySpeed(Vehicle) * 2.236936
							if Speed > 10 then
								nitroActive = true

								while nitroActive do
									if nitroFuel >= 1 then
										nitroFuel = nitroFuel - 1

										if not nitroFlame then
											vSERVER._activeNitro(VehToNet(Vehicle),true)
											SetVehicleRocketBoostActive(Vehicle,true)
											SetVehicleBoostActive(Vehicle,true)
											ModifyVehicleTopSpeed(Vehicle,30.0)
											SetLightTrail(Vehicle,true)
											nitroFlame = vehPlate
										end
									else
										if nitroFlame then
											vSERVER._activeNitro(VehToNet(Vehicle),false)
											SetVehicleRocketBoostActive(Vehicle,false)
											vSERVER._updateNitro(nitroFlame,nitroFuel)
											SetVehicleBoostActive(Vehicle,false)
											ModifyVehicleTopSpeed(Vehicle,0.0)
											SetLightTrail(Vehicle,false)
											nitroActive = false
											nitroFlame = false
										end
									end

									Wait(1)
								end
							else
								SetPurgeSprays(Vehicle,true)
								sprayActive = true
							end
						else
							SetPurgeSprays(Vehicle,true)
							sprayActive = true
						end
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRODISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function nitroDisable()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local Vehicle = GetVehiclePedIsUsing(ped)

		if nitroFlame then
			vSERVER._activeNitro(VehToNet(Vehicle),false)
			SetVehicleRocketBoostActive(Vehicle,false)
			vSERVER._updateNitro(nitroFlame,nitroFuel)
			SetVehicleBoostActive(Vehicle,false)
			ModifyVehicleTopSpeed(Vehicle,0.0)
			SetLightTrail(Vehicle,false)
			nitroActive = false
			nitroFlame = false
		end

		if sprayActive then
			SetPurgeSprays(Vehicle,false)
			sprayActive = false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+activeNitro",nitroEnable)
RegisterCommand("-activeNitro",nitroDisable)
RegisterKeyMapping("+activeNitro","Ativação do nitro.","keyboard","LMENU")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function SetLightTrail(Vehicle,Enable)
	if LightTrails[Vehicle] == Enable then
		return
	end

	if Enable then
		local Particles = {}
		local LeftTrail = CreateLightTrail(Vehicle,GetEntityBoneIndexByName(Vehicle,"taillight_l"))
		local RightTrail = CreateLightTrail(Vehicle,GetEntityBoneIndexByName(Vehicle,"taillight_r"))

		table.insert(Particles,LeftTrail)
		table.insert(Particles,RightTrail)

		LightTrails[Vehicle] = true
		LightParticles[Vehicle] = Particles
	else
		if LightParticles[Vehicle] and #LightParticles[Vehicle] > 0 then
			for _,v in ipairs(LightParticles[Vehicle]) do
				StopLightTrail(v)
			end
		end

		LightTrails[Vehicle] = nil
		LightParticles[Vehicle] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATELIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateLightTrail(Vehicle,Bone)
	UseParticleFxAssetNextCall("core")
	local Particle = StartParticleFxLoopedOnEntityBone("veh_light_red_trail",Vehicle,0.0,0.0,0.0,0.0,0.0,0.0,Bone,1.0,false,false,false)
	SetParticleFxLoopedEvolution(Particle,"speed",1.0,false)

	return Particle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPLIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function StopLightTrail(Particle)
	CreateThread(function()
		local endTime = GetGameTimer() + 500
		while GetGameTimer() < endTime do 
			Wait(0)
			local now = GetGameTimer()
			local Scale = (endTime - now) / 500
			SetParticleFxLoopedScale(Particle,Scale)
			SetParticleFxLoopedAlpha(Particle,Scale)
		end

		StopParticleFxLooped(Particle)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
function SetPurgeSprays(Vehicle,Enable)
	if PurgeSprays[Vehicle] == Enable then
		return
	end

	if Enable then
		local Particles = {}
		local IsABike = (GetVehicleClass(Vehicle) == 8)

		local Bone
		if IsABike then
			Bone = GetEntityBoneIndexByName(Vehicle,"exhaust")
			if Bone == -1 then
				Bone = GetEntityBoneIndexByName(Vehicle,"wheel_lf") 
			end
		else
			Bone = GetEntityBoneIndexByName(Vehicle,"bonnet")
		end
		local Position = GetWorldPositionOfEntityBone(Vehicle,Bone)
		local Offset = GetOffsetFromEntityGivenWorldCoords(Vehicle,Position["x"],Position["y"],Position["z"])

		for i = 0,3 do
			local LeftPurge = CreatePurgeSprays(Vehicle,IsABike and 0.0 or Offset["x"] - 0.5,Offset["y"] + 0.05,Offset["z"],40.0,-20.0,0.0,0.5)
			local RightPurge = CreatePurgeSprays(Vehicle,IsABike and 0.0 or Offset["x"] + 0.5,Offset["y"] + 0.05,Offset["z"],40.0,20.0,0.0,0.5)

			table.insert(Particles,LeftPurge)
			table.insert(Particles,RightPurge)
		end

		PurgeSprays[Vehicle] = true
		PurgeParticles[Vehicle] = Particles
	else
		if PurgeParticles[Vehicle] then
			RemoveParticleFxFromEntity(Vehicle)
		end

		PurgeSprays[Vehicle] = nil
		PurgeParticles[Vehicle] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatePurgeSprays(Vehicle,xOffset,yOffset,zOffset,xRot,yRot)
	UseParticleFxAssetNextCall("core")
	return StartNetworkedParticleFxNonLoopedOnEntity("ent_sht_steam",Vehicle,xOffset,yOffset,zOffset,xRot,yRot,0.0,0.5,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:activeNitro")
AddEventHandler("hud:activeNitro",function(vehNet,Status)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			SetVehicleNitroEnabled(Vehicle,Status)
		end
	end
end)


exports("handleCheckSeatBelt", ChangeCheckForSeatBelt)

exports("handleTimeSync", function(bool)
	if bool == true then
		SetWeatherTypeNow("CLEAR")
		SetWeatherTypePersist("CLEAR")
		SetWeatherTypeNowPersist("CLEAR")
	end

	shouldSync = bool
end)