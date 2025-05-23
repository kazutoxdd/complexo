-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("inventory",cRP)
vGARAGE = Tunnel.getInterface("garages")
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Types = ""
local Weapon = ""
local PushSlot = 1
local Backpack = false
local weaponActive = false
local putWeaponHands = false
local storeWeaponHands = false
local timeReload = GetGameTimer()
LocalPlayer["state"]["Buttons"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CleanWeapons")
AddEventHandler("inventory:CleanWeapons",function(Create)
	if Weapon ~= "" then
		if Create and PushSlot <= 5 then
			TriggerEvent("inventory:CreateWeapon",Weapon)
		end

		RemoveWeaponFromPed(PlayerPedId(),Weapon)
		SetPedAmmo(PlayerPedId(),Weapon,0)
	end

	TriggerEvent("hud:Weapon",false)
	weaponActive = false
	Weapon = ""
	Types = ""
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Buttons"] then
			timeDistance = 1
			DisableControlAction(1,75,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Buttons")
AddEventHandler("inventory:Buttons",function(status)
	LocalPlayer["state"]["Buttons"] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- throwableWeapons
-----------------------------------------------------------------------------------------------------------------------------------------
local currentWeapon = ""
RegisterNetEvent("inventory:throwableWeapons")
AddEventHandler("inventory:throwableWeapons",function(weaponName)
	currentWeapon = weaponName

	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey(currentWeapon) then
		while GetSelectedPedWeapon(ped) == GetHashKey(currentWeapon) do
			if IsPedShooting(ped) then
				vSERVER.removeThrowable(currentWeapon)
			end
			Wait(0)
		end
		currentWeapon = ""
	else
		cRP.storeWeaponHands()
		currentWeapon = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Backpack then
		Backpack = false
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "hideMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	TriggerEvent("inventory:Close")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Craft",function()
	Backpack = false
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })

	TriggerEvent("crafting:openSource")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Deliver",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:Deliver",data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:useItem",data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:sendItem",data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("destroyItem",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:destroyItem",data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		vSERVER.invUpdate(data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(action)
	if MumbleIsConnected() then
		SendNUIMessage({ action = action })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:clearWeapons")
AddEventHandler("inventory:clearWeapons",function()
	if Weapon ~= "" then
		Weapon = ""
		weaponActive = false
		RemoveAllPedWeapons(PlayerPedId(),true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon",function(splitName)
	if Weapon == splitName then
		local ped = PlayerPedId()
		local weaponAmmo = GetAmmoInPedWeapon(ped,Weapon)
		if not vSERVER.verifyWeapon(Weapon,weaponAmmo) then
			TriggerEvent("inventory:CleanWeapons",false)
		end
	else
		if Weapon == "" then
			vSERVER.existWeapon(splitName)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:preventWeapon")
AddEventHandler("inventory:preventWeapon",function(storeWeapons)
	if Weapon ~= "" then
		local Ped = PlayerPedId()
		local weaponAmmo = GetAmmoInPedWeapon(Ped,Weapon)

		vSERVER.preventWeapon(Weapon,weaponAmmo)

		if storeWeapons then
			if Weapon ~= "" then
				TriggerEvent("inventory:CreateWeapon",Weapon)
				RemoveWeaponFromPed(Ped,Weapon)
				SetPedAmmo(Ped,Weapon,0)
			end
		end

		Types = ""
		Weapon = ""
		weaponActive = false
		TriggerEvent("hud:Weapon",false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("openBackpack",function(source,args,rawCommand)
	if GetEntityHealth(PlayerPedId()) > 101 and not LocalPlayer["state"]["Buttons"] and MumbleIsConnected() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPlayerFreeAiming(PlayerId()) then
			Backpack = true
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("openBackpack","Manusear a mochila.","keyboard","OEM_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairVehicle")
AddEventHandler("inventory:repairVehicle",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				local vehTyres = {}

				for i = 0,7 do
					local Status = false

					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						Status = true
					end

					vehTyres[i] = Status
				end

				local Fuel = GetVehicleFuelLevel(Vehicle)

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)

				SetVehicleFuelLevel(Vehicle,Fuel)

				for Tyre,Burst in pairs(vehTyres) do
					if Burst then
						SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRTYRE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairTyre")
AddEventHandler("inventory:repairTyre",function(Vehicle,Tyres,vehPlate)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				for i = 0,7 do
					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						SetVehicleTyreBurst(Vehicle,i,true,1000.0)
					end
				end

				SetVehicleTyreFixed(Vehicle,Tyres)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairPlayer")
AddEventHandler("inventory:repairPlayer",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleEngineHealth(Vehicle,1000.0)
				SetVehicleBodyHealth(Vehicle,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairAdmin")
AddEventHandler("inventory:repairAdmin",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				local Fuel = GetVehicleFuelLevel(Vehicle)

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)

				SetVehicleFuelLevel(Vehicle,Fuel)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEALARM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:vehicleAlarm")
AddEventHandler("inventory:vehicleAlarm",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleAlarm(Vehicle,true)
				StartVehicleAlarm(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.parachuteColors()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,"GADGET_PARACHUTE",1,false,true)
	SetPedParachuteTintIndex(ped,math.random(7))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local fishCoords = PolyZone:Create({
	vector2(2308.64,3906.11),
	vector2(2180.13,3885.29),
	vector2(2058.22,3883.56),
	vector2(2024.97,3942.53),
	vector2(1748.72,3964.53),
	vector2(1655.65,3886.34),
	vector2(1547.59,3830.17),
	vector2(1540.73,3826.94),
	vector2(1535.67,3816.55),
	vector2(1456.35,3756.87),
	vector2(1263.44,3670.38),
	vector2(1172.99,3648.83),
	vector2(967.98,3653.54),
	vector2(840.55,3679.16),
	vector2(633.13,3600.70),
	vector2(361.73,3626.24),
	vector2(310.58,3571.61),
	vector2(266.92,3493.13),
	vector2(173.49,3421.45),
	vector2(128.16,3442.66),
	vector2(143.41,3743.49),
	vector2(-38.59,3754.16),
	vector2(-132.62,3716.80),
	vector2(-116.73,3805.33),
	vector2(-157.23,3838.81),
	vector2(-204.70,3846.28),
	vector2(-208.28,3873.08),
	vector2(-236.88,4076.58),
	vector2(-184.11,4231.52),
	vector2(-139.54,4253.54),
	vector2(-45.38,4344.43),
	vector2(-5.96,4408.34),
	vector2(38.36,4411.02),
	vector2(150.77,4311.74),
	vector2(216.02,4342.85),
	vector2(294.16,4245.62),
	vector2(396.21,4342.24),
	vector2(438.37,4315.38),
	vector2(505.22,4178.69),
	vector2(606.65,4202.34),
	vector2(684.48,4169.83),
	vector2(773.54,4152.33),
	vector2(877.34,4172.67),
	vector2(912.20,4269.57),
	vector2(850.92,4428.91),
	vector2(922.96,4376.48),
	vector2(941.32,4328.09),
	vector2(995.318,4288.70),
	vector2(1050.33,4215.29),
	vector2(1082.27,4285.61),
	vector2(1060.97,4365.31),
	vector2(1072.62,4372.37),
	vector2(1119.24,4317.53),
	vector2(1275.27,4354.90),
	vector2(1360.96,4285.09),
	vector2(1401.09,4283.69),
	vector2(1422.33,4339.60),
	vector2(1516.60,4393.69),
	vector2(1597.58,4455.65),
	vector2(1650.81,4499.17),
	vector2(1781.12,4525.83),
	vector2(1828.69,4560.26),
	vector2(1866.59,4554.49),
	vector2(2162.70,4664.53),
	vector2(2279.31,4660.26),
	vector2(2290.52,4630.90),
	vector2(2418.64,4613.91),
	vector2(2427.06,4597.69),
	vector2(2449.86,4438.97),
	vector2(2396.62,4353.36),
	vector2(2383.66,4160.74),
	vector2(2383.05,4046.07)
},{ name = "Pescaria" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingCoords()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	if fishCoords:isPointInside(coords) and IsEntityInWater(ped) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"anim@gangops@facility@servers@bodysearch@","player_search",3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.returnWeapon()
	if Weapon ~= "" then
		return Weapon
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWeapon(Hash)
	if Weapon == Hash then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:stealTrunk")
AddEventHandler("inventory:stealTrunk",function(entity)
	if Weapon == "WEAPON_CROWBAR" then
		local trunk = GetEntityBoneIndexByName(entity[3],"boot")
		if trunk ~= -1 then
			local ped = PlayerPedId()
			local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.5,0.0)
			local coordsEnt = GetWorldPositionOfEntityBone(entity[3],trunk)
			local distance = #(coords - coordsEnt)
			if distance <= 2.0 then
				vSERVER.stealTrunk(entity)
			end
		end
	else
		TriggerEvent("Notify","amarelo","<b>Pé de Cabra</b> não encontrado.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAttachs = {
	["attachsFlashlight"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_03",
		["WEAPON_PISTOL50"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_FLSH"
	},
	["attachsCrosshair"] = {
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_RAIL",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_RAIL_02",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_SCOPE_SMALL",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MACRO_02_MK2",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SCOPE_SMALL_MK2",
		["WEAPON_SMG"] = "COMPONENT_AT_SCOPE_MACRO_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_SCOPE_MACRO"
	},
	["attachsMagazine"] = {
		["WEAPON_PISTOL"] = "COMPONENT_PISTOL_CLIP_02",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_PISTOL_MK2_CLIP_02",
		["WEAPON_COMPACTRIFLE"] = "COMPONENT_COMPACTRIFLE_CLIP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_APPISTOL_CLIP_02",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_HEAVYPISTOL_CLIP_02",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_MACHINEPISTOL_CLIP_02",
		["WEAPON_MICROSMG"] = "COMPONENT_MICROSMG_CLIP_02",
		["WEAPON_MINISMG"] = "COMPONENT_MINISMG_CLIP_02",
		["WEAPON_SNSPISTOL"] = "COMPONENT_SNSPISTOL_CLIP_02",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_SNSPISTOL_MK2_CLIP_02",
		["WEAPON_VINTAGEPISTOL"] = "COMPONENT_VINTAGEPISTOL_CLIP_02",
		["WEAPON_PISTOL50"] = "COMPONENT_PISTOL50_CLIP_02",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_COMBATPISTOL_CLIP_02",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_CARBINERIFLE_CLIP_02",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
		["WEAPON_ADVANCEDRIFLE"] = "COMPONENT_ADVANCEDRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_BULLPUPRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_SPECIALCARBINE_CLIP_02",
		["WEAPON_SMG"] = "COMPONENT_SMG_CLIP_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_SMG_MK2_CLIP_02",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_ASSAULTRIFLE_CLIP_02",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_ASSAULTSMG_CLIP_02",
		["WEAPON_GUSENBERG"] = "COMPONENT_GUSENBERG_CLIP_02"
	},
	["attachsSilencer"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SR_SUPP_03",
		["WEAPON_SMG"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_SUPP_02"
	},
	["attachsGrip"] = {
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_MUZZLE_08",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02"
	},
	["attachsMuzzleFat"] = {
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_COMP",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_MUZZLE_03",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_MUZZLE_03",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_03",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_MUZZLE_03",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_03"
	},
	["attachsBarrel"] = {
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_BP_BARREL_02",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_BARREL_02",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_CR_BARREL_02",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_SC_BARREL_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_SB_BARREL_02"
	},
	["attachsMuzzleHeavy"] = {
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_COMP",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_MUZZLE_05",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_MUZZLE_05",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_05",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_MUZZLE_05",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_05"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkAttachs(nameItem,nameWeapon)
	return weaponAttachs[nameItem][nameWeapon]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putAttachs(nameItem,nameWeapon)
	GiveWeaponComponentToPed(PlayerPedId(),nameWeapon,weaponAttachs[nameItem][nameWeapon])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putWeaponHands(weaponName,weaponAmmo,attachs)
	if not putWeaponHands then
		if weaponAmmo == nil then
			weaponAmmo = 0
		end

		if weaponAmmo > 0 then
			weaponActive = true
		end

		putWeaponHands = true
		LocalPlayer["state"]["Cancel"] = true

		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			loadAnimDict("rcmjosh4")

			TaskPlayAnim(ped,"rcmjosh4","josh_leadout_cop2",3.0,2.0,-1,48,10,0,0,0)

			Wait(200)

			TriggerEvent("inventory:RemoveWeapon",weaponName)
			GiveWeaponToPed(ped,weaponName,weaponAmmo,false,true)

			Wait(300)

			ClearPedTasks(ped)
		else
			TriggerEvent("inventory:RemoveWeapon",weaponName)
			GiveWeaponToPed(ped,weaponName,weaponAmmo,false,true)
		end

		if attachs ~= nil then
			for nameItem,_ in pairs(attachs) do
				cRP.putAttachs(nameItem,weaponName)
			end
		end

		Weapon = weaponName
		putWeaponHands = false
		LocalPlayer["state"]["Cancel"] = false

		if itemAmmo(weaponName) then
			TriggerEvent("hud:Weapon",true,weaponName)
		end

		if vSERVER.dropWeapons(weaponName) then
			TriggerEvent("inventory:CleanWeapons",true)
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeWeaponHands()
	if not storeWeaponHands then
		storeWeaponHands = true
		local ped = PlayerPedId()
		LocalPlayer["state"]["Cancel"] = true
		local lastWeapon = Weapon
		local weaponAmmo = GetAmmoInPedWeapon(ped,Weapon)

		if not IsPedInAnyVehicle(ped) then
			loadAnimDict("weapons@pistol@")

			TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)

			Wait(450)

			ClearPedTasks(ped)
		end

		LocalPlayer["state"]["Cancel"] = false

		TriggerEvent("inventory:CleanWeapons",true)

		storeWeaponHands = false

		return true,weaponAmmo,lastWeapon
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONAMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAmmos = {
	["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL_MK2",
		"WEAPON_PISTOL50",
		"WEAPON_REVOLVER",
		"WEAPON_COMBATPISTOL",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_SNSPISTOL",
		"WEAPON_SNSPISTOL_MK2",
		"WEAPON_VINTAGEPISTOL"
	},
	["WEAPON_NAIL_AMMO"] = {
		"WEAPON_NAILGUN"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_MICROSMG",
		"WEAPON_MINISMG",
		"WEAPON_SMG",
		"WEAPON_SMG_MK2",
		"WEAPON_GUSENBERG",
		"WEAPON_MACHINEPISTOL"
	},
	["WEAPON_RIFLE_AMMO"] = {
		"WEAPON_FNFAL",
		"WEAPON_PARAFAL",
		"WEAPON_COLTXM177",
		"WEAPON_COMPACTRIFLE",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_BULLPUPRIFLE",
		"WEAPON_BULLPUPRIFLE_MK2",
		"WEAPON_ADVANCEDRIFLE",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_ASSAULTSMG",
		"WEAPON_ASSAULTRIFLE_MK2",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_SPECIALCARBINE_MK2"
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_PUMPSHOTGUN_MK2",
		"WEAPON_SAWNOFFSHOTGUN"
	},
	["WEAPON_MUSKET_AMMO"] = {
		"WEAPON_MUSKET"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGECHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeCheck(ammoType)
	local weaponHash = nil
	local ped = PlayerPedId()
	local weaponStatus = false

	if weaponAmmos[ammoType] then
		local weaponAmmo = GetAmmoInPedWeapon(ped,Weapon)

		for k,v in pairs(weaponAmmos[ammoType]) do
			if Weapon == v then
				weaponHash = Weapon
				weaponStatus = true
				break
			end
		end
	end

	return weaponStatus,weaponHash,weaponAmmo
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeWeapon(weaponHash,ammoAmount)
	AddAmmoToPed(PlayerPedId(),weaponHash,ammoAmount)
	weaponActive = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		if weaponActive and Weapon ~= "" then
			timeDistance = 100
			local ped = PlayerPedId()
			local weaponAmmo = GetAmmoInPedWeapon(ped,Weapon)

			if GetGameTimer() >= timeReload and IsPedReloading(ped) then
				vSERVER.preventWeapon(Weapon,weaponAmmo)
				timeReload = GetGameTimer() + 1000
			end

			if weaponAmmo <= 0 or (Weapon == "WEAPON_PETROLCAN" and weaponAmmo <= 135 and IsPedShooting(ped)) or IsPedSwimming(ped) then
				vSERVER.preventWeapon(Weapon,weaponAmmo)
				TriggerEvent("inventory:CleanWeapons",true)
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
local fireTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkCracker()
	if GetGameTimer() <= fireTimers then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Firecracker")
AddEventHandler("inventory:Firecracker",function()
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
			Wait(1)
		end
	end

	local explosives = 25
	local ped = PlayerPedId()
	fireTimers = GetGameTimer() + (5 * 60000)
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.6,0.0)
	local myObject,objNet = vRPS.CreateObject("ind_prop_firework_03",coords["x"],coords["y"],coords["z"])
	if myObject then
		local spawnObjects = 0
		local uObject = NetworkGetEntityFromNetworkId(objNet)
		while not DoesEntityExist(uObject) and spawnObjects <= 1000 do
			uObject = NetworkGetEntityFromNetworkId(objNet)
			spawnObjects = spawnObjects + 1
			Wait(1)
		end

		spawnObjects = 0
		local objectControl = NetworkRequestControlOfEntity(uObject)
		while not objectControl and spawnObjects <= 1000 do
			objectControl = NetworkRequestControlOfEntity(uObject)
			spawnObjects = spawnObjects + 1
			Wait(1)
		end

		PlaceObjectOnGroundProperly(uObject)
		FreezeEntityPosition(uObject,true)

		SetEntityAsNoLongerNeeded(uObject)

		Wait(10000)

		repeat
			UseParticleFxAssetNextCall("scr_indep_fireworks")
			local explode = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst",coords["x"],coords["y"],coords["z"],0.0,0.0,0.0,2.5,false,false,false,false)
			explosives = explosives - 1

			Wait(2000)
		until explosives <= 0

		TriggerServerEvent("tryDeleteObject",objNet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWater()
	return IsPedSwimming(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIMDIC
-----------------------------------------------------------------------------------------------------------------------------------------
function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	if MumbleIsConnected() then
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local _,cdz = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"])

		TriggerServerEvent("inventory:Drops",data["item"],data["slot"],data["amount"],coords["x"],coords["y"],cdz)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Table")
AddEventHandler("drops:Table",function(Table)
	Drops = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Adicionar")
AddEventHandler("drops:Adicionar",function(Number,Table)
	Drops[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Remover")
AddEventHandler("drops:Remover",function(Number)
	if Drops[Number] then
		Drops[Number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ATUALIZAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Atualizar")
AddEventHandler("drops:Atualizar",function(Number,Amount)
	if Drops[Number] then
		Drops[Number]["amount"] = Amount
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			for _,v in pairs(Drops) do
				local distance = #(coords - vec3(v["coords"][1],v["coords"][2],v["coords"][3]))
				if distance <= 50 then
					timeDistance = 1
					DrawMarker(23,v["coords"][1],v["coords"][2],v["coords"][3] + 0.05,0.0,0.0,0.0,0.0,180.0,0.0,0.15,0.15,0.0,255,255,255,50,0,0,0,0)
					DrawMarker(21,v["coords"][1],v["coords"][2],v["coords"][3] + 0.25,0.0,0.0,0.0,0.0,180.0,0.0,0.20,0.20,0.20,42,137,255,125,0,0,0,1)
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestInventory",function(data,cb)
	local Items = {}

	if LocalPlayer["state"]["Route"] < 900000 then
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local _,cdz = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"])

		for k,v in pairs(Drops) do
			local distance = #(vec3(coords["x"],coords["y"],cdz) - vec3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= 0.9 then
				local Number = #Items + 1

				Items[Number] = v
				Items[Number]["id"] = k
			end
		end
	end

	local inventario,invPeso,invMaxpeso = vSERVER.requestInventory()
	if inventario then
		cb({ inventario = inventario, drop = Items, invPeso = invPeso, invMaxpeso = invMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupItem",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:Pickup",data["id"],data["amount"],data["target"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.wheelChair(vehPlate)
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.75,0.0)
	local myVehicle = vGARAGE.serverVehicle("wheelchair",coords["x"],coords["y"],coords["z"],heading,vehPlate,0,nil,1000)

	if NetworkDoesNetworkIdExist(myVehicle) then
		local vehicleNet = NetToEnt(myVehicle)
		if NetworkDoesNetworkIdExist(vehicleNet) then
			SetVehicleOnGroundProperly(vehicleNet)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELTREADS
-----------------------------------------------------------------------------------------------------------------------------------------
local wheelChair = false
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Model = GetEntityModel(Vehicle)
			if Model == -1178021069 then
				if not IsEntityPlayingAnim(Ped,"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester",3) then
					vRP.playAnim(true,{"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester"},true)
					wheelChair = true
				end
			end
		else
			if wheelChair then
				vRP.removeObjects("one")
				wheelChair = false
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARISCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
local scanTable = {}
local initSounds = {}
local soundScanner = 999
local userScanner = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local scanCoords = {
	{ -1811.94,-968.5,1.72,357.17 },
	{ -1788.29,-958.0,3.35,328.82 },
	{ -1756.9,-942.98,6.91,311.82 },
	{ -1759.97,-910.12,7.58,334.49 },
	{ -1791.44,-904.11,5.12,39.69 },
	{ -1827.87,-900.32,2.48,68.04 },
	{ -1840.76,-882.39,2.81,51.03 },
	{ -1793.4,-819.9,7.73,328.82 },
	{ -1737.69,-791.3,9.44,317.49 },
	{ -1714.6,-784.61,9.82,306.15 },
	{ -1735.88,-757.92,10.11,2.84 },
	{ -1763.22,-764.65,9.49,65.2 },
	{ -1786.23,-782.4,8.71,99.22 },
	{ -1809.5,-798.29,7.89,104.89 },
	{ -1816.35,-827.68,6.44,141.74 },
	{ -1833.23,-856.58,3.52,147.41 },
	{ -1842.88,-869.45,2.98,144.57 },
	{ -1865.34,-858.4,2.12,99.22 },
	{ -1868.01,-835.58,3.0,51.03 },
	{ -1860.76,-810.59,4.04,8.51 },
	{ -1848.85,-790.99,6.3,348.67 },
	{ -1834.31,-767.03,8.17,337.33 },
	{ -1819.3,-742.04,8.85,331.66 },
	{ -1804.76,-713.39,9.76,331.66 },
	{ -1805.32,-695.22,10.23,348.67 },
	{ -1824.32,-685.97,10.23,36.86 },
	{ -1849.16,-699.25,9.45,85.04 },
	{ -1868.9,-716.3,8.86,110.56 },
	{ -1890.07,-736.57,6.27,124.73 },
	{ -1909.8,-759.44,3.52,130.4 },
	{ -1920.19,-782.25,2.8,144.57 },
	{ -1939.84,-765.34,1.99,85.04 },
	{ -1932.96,-746.47,3.05,8.51 },
	{ -1954.69,-722.8,3.03,28.35 },
	{ -1954.53,-688.85,4.06,11.34 },
	{ -1939.8,-651.94,8.74,351.5 },
	{ -1926.48,-627.37,10.67,348.67 },
	{ -1920.73,-615.67,10.95,340.16 },
	{ -1924.48,-596.03,11.56,51.03 },
	{ -1952.53,-597.0,11.02,70.87 },
	{ -1972.12,-609.32,8.73,102.05 },
	{ -1989.01,-629.48,5.21,124.73 },
	{ -2002.97,-659.48,3.03,141.74 },
	{ -2028.03,-658.61,1.82,107.72 },
	{ -2045.57,-637.91,2.02,65.2 },
	{ -2031.42,-618.65,3.23,0.0 },
	{ -2003.74,-603.38,6.3,328.82 },
	{ -1982.79,-588.43,10.01,317.49 },
	{ -1968.4,-565.72,11.42,323.15 },
	{ -1980.98,-545.43,11.58,5.67 },
	{ -1996.36,-552.72,11.68,17.01 },
	{ -2013.33,-573.78,8.95,102.05 },
	{ -2030.05,-604.62,3.93,133.23 },
	{ -2035.79,-626.99,3.0,150.24 },
	{ -2053.05,-626.67,2.31,113.39 },
	{ -2062.58,-596.05,3.03,45.36 },
	{ -2096.8,-579.13,2.75,53.86 },
	{ -2116.49,-559.09,2.29,48.19 },
	{ -2093.8,-539.57,3.74,22.68 },
	{ -2067.11,-526.37,6.98,328.82 },
	{ -2049.71,-516.4,9.13,308.98 },
	{ -2029.87,-507.17,11.49,300.48 },
	{ -2049.27,-492.94,11.17,11.34 },
	{ -2073.38,-483.05,9.13,42.52 },
	{ -2102.99,-470.71,6.52,56.7 },
	{ -2119.62,-451.87,6.67,48.19 },
	{ -2134.43,-460.37,5.24,93.55 },
	{ -1805.06,-936.1,2.53,189.93 },
	{ -1786.4,-932.99,4.38,269.3},
	{ -1744.87,-926.96,7.65,269.3 },
	{ -1763.18,-925.72,6.99,104.89 },
	{ -1773.65,-895.76,7.35,357.17 },
	{ -1750.28,-883.7,7.75,277.8 },
	{ -1733.24,-862.29,8.17,311.82 },
	{ -1703.01,-838.56,9.03,300.48 },
	{ -1720.85,-834.19,8.95,31.19 },
	{ -1747.12,-839.86,8.39,138.9 },
	{ -1764.27,-856.95,7.75,147.41 },
	{ -1776.27,-868.44,7.78,119.06 },
	{ -1803.86,-872.72,5.34,93.55 },
	{ -1744.12,-901.55,7.7,79.38 },
	{ -1765.09,-808.12,8.58,31.19 },
	{ -1773.17,-728.07,10.01,8.51 },
	{ -1849.14,-729.09,8.85,136.07 },
	{ -1866.65,-758.66,6.96,150.24 },
	{ -1886.42,-794.12,3.25,158.75 },
	{ -1795.97,-748.07,9.17,297.64 },
	{ -1915.8,-682.79,8.0,62.37 },
	{ -1911.86,-651.71,10.26,0.0 },
	{ -1899.29,-623.49,11.34,345.83 },
	{ -1847.11,-670.69,10.45,17.01 },
	{ -1874.69,-647.34,10.92,39.69 },
	{ -1958.9,-629.78,8.34,73.71 },
	{ -1951.39,-575.59,11.53,343.0 },
	{ -1991.28,-569.55,10.72,164.41 },
	{ -2056.68,-569.32,4.57,99.22 },
	{ -2088.29,-560.62,3.27,87.88 },
	{ -2042.45,-542.51,8.46,308.98 },
	{ -2020.91,-528.58,11.12,306.15 },
	{ -2092.91,-499.58,5.37,79.38 },
	{ -2113.6,-521.59,2.27,147.41 },
	{ -2139.09,-496.06,2.27,48.19 },
	{ -2122.44,-486.23,3.56,280.63 },
	{ -2034.27,-577.42,6.74,294.81 },
	{ -2003.72,-536.62,11.78,320.32 },
	{ -2023.41,-551.31,9.59,255.12 },
	{ -2014.0,-626.04,3.76,189.93 },
	{ -1967.67,-656.53,5.24,255.12 },
	{ -1878.77,-672.36,9.76,257.96 },
	{ -1827.96,-702.26,9.67,240.95 },
	{ -1855.87,-771.67,6.94,164.41 },
	{ -1846.08,-830.98,3.79,175.75 },
	{ -1830.72,-804.5,6.67,334.49 },
	{ -1770.76,-835.92,7.84,311.82 },
	{ -1724.61,-812.2,9.25,303.31 },
	{ -1828.9,-719.11,9.3,65.2 },
	{ -1893.81,-707.65,7.73,110.56 },
	{ -1921.84,-716.82,5.22,212.6 },
	{ -1891.7,-756.03,4.95,218.27 },
	{ -1890.51,-818.0,2.95,303.31 },
	{ -1806.69,-770.32,8.29,306.15 },
	{ -1763.57,-747.01,9.81,303.31 },
	{ -1980.27,-691.34,3.02,189.93 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local amountCoords = 0
	repeat
		amountCoords = amountCoords + 1
		local rand = math.random(#scanCoords)
		scanTable[amountCoords] = scanCoords[rand]
		Wait(1)
	until amountCoords == 25
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANNERCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:updateScanner")
AddEventHandler("inventory:updateScanner",function(status)
	userScanner = status
	soundScanner = 999
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if userScanner then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local coords = GetEntityCoords(ped)

				for k,v in pairs(scanTable) do
					local distance = #(coords - vec3(v[1],v[2],v[3]))
					if distance <= 7.25 then
						soundScanner = 1000

						if initSounds[k] == nil then
							initSounds[k] = true
						end

						if distance <= 1.25 then
							timeDistance = 1
							soundScanner = 250

							if IsControlJustPressed(1,38) and MumbleIsConnected() then
								TriggerServerEvent("inventory:makeProducts",{},"scanner")

								local rand = math.random(#scanCoords)
								scanTable[k] = scanCoords[rand]
								initSounds[k] = nil
								soundScanner = 999
							end
						end
					else
						if initSounds[k] then
							initSounds[k] = nil
							soundScanner = 999
						end
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNERSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if userScanner and (soundScanner == 1000 or soundScanner == 250) then
			PlaySoundFrontend(-1,"MP_IDLE_TIMER","HUD_FRONTEND_DEFAULT_SOUNDSET")
		end

		Wait(soundScanner)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop",function(resource)
	TriggerServerEvent("vRP:Prints","pausou o resource "..resource)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local boxList = {
	{ 594.43,146.51,97.31,"Medic" },
	{ 660.57,268.11,102.06,"Medic" },
	{ 552.50,-197.71,53.76,"Medic" },
	{ 339.64,-581.13,73.44,"Medic" },
	{ 696.06,-966.19,23.26,"Medic" },
	{ 1152.45,-1531.43,34.66,"Medic" },
	{ 1382.03,-2081.88,51.28,"Medic" },
	{ 589.08,-2802.64,5.34,"Medic" },
	{ -452.97,-2810.19,6.59,"Medic" },
	{ -1007.09,-2835.14,13.22,"Medic" },
	{ -2018.03,-361.23,47.41,"Medic" },
	{ -1727.11,250.50,61.67,"Medic" },
	{ -1089.41,2717.06,18.35,"Medic" },
	{ 322.07,2870.01,44.33,"Medic" },
	{ 1162.30,2722.15,37.31,"Medic" },
	{ 1745.07,3325.18,40.41,"Medic" },
	{ 2013.45,3934.56,31.65,"Medic" },
	{ 2526.61,4191.89,44.57,"Medic" },
	{ 2874.13,4861.62,61.49,"Medic" },
	{ 1985.15,6200.30,41.32,"Medic" },
	{ 1549.42,6613.58,2.15,"Medic" },
	{ -300.29,6390.89,29.89,"Medic" },
	{ -815.19,5384.08,33.79,"Medic" },
	{ -1613.17,5262.20,3.25,"Medic" },
	{ -199.71,3638.30,63.72,"Medic" },
	{ -1487.49,2688.97,2.96,"Medic" },
	{ -3266.54,1139.91,1.95,"Medic" },
	{ 574.19,132.92,98.45,"Weapons" },
	{ 344.74,929.16,202.43,"Weapons" },
	{ -123.21,1896.61,196.31,"Weapons" },
	{ -1097.20,2705.98,21.97,"Weapons" },
	{ -2198.33,4242.54,46.92,"Weapons" },
	{ -1486.84,4983.19,62.66,"Weapons" },
	{ 1345.95,6396.18,32.39,"Weapons" },
	{ 2535.65,4661.52,33.06,"Weapons" },
	{ 1166.19,-1339.58,35.07,"Weapons" },
	{ 1112.41,-2500.32,32.34,"Weapons" },
	{ 259.26,-3113.36,4.80,"Weapons" },
	{ -1621.63,-1037.19,12.13,"Weapons" },
	{ -3421.65,974.54,10.89,"Weapons" },
	{ -1910.37,4624.45,56.06,"Weapons" },
	{ 895.66,3212.04,40.52,"Weapons" },
	{ 1802.75,4604.32,36.65,"Weapons" },
	{ 443.32,6456.24,27.68,"Weapons" },
	{ 64.84,6320.81,37.85,"Weapons" },
	{ -748.40,5595.82,40.64,"Weapons" },
	{ -2683.33,2303.38,20.84,"Supplies" },
	{ -2687.00,2304.36,20.84,"Supplies" },
	{ -1282.21,2559.87,17.36,"Supplies" },
	{ 160.43,3119.01,42.39,"Supplies" },
	{ 1062.20,3527.83,33.13,"Supplies" },
	{ 2364.56,3154.49,47.20,"Supplies" },
	{ 2521.62,2637.86,36.94,"Supplies" },
	{ 2572.34,477.76,107.68,"Supplies" },
	{ 1206.30,-1089.56,39.24,"Supplies" },
	{ 1039.79,-244.01,67.28,"Supplies" },
	{ 499.27,-530.36,23.73,"Supplies" },
	{ 592.17,-2114.34,4.75,"Supplies" },
	{ 513.09,-2584.10,13.34,"Supplies" },
	{ -2.98,-1299.73,28.26,"Supplies" },
	{ 182.61,-1086.84,28.26,"Supplies" },
	{ 712.27,-852.63,23.24,"Supplies" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBOXES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for k,v in pairs(boxList) do
		exports["target"]:AddCircleZone("Boxes:"..k,vec3(v[1],v[2],v[3]),1.0,{
			name = "Boxes:"..k,
			heading = 3374176,
			useZ = true
		},{
			shop = k,
			distance = 1.5,
			options = {
				{
					event = "inventory:lootSystem",
					label = "Abrir",
					tunnel = "boxes",
					service = v[4]
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBOXLISTBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for _,v in pairs(boxList) do
		local Blip = AddBlipForRadius(v[1],v[2],v[3],10.0)
		SetBlipAlpha(Blip,155)
		SetBlipColour(Blip,69)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local tyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:removeTyres")
AddEventHandler("inventory:removeTyres",function(Entity)
	if GetVehicleDoorLockStatus(Entity[3]) == 1 then
		if Weapon == "WEAPON_WRENCH" then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			for k,Tyre in pairs(tyreList) do
				local Selected = GetEntityBoneIndexByName(Entity[3],k)
				if Selected ~= -1 then
					local coordsWheel = GetWorldPositionOfEntityBone(Entity[3],Selected)
					local distance = #(coords - coordsWheel)
					if distance <= 1.0 then
						TriggerServerEvent("inventory:removeTyres",Entity,Tyre)
					end
				end
			end
		else
			TriggerEvent("Notify","amarelo","<b>Chave Inglesa</b> não encontrada.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:EXPLODETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:explodeTyres")
AddEventHandler("inventory:explodeTyres",function(vehNet,vehPlate,Tyre)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tyreStatus()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		local Vehicle = vRP.nearVehicle(5)
		local coords = GetEntityCoords(ped)

		for k,Tyre in pairs(tyreList) do
			local Selected = GetEntityBoneIndexByName(Vehicle,k)
			if Selected ~= -1 then
				local coordsWheel = GetWorldPositionOfEntityBone(Vehicle,Selected)
				local distance = #(coords - coordsWheel)
				if distance <= 1.0 then
					return true,Tyre,VehToNet(Vehicle),GetVehicleNumberPlateText(Vehicle)
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tyreHealth(vehNet,Tyre)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			return GetTyreHealth(Vehicle,Tyre)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local DrugsPeds = {}
local StealPeds = {}
local DrugsTimer = GetGameTimer()
local StealTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTEALNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(Ped) and IsPedArmed(Ped,7) then
			local Handler,Selected = FindFirstPed()

			repeat
				if not IsEntityDead(Selected) and not StealPeds[Selected] and not IsPedDeadOrDying(Selected) and GetPedArmour(Selected) <= 0 and not IsPedAPlayer(Selected) and not IsPedInAnyVehicle(Selected) and GetPedType(Selected) ~= 28 then
					local Coords = GetEntityCoords(Ped)
					local pCoords = GetEntityCoords(Selected)
					local Distance = #(Coords - pCoords)

					if Distance <= 5 then
						timeDistance = 100

						local Pid = PlayerId()
						if Distance <= 2 and (IsPedInMeleeCombat(Ped) or IsPlayerFreeAiming(Pid)) then
							ClearPedTasks(Selected)
							ClearPedSecondaryTask(Selected)
							ClearPedTasksImmediately(Selected)

							local SelectedTimers = 0
							local SelectedControl = NetworkRequestControlOfEntity(Selected)
							while not SelectedControl and SelectedTimers <= 1000 do
								SelectedControl = NetworkRequestControlOfEntity(Selected)
								SelectedTimers = SelectedTimers + 1
							end

							TaskSetBlockingOfNonTemporaryEvents(Selected,true)
							SetBlockingOfNonTemporaryEvents(Selected,true)
							SetEntityAsMissionEntity(Selected,true,true)
							SetPedDropsWeaponsWhenDead(Selected,false)
							TaskTurnPedToFaceEntity(Selected,Ped,3.0)
							SetPedSuffersCriticalHits(Selected,false)
							SetPedAsNoLongerNeeded(Selected)
							StealPeds[Selected] = true

							RequestAnimDict("random@mugging3")
							while not HasAnimDictLoaded("random@mugging3") do
								Wait(1)
							end

							local SelectedRobbery = 500
							LocalPlayer["state"]["Buttons"] = true
							LocalPlayer["state"]["Commands"] = true
							TaskPlayAnim(Selected,"random@mugging3","handsup_standing_base",8.0,8.0,-1,16,0,0,0,0)

							while true do
								local Coords = GetEntityCoords(Ped)
								local pCoords = GetEntityCoords(Selected)
								local Distance = #(Coords - pCoords)

								if Distance <= 2 and (IsPedInMeleeCombat(Ped) or IsPlayerFreeAiming(Pid)) then
									SelectedRobbery = SelectedRobbery - 1

									if not IsEntityPlayingAnim(Selected,"random@mugging3","handsup_standing_base",3) then
										TaskPlayAnim(Selected,"random@mugging3","handsup_standing_base",8.0,8.0,-1,16,0,0,0,0)
									end

									if SelectedRobbery <= 0 then
										local Anim = "mp_safehouselost@"
										local Hash = "prop_paper_bag_small"

										RequestModel(Hash)
										while not HasModelLoaded(Hash) do
											Wait(1)
										end

										RequestAnimDict(Anim)
										while not HasAnimDictLoaded(Anim) do
											Wait(1)
										end

										local Object = CreateObject(Hash,Coords["x"],Coords["y"],Coords["z"],false,false,false)
										AttachEntityToEntity(Object,Selected,GetPedBoneIndex(Selected,28422),0.0,-0.05,0.05,180.0,0.0,0.0,false,false,false,false,2,true)
										TaskPlayAnim(Selected,Anim,"package_dropoff",8.0,8.0,-1,16,0,0,0,0)

										Wait(3000)

										if DoesEntityExist(Object) then
											SetModelAsNoLongerNeeded(Hash)
											DeleteEntity(Object)
										end

										ClearPedSecondaryTask(Selected)
										TaskWanderStandard(Selected,10.0,10)
										TriggerServerEvent("inventory:StealPeds")

										LocalPlayer["state"]["Buttons"] = false
										LocalPlayer["state"]["Commands"] = false

										break
									end
								else
									ClearPedSecondaryTask(Selected)
									TaskWanderStandard(Selected,10.0,10)

									LocalPlayer["state"]["Buttons"] = false
									LocalPlayer["state"]["Commands"] = false

									break
								end

								Wait(1)
							end
						end
					end
				end

				Success,Selected = FindNextPed(Handler)
			until not Success EndFindPed(Handler)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRUGSPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(Ped) then
			local Handler,Selected = FindFirstPed()

			repeat
				if not IsEntityDead(Selected) and not DrugsPeds[Selected] and not IsPedDeadOrDying(Selected) and GetPedArmour(Selected) <= 0 and not IsPedAPlayer(Selected) and not IsPedInAnyVehicle(Selected) and GetPedType(Selected) ~= 28 then
					local Coords = GetEntityCoords(Ped)
					local pCoords = GetEntityCoords(Selected)
					local Distance = #(Coords - pCoords)

					if Distance <= 1 then
						timeDistance = 1

						if IsControlJustPressed(1,38) and GetGameTimer() >= DrugsTimer and vSERVER.AmountDrugs() then
							DrugsTimer = GetGameTimer() + 5000

							ClearPedTasks(Selected)
							ClearPedSecondaryTask(Selected)
							ClearPedTasksImmediately(Selected)

							local SelectedTimers = 0
							local SelectedRobbery = 500
							LocalPlayer["state"]["Buttons"] = true
							LocalPlayer["state"]["Commands"] = true
							local SelectedControl = NetworkRequestControlOfEntity(Selected)
							while not SelectedControl and SelectedTimers <= 1000 do
								SelectedControl = NetworkRequestControlOfEntity(Selected)
								SelectedTimers = SelectedTimers + 1
							end

							TaskSetBlockingOfNonTemporaryEvents(Selected,true)
							SetBlockingOfNonTemporaryEvents(Selected,true)
							SetEntityAsMissionEntity(Selected,true,true)
							SetPedDropsWeaponsWhenDead(Selected,false)
							TaskTurnPedToFaceEntity(Selected,Ped,3.0)
							SetPedSuffersCriticalHits(Selected,false)
							SetPedAsNoLongerNeeded(Selected)
							DrugsPeds[Selected] = true

							while true do
								local Coords = GetEntityCoords(Ped)
								local pCoords = GetEntityCoords(Selected)
								local Distance = #(Coords - pCoords)

								if Distance <= 2 then
									SelectedRobbery = SelectedRobbery - 1

									if SelectedRobbery <= 0 then
										local Anim = "mp_safehouselost@"
										local Hash = "prop_anim_cash_note"

										RequestModel(Hash)
										while not HasModelLoaded(Hash) do
											Wait(1)
										end

										RequestAnimDict(Anim)
										while not HasAnimDictLoaded(Anim) do
											Wait(1)
										end

										local Object = CreateObject(Hash,Coords["x"],Coords["y"],Coords["z"],false,false,false)
										AttachEntityToEntity(Object,Selected,GetPedBoneIndex(Selected,28422),0.0,0.0,0.0,90.0,0.0,0.0,false,false,false,false,2,true)
										vRP.createObjects(Anim,"package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)
										TaskPlayAnim(Selected,Anim,"package_dropoff",8.0,8.0,-1,16,0,0,0,0)

										Wait(3000)

										if DoesEntityExist(Object) then
											SetModelAsNoLongerNeeded(Hash)
											DeleteEntity(Object)
										end

										vRP.removeObjects()
										ClearPedSecondaryTask(Selected)
										TaskWanderStandard(Selected,10.0,10)
										TriggerServerEvent("inventory:DrugsPeds")

										LocalPlayer["state"]["Buttons"] = false
										LocalPlayer["state"]["Commands"] = false

										break
									end
								else
									ClearPedSecondaryTask(Selected)
									TaskWanderStandard(Selected,10.0,10)

									LocalPlayer["state"]["Buttons"] = false
									LocalPlayer["state"]["Commands"] = false

									break
								end

								Wait(1)
							end
						end
					end
				end

				Success,Selected = FindNextPed(Handler)
			until not Success EndFindPed(Handler)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKARMS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.CheckArms()
	return exports["paramedic"]:Arms()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local disSelect = 1
local disPlate = nil
local disModel = nil
local disActive = false
local disVehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local disCoords = {
	{ 1222.5,-704.47,60.46,280.63 },
	{ 1130.51,-485.59,65.38,73.71 },
	{ 1145.64,-275.44,68.73,87.88 },
	{ 870.49,-36.63,78.54,56.7 },
	{ 686.17,270.39,93.18,240.95 },
	{ 424.75,248.87,102.97,252.29 },
	{ 320.31,344.97,104.97,164.41 },
	{ -305.23,379.3,110.1,14.18 },
	{ -585.54,526.74,107.3,215.44 },
	{ -141.85,-1415.44,30.26,119.06 },
	{ 78.27,-1442.22,29.08,323.15 },
	{ 37.9,-1627.08,29.05,320.32 },
	{ 8.93,-1758.65,29.07,48.19 },
	{ -57.56,-1845.21,26.25,320.32 },
	{ 165.33,-1862.16,23.88,155.91 },
	{ 281.15,-2081.27,16.58,110.56 },
	{ 273.47,-2569.7,5.48,204.1 },
	{ 879.22,-2174.3,30.28,172.92 },
	{ 1116.02,-1502.53,34.46,272.13 },
	{ 1318.13,-534.38,71.83,158.75 },
	{ 1272.4,-353.88,68.85,110.56 },
	{ 653.32,176.89,94.78,68.04 },
	{ 638.88,285.34,102.97,150.24 },
	{ 320.97,495.35,152.24,286.3 },
	{ -74.63,495.95,144.22,8.51 },
	{ 176.89,483.66,141.99,351.5 },
	{ 181.24,380.51,108.55,0.0 },
	{ -398.45,337.43,108.48,0.0 },
	{ -472.76,353.61,103.64,337.33 },
	{ -947.26,574.26,100.76,343.0 },
	{ -1093.13,597.22,102.83,212.6 },
	{ -1271.82,452.79,94.8,19.85 },
	{ -1452.14,533.73,118.98,243.78 },
	{ -1507.85,429.28,110.84,45.36 },
	{ -1945.59,461.12,101.76,96.38 },
	{ -2001.96,368.42,94.24,184.26 },
	{ -1325.69,275.44,63.19,221.11 },
	{ -1281.53,251.9,63.1,0.0 },
	{ -905.31,-161.16,41.65,25.52 },
	{ -1023.98,-889.95,5.43,28.35 },
	{ -1318.87,-1141.38,4.26,90.71 },
	{ -1311.98,-1262.24,4.33,17.01 },
	{ -1297.72,-1316.22,4.5,0.0 },
	{ -1245.66,-1408.65,4.08,306.15 },
	{ -1092.76,-1595.64,4.31,306.15 },
	{ -963.01,-1592.08,4.79,19.85 },
	{ -915.94,-1541.24,4.79,17.01 },
	{ -1612.04,172.37,59.56,206.93 },
	{ -1242.87,381.54,75.12,14.18 },
	{ -1486.76,40.22,54.19,345.83 },
	{ -1576.99,-81.09,53.9,272.13 },
	{ -1391.2,75.67,53.46,130.4 },
	{ -1371.61,-26.18,53.01,0.0 },
	{ -1643.74,-232.78,54.63,252.29 },
	{ -1656.27,-379.46,45.09,232.45 },
	{ -1591.38,-643.5,29.93,232.45 },
	{ -1486.49,-735.27,25.29,181.42 },
	{ -1423.37,-963.41,7.03,56.7 },
	{ -1277.8,-1149.11,6.08,113.39 },
	{ -1070.8,-1424.54,5.12,257.96 },
	{ -1069.67,-1250.98,5.49,119.06 },
	{ -1610.2,-812.21,9.81,138.9 },
	{ -2061.94,-455.86,11.44,320.32 },
	{ -2981.69,83.31,11.29,147.41 },
	{ -3045.4,111.55,11.32,320.32 },
	{ -2960.51,368.42,14.54,31.19 },
	{ -3052.28,599.99,7.11,289.14 },
	{ -3253.1,987.45,12.23,0.0 },
	{ -3236.9,1038.27,11.42,266.46 },
	{ -3156.21,1153.75,20.83,246.62 },
	{ -1819.34,785.21,137.68,223.94 },
	{ -1749.7,366.06,89.47,116.23 },
	{ -1194.9,322.62,70.48,17.01 },
	{ -1207.54,272.21,69.3,286.3 },
	{ -722.21,-76.25,37.31,243.78 },
	{ -475.64,-218.96,36.16,212.6 },
	{ -532.25,-270.6,34.98,110.56 },
	{ -465.2,-451.88,33.97,82.21 },
	{ -391.09,-456.15,30.72,127.56 },
	{ -357.4,-767.63,38.55,272.13 },
	{ -330.9,-935.02,30.85,68.04 },
	{ -27.99,-2547.6,5.78,53.86 },
	{ -140.18,-2506.08,5.76,53.86 },
	{ -168.21,-2583.56,5.76,0.0 },
	{ -219.34,-2488.65,5.76,87.88 },
	{ -340.93,-2430.9,5.76,138.9 },
	{ -434.24,-2441.94,5.76,232.45 },
	{ 124.19,-2898.73,5.76,0.0 },
	{ 237.55,-3315.73,5.56,201.26 },
	{ 150.76,-3184.91,5.63,178.59 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLECATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
local DismantleCategory = {
	["B"] = {
		"panto","prairie","rhapsody","blista","dilettante","emperor2","emperor","bfinjection","ingot","regina"
	},
	["B+"] = {
		"asbo","brioso","club","weevil","felon","felon2","jackal","oracle","zion","zion2","buccaneer","virgo",
		"voodoo","bifta","rancherxl","bjxl","cavalcade","gresley","habanero","rocoto","primo","stratum","pigalle",
		"peyote","manana","streiter"
	},
	["A"] = {
		"exemplar","windsor","windsor2","blade","clique","dominator","faction2","gauntlet","moonbeam","nightshade",
		"sabregt2","tampa","rebel","baller","cavalcade2","fq2","huntley","landstalker","patriot","radi","xls","blista2",
		"retinue","stingergt","surano","specter","sultan","schwarzer","schafter2","ruston","rapidgt","raiden","ninef",
		"ninef2","omnis","massacro","jester","feltzer2","futo","carbonizzare"
	},
	["A+"] = {
		"voltic","sc1","sultanrs","tempesta","nero","nero2","reaper","gp1","infernus","bullet","banshee2","turismo2","retinue",
		"mamba","infernus2","feltzer3","coquette2","futo2","zr350","tampa2","sugoi","sultan2","schlagen","penumbra","pariah",
		"paragon","jester3","gb200","elegy","furoregt"
	},
	["S"] = {
		"zentorno","xa21","visione","vagner","vacca","turismor","t20","osiris","italigtb","entityxf","cheetah","autarch","sultan3",
		"cypher","vectre","growler","comet6","jester4","euros","calico","neon","kuruma","issi7","italigto","komoda","elegy2","coquette4"
	},
	["S+"] = {
		"mazdarx72","rangerover","civictyper","subaruimpreza","corvettec7","ferrariitalia","mustang1969","vwtouareg",
		"mercedesg65","bugattiatlantic","m8competition","audirs6","audir8","silvias15","camaro","mercedesamg63",
		"dodgechargerrt69","skyliner342","astonmartindbs","panameramansory","lamborghinihuracanlw","lancerevolutionx",
		"porsche911","jeepcherokee","dodgecharger1970","golfgti","subarubrz","nissangtr","mustangfast","golfmk7",
		"lancerevolution9","shelbygt500","ferrari812","bmwm4gts","ferrarif12","bmwm5e34","toyotasupra2","escalade2021",
		"fordmustang","mclarensenna","lamborghinihuracan","acuransx","toyotasupra","escaladegt900","bentleybacalar"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Dismantle(Experience)
	if not disActive then
		disActive = true
		disSelect = math.random(#disCoords)
		disPlate = "DISM"..(1000 + LocalPlayer["state"]["Id"])

		local Category = ClassCategory(Experience)
		local ModelRandom = math.random(#DismantleCategory[Category])
		disModel = DismantleCategory[Category][ModelRandom]

		local RandomX = math.random(25,100)
		local RandomY = math.random(25,100)

		if math.random(2) >= 2 then
			TriggerEvent("NotifyPush",{ code = 20, title = "Localização do Veículo", x = disCoords[disSelect][1] + RandomX + 0.0, y = disCoords[disSelect][2] - RandomY + 0.0, z = disCoords[disSelect][3], vehicle = vehicleName(disModel).." - "..disPlate, blipColor = 60 })
		else
			TriggerEvent("NotifyPush",{ code = 20, title = "Localização do Veículo", x = disCoords[disSelect][1] - RandomX + 0.0, y = disCoords[disSelect][2] + RandomY + 0.0, z = disCoords[disSelect][3], vehicle = vehicleName(disModel).." - "..disPlate, blipColor = 60 })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.DismantleStatus()
	return disActive
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Disreset")
AddEventHandler("inventory:Disreset",function()
	disSelect = 1
	disPlate = nil
	disModel = nil
	disActive = false
	disVehicle = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if disActive and not disVehicle then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Distance = #(Coords - vec3(disCoords[disSelect][1],disCoords[disSelect][2],disCoords[disSelect][3]))

			if Distance <= 125 then
				disVehicle = vGARAGE.serverVehicle(disModel,disCoords[disSelect][1],disCoords[disSelect][2],disCoords[disSelect][3],disCoords[disSelect][4],disPlate,1000,nil,1000)

				if NetworkDoesNetworkIdExist(disVehicle) then
					local vehNet = NetToEnt(disVehicle)
					if NetworkDoesNetworkIdExist(vehNet) then
						SetVehicleOnGroundProperly(vehNet)
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local disPeds = {
	"ig_abigail","a_m_m_afriamer_01","ig_mp_agent14","csb_agent","ig_amandatownley","s_m_y_ammucity_01","u_m_y_antonb","g_m_m_armboss_01",
	"g_m_m_armgoon_01","g_m_m_armlieut_01","ig_ashley","s_m_m_autoshop_01","ig_money","g_m_y_ballaeast_01","g_f_y_ballas_01","g_m_y_ballasout_01",
	"s_m_y_barman_01","u_m_y_baygor","a_m_o_beach_01","ig_bestmen","a_f_y_bevhills_01","a_m_m_bevhills_02","u_m_m_bikehire_01","u_f_y_bikerchic",
	"mp_f_boatstaff_01","s_m_m_bouncer_01","ig_brad","ig_bride","u_m_y_burgerdrug_01","a_m_m_business_01","a_m_y_business_02","s_m_o_busker_01",
	"ig_car3guy2","cs_carbuyer","g_m_m_chiboss_01","g_m_m_chigoon_01","g_m_m_chigoon_02","u_f_y_comjane","ig_dale","ig_davenorton","s_m_y_dealer_01",
	"ig_denise","ig_devin","a_m_y_dhill_01","ig_dom","a_m_y_downtown_01","ig_dreyfuss"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local disWeapons = { "WEAPON_HEAVYPISTOL","WEAPON_SMG","WEAPON_ASSAULTSMG","WEAPON_APPISTOL","WEAPON_SPECIALCARBINE","WEAPON_PUMPSHOTGUN" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DisPed")
AddEventHandler("inventory:DisPed",function()
	local Ped = PlayerPedId()
	local Rand = math.random(#disPeds)
	local Coords = GetEntityCoords(Ped)
	local Weapon = math.random(#disWeapons)
	local cX = Coords["x"] + math.random(-25.0,25.0)
	local cY = Coords["y"] + math.random(-25.0,25.0)
	local Hit,EntCoords = GetSafeCoordForPed(cX,cY,Coords["z"],false,16)
	local Entity,EntityNet = vRPS.CreatePed(disPeds[Rand],EntCoords["x"],EntCoords["y"],EntCoords["z"],3374176,4)
	if Entity then
		Wait(1000)

		local SpawnEntity = 0
		local NetEntity = NetworkGetEntityFromNetworkId(EntityNet)
		while not DoesEntityExist(NetEntity) and SpawnEntity <= 1000 do
			NetEntity = NetworkGetEntityFromNetworkId(EntityNet)
			SpawnEntity = SpawnEntity + 1
			Wait(1)
		end

		SpawnEntity = 0
		local NetControl = NetworkRequestControlOfEntity(NetEntity)
		while not NetControl and SpawnEntity <= 1000 do
			NetControl = NetworkRequestControlOfEntity(NetEntity)
			SpawnEntity = SpawnEntity + 1
			Wait(1)
		end

		SetPedArmour(NetEntity,100)
		SetPedAccuracy(NetEntity,100)
		SetPedKeepTask(NetEntity,true)
		SetCanAttackFriendly(NetEntity,false,true)
		TaskCombatPed(NetEntity,Ped,0,16)
		SetPedCombatAttributes(NetEntity,46,true)
		SetPedCombatAbility(NetEntity,2)
		SetPedCombatAttributes(NetEntity,0,true)
		GiveWeaponToPed(NetEntity,disWeapons[Weapon],-1,false,true)
		SetPedDropsWeaponsWhenDead(NetEntity,false)
		SetPedCombatRange(NetEntity,2)
		SetPedFleeAttributes(NetEntity,0,0)
		SetPedConfigFlag(NetEntity,58,true)
		SetPedConfigFlag(NetEntity,75,true)
		SetPedFiringPattern(NetEntity,-957453492)
		SetBlockingOfNonTemporaryEvents(NetEntity,true)
		SetEntityAsNoLongerNeeded(NetEntity)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.CheckMods(Vehicle,Mod)
	return GetNumVehicleMods(Vehicle,Mod) - 1
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCAR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.CheckCar(Vehicle)
	local Model = GetEntityModel(Vehicle)
	return IsThisModelACar(Model)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.ActiveMods(Vehicle,Plate,Mod,Number)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleMod(Vehicle,Mod,Number)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
local BuffShot = PolyZone:Create({
	vector2(-1174.21,-898.17),
	vector2(-1188.63,-908.10),
	vector2(-1198.07,-906.52),
	vector2(-1208.42,-891.13),
	vector2(-1188.37,-877.37)
},{ name = "BurgerShot" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFTHIS
-----------------------------------------------------------------------------------------------------------------------------------------
local BuffThis = PolyZone:Create({
	vector2(793.94,-747.72),
	vector2(794.00,-768.85),
	vector2(814.90,-768.82),
	vector2(814.93,-747.62),
	vector2(812.48,-739.99),
	vector2(794.07,-740.05)
},{ name = "PizzaThis" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFBEAN
-----------------------------------------------------------------------------------------------------------------------------------------
local BuffBean = PolyZone:Create({
	vector2(129.73,-1029.63),
	vector2(118.45,-1025.35),
	vector2(110.82,-1046.34),
	vector2(122.31,-1050.47)
},{ name = "BeanMachine" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFCOFFEE
-----------------------------------------------------------------------------------------------------------------------------------------
local BuffCoffee = PolyZone:Create({
	vector2(-565.30,-1071.24),
	vector2(-575.38,-1070.52),
	vector2(-601.44,-1069.51),
	vector2(-601.53,-1046.78),
	vector2(-565.33,-1047.50)
},{ name = "UwUCoffe" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local BuffTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if GetGameTimer() >= BuffTimer then
				local Coords = GetEntityCoords(Ped)
				if (BuffShot:isPointInside(Coords) or BuffBean:isPointInside(Coords)) then
					TriggerServerEvent("inventory:BuffClient","Destreza",90)
					BuffTimer = GetGameTimer() + 60000
				elseif (BuffThis:isPointInside(Coords) or BuffCoffee:isPointInside(Coords)) then
					TriggerServerEvent("inventory:BuffClient","Sorte",90)
					BuffTimer = GetGameTimer() + 60000
				end
			end
		end

		Wait(1000)
	end
end)