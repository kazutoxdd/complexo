-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("paramedic",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Damaged = {}
local Bleeding = 0
local BloodTick = 0
local Injuried = GetGameTimer()
local BloodTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(name,args)
	if LocalPlayer["state"]["Route"] < 900000 then
		if name == "CEventNetworkEntityDamage" then
			if PlayerPedId() == args[1] and LocalPlayer["state"]["Active"] then
				if args[7] == 126349499 or args[7] == 1064738331 or args[7] == 85055149 then
					SetPedToRagdoll(PlayerPedId(),2500,2500,0,0,0,0)
				else
					if GetGameTimer() >= Injuried then
						if not IsPedInAnyVehicle(args[1]) and GetEntityHealth(args[1]) > 100 then
							Injuried = GetGameTimer() + 1000

							local Hit,Mark = GetPedLastDamageBone(args[1])
							if Hit and not Damaged[Mark] and Mark ~= 0 then
								TriggerServerEvent("evidence:dropEvidence","yellow")
								Bleeding = Bleeding + 1
								Damaged[Mark] = true
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOODTICK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if GetGameTimer() >= BloodTimers and LocalPlayer["state"]["Route"] < 900000 and GetEntityHealth(Ped) > 100 then
			BloodTimers = GetGameTimer() + 10000
			BloodTick = BloodTick + 1

			if BloodTick >= 3 and Bleeding >= 3 then
				BloodTick = 0
				
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Reset")
AddEventHandler("paramedic:Reset",function()
	Damaged = {}
	Bleeding = 0
	BloodTick = 0
	Injuried = GetGameTimer()
	BloodTimers = GetGameTimer()
	ClearPedBloodDamage(PlayerPedId())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Bleeding()
	return Bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Bandage()
	local Humanes = ""
	for k,v in pairs(Damaged) do
		TriggerEvent("Notify","amarelo","Passou ataduras no(a) <b>"..Bone(k).."</b>.",3000)
		TriggerEvent("sounds:source","bandage",0.5)
		Bleeding = Bleeding - 1
		Humanes = Bone(k)
		Damaged[k] = nil
		BloodTick = 0
		break
	end

	if Bleeding <= 0 then
		ClearPedBloodDamage(PlayerPedId())
	end

	return Humanes
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:INJURIES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Injuries")
AddEventHandler("paramedic:Injuries",function()
	local Number = 0
	local Injuries = ""
	local Damages = false

	for k,v in pairs(Damaged) do
		if not Damages then
			Injuries = Injuries.."<b>Danos Superficiais:</b><br>"
			Damages = true
		end

		Number = Number + 1
		Injuries = Injuries.."<b>"..Number.."</b>: "..Bone(k).."<br>"
	end

	if Injuries == "" then
		TriggerEvent("Notify","amarelo","Nenhum ferimento encontrado.",5000)
	else
		TriggerEvent("Notify","amarelo",Injuries,10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Diagnostic()
	return Damaged,Bleeding
end