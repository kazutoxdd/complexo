-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("player",cRP)
vCLIENT = Tunnel.getInterface("player")
vSKINSHOP = Tunnel.getInterface("skinshop")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Objects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		local message = string.sub(rawCommand:sub(4),1,100)

		local Players = vRPC.Players(source)
		for _,v in ipairs(Players) do
			async(function()
				TriggerClientEvent("showme:pressMe",v,source,message,10)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("upgradeStress")
AddEventHandler("upgradeStress",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("downgradeStress")
AddEventHandler("downgradeStress",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.downgradeStress(user_id,number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:KICKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:kickSystem")
AddEventHandler("player:kickSystem",function(message)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasGroup(user_id,"Admin") then
			vRP.kick(user_id,message)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 100 then
		if args[2] == "friend" then
			local otherPlayer = vRPC.ClosestPed(source,1)
			if otherPlayer then
				if vRP.getHealth(otherPlayer) > 100 and not vCLIENT.getHandcuff(otherPlayer) then
					local identity = vRP.userIdentity(user_id)
					if vRP.request(otherPlayer,"Pedido de <b>"..identity["name"].."</b> da animação <b>"..args[1].."</b>?") then
						TriggerClientEvent("emotes",otherPlayer,args[1])
						TriggerClientEvent("emotes",source,args[1])
					end
				end
			end
		else
			if not vCLIENT.getHandcuff(source) then
				TriggerClientEvent("emotes",source,args[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 100 then
		local otherPlayer = vRPC.ClosestPed(source,1)
		if otherPlayer then
			if vRP.hasGroup(user_id,"Paramedic") then
				TriggerClientEvent("emotes",otherPlayer,args[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Doors")
AddEventHandler("player:Doors",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet = vRPC.vehList(source,5)
		if vehicle then
			local Players = vRPC.Players(source)
			for _,v in ipairs(Players) do
				async(function()
					TriggerClientEvent("player:syncDoors",v,vehNet,number)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getSalary()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.userPremium(user_id) then
			TriggerEvent("vRP:updateSalary",user_id,1500)
			TriggerClientEvent("Notify",source,"azul","Salário de <b>$1.500</b> recebido.",5000)
		end

		if vRP.hasGroup(user_id,"Emergency") then
			local emergencyResult = vRP.numPermission("Emergency")
			if parseInt(#emergencyResult) >= 6 then
				TriggerEvent("vRP:updateSalary",user_id,4500)
				TriggerClientEvent("Notify",source,"azul","Salário de <b>$4.500</b> recebido.",5000)
			else
				TriggerEvent("vRP:updateSalary",user_id,3500)
				TriggerClientEvent("Notify",source,"azul","Salário de <b>$3.500</b> recebido.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("911",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] and vRP.getHealth(source) > 100 then
		if vRP.hasGroup(user_id,"Police") then
			local department = "Police"
			if vRP.hasPermission(user_id,"State") then
				department = "STATE POLICE"
			elseif vRP.hasPermission(user_id,"Lspd") then
				department = "LSPD"
			elseif vRP.hasPermission(user_id,"Ranger") then
				department = "PARK RANGER"
			elseif vRP.hasPermission(user_id,"Corrections") then
					department = "CORRECTIONS"
			elseif vRP.hasPermission(user_id,"Sheriff") then
				department = "SHERIFF"
			end

			local identity = vRP.userIdentity(user_id)
			local policeResult = vRP.numPermission("Police")
			for k,v in pairs(policeResult) do
				async(function()
					TriggerClientEvent("chatME",v,"^2911^3"..department.."^9"..identity["name"].."^0"..rawCommand:sub(4))
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("112",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] and vRP.getHealth(source) > 100 then
		if vRP.hasGroup(user_id,"Paramedic") then
			local identity = vRP.userIdentity(user_id)
			local paramedicResult = vRP.numPermission("Paramedic")
			for k,v in pairs(paramedicResult) do
				async(function()
					TriggerClientEvent("chatME",v,"^4112^9"..identity["name"].." "..identity["name2"].."^0"..rawCommand:sub(4))
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.shotsFired()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local policeResult = vRP.numPermission("Police")

		for k,v in pairs(policeResult) do
			async(function()
				TriggerClientEvent("NotifyPush",v,{ code = 10, title = "Confronto em andamento", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Disparos de arma de fogo", blipColor = 6 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = {}
RegisterServerEvent("player:carryPlayer")
AddEventHandler("player:carryPlayer",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRPC.inVehicle(source) then
			if playerCarry[user_id] then
				TriggerClientEvent("player:playerCarry",playerCarry[user_id],source)
				TriggerClientEvent("player:Commands",playerCarry[user_id],false)
				playerCarry[user_id] = nil
			else
				local otherPlayer = vRPC.ClosestPed(source,1.2)
				if otherPlayer then
					playerCarry[user_id] = otherPlayer

					TriggerClientEvent("player:playerCarry",playerCarry[user_id],source)
					TriggerClientEvent("player:Commands",playerCarry[user_id],true)
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- carregarJogador
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarryGod = {}
RegisterServerEvent("player:carregarJogador")
AddEventHandler("player:carregarJogador",function(args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if not vRPC.inVehicle(source) then
				if playerCarryGod[user_id] then
					TriggerClientEvent("player:playerCarry",playerCarryGod[user_id],source)
					TriggerClientEvent("player:Commands",playerCarryGod[user_id],false)
					playerCarryGod[user_id] = nil
				else
					local otherPlayer = vRPC.ClosestPed(source,1.5)
					if otherPlayer then
						playerCarryGod[user_id] = otherPlayer
	
						TriggerClientEvent("player:playerCarry",playerCarryGod[user_id],source)
						TriggerClientEvent("player:Commands",playerCarryGod[user_id],true)
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING LUCKY UTILIZAR COMO BASE O SEATBELT NO HUD, FAZER CARREGAR NO H do playerCarry
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterKeyMapping("carregarJogador","Carregar player.","keyboard","h")

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions",function(mode)
	local source = source
	local vehicle,vehNet = vRPC.vehSitting(source)
	if vehicle then
		local Players = vRPC.Players(source)
		for _,v in ipairs(Players) do
			async(function()
				TriggerClientEvent("player:syncWins",v,vehNet,mode)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions",function(mode)
	local source = source
	local distance = 1.1

	if mode == "rv" then
		distance = 10.0
	end

	local otherPlayer = vRPC.ClosestPed(source,distance)
	if otherPlayer then
		local user_id = vRP.getUserId(source)
		local consultItem = vRP.getInventoryItemAmount(user_id,"rope")
		if vRP.hasGroup(user_id,"Emergency") or consultItem[1] >= 1 then
			local vehicle,vehNet = vRPC.vehList(source,5)
			if vehicle then
				local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
				local doorStatus = GetVehicleDoorLockStatus(idNetwork)
			
				if parseInt(doorStatus) <= 1 then
					if mode == "rv" then
						vCLIENT.removeVehicle(otherPlayer)
					elseif mode == "cv" then
						vCLIENT.putVehicle(otherPlayer,vehNet)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 60
		TriggerClientEvent("Progress",source,60000)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("inventory:Buttons",source,true)
		vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source)

				local vehicle,vehNet = vRPC.vehList(source,5)
				if vehicle then
					local Players = vRPC.Players(source)
					for _,v in ipairs(Players) do
						async(function()
							TriggerClientEvent("target:RollVehicle",source,vehNet)
						end)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			end

			Wait(100)
		until Active[user_id] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["1"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 23, texture = 0 },
			["vest"] = { item = 16, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 24, texture = 0 },
			["torso"] = { item = 24, texture = 0 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 17, texture = 0 },
			["vest"] = { item = 18, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 22, texture = 0 },
			["torso"] = { item = 23, texture = 0 },
			["accessory"] = { item = 14, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["2"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 23, texture = 0 },
			["vest"] = { item = 24, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 24, texture = 0 },
			["torso"] = { item = 26, texture = 0 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 11, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 17, texture = 0 },
			["vest"] = { item = 15, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 22, texture = 0 },
			["torso"] = { item = 20, texture = 0 },
			["accessory"] = { item = 14, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["3"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 34, texture = 0 }, --
			["pants"] = { item = 19, texture = 2 },--
			["vest"] = { item = 39, texture = 0 },--
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 169, texture = 0 },--
			["shoes"] = { item = 25, texture = 0 },--
			["tshirt"] = { item = 25, texture = 0 },--
			["torso"] = { item = 33, texture = 5 },--
			["accessory"] = { item = 0, texture = 0 },--
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },--
			["glass"] = { item = 50, texture = 0 },--
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 23, texture = 0 },--
			["pants"] = { item = 17, texture = 2 },--
			["vest"] = { item = 20, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 169, texture = 0 },--
			["shoes"] = { item = 25, texture = 0 },--
			["tshirt"] = { item = 16, texture = 0 },--
			["torso"] = { item = 16, texture = 6 },--
			["accessory"] = { item = 10, texture = 1 },--
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 47, texture = 0 },--
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["4"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 25, texture = 0 },
			["pants"] = { item = 21, texture = 0 },
			["vest"] = { item = 28, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 31, texture = 0 },
			["torso"] = { item = 31, texture = 0 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 12, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 32, texture = 2 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 13, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = -1, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 25, texture = 0 },
			["torso"] = { item = 26, texture = 7 },
			["accessory"] = { item = 14, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 7, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["5"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 13, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 17, texture = 0 },
			["torso"] = { item = 32, texture = 	3 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 14, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 25, texture = 0 },
			["torso"] = { item = 16, texture = 5 },
			["accessory"] = { item = 14, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["6"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 74, texture = 6 },
			["vest"] = { item = 12, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 125, texture = 10 },
			["tshirt"] = { item = 25, texture = 0 },
			["torso"] = { item = 33, texture = 4 },
			["accessory"] = { item = 21, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 0, texture = 0 },
			["vest"] = { item = 12, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 1, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 27, texture = 0 },
			["accessory"] = { item = 11, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["7"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 164, texture = 2 },
			["vest"] = { item = 14, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 96, texture = 0 },
			["tshirt"] = { item = 25, texture = 1 },
			["torso"] = { item = 32, texture = 2 },
			["accessory"] = { item = 19, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 141, texture = 3 },
			["vest"] = { item = 12, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 27, texture = 0 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["8"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 11, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 }, 
			["tshirt"] = { item = 25, texture = 0 },
			["torso"] = { item = 17, texture = 1 },
			["accessory"] = { item = 19, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 201, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 21, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 16, texture = 0 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["9"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 1 },
			["vest"] = { item = 11, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 63, texture = 0 },
			["tshirt"] = { item = 251, texture = 1 },
			["torso"] = { item = 16, texture = 0 },
			["accessory"] = { item = 19, texture = 0 }, 
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 21, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 26, texture = 0 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 53, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["10"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 13, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 29, texture = 0 },
			["torso"] = { item = 32, texture = 1 },
			["accessory"] = { item = 19, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 201, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 14, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 19, texture = 0 },
			["torso"] = { item = 16, texture = 4 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 57, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["11"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 195, texture = 1 },
			["torso"] = { item = 23, texture = 5 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 203, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 9, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 23, texture = 3 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 57, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},

	-- PARAMEDIC

	["12"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 34, texture = 5 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 42, texture = 2 },
			["tshirt"] = { item = 42, texture = 0 },
			["torso"] = { item = 469, texture = 1 },
			["accessory"] = { item = 139, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 82, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 28, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 158, texture = 2 },
			["tshirt"] = { item = 56, texture = 0 },
			["torso"] = { item = 558, texture = 1 },
			["accessory"] = { item = 110, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 101, texture = 1 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["13"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 195, texture = 1 },
			["torso"] = { item = 23, texture = 5 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 203, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 16, texture = 0 },
			["vest"] = { item = 9, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 2 },
			["tshirt"] = { item = 16, texture = 0 },
			["torso"] = { item = 23, texture = 3 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 57, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	-- UWU CAFE
	["14"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 195, texture = 1 },
			["torso"] = { item = 23, texture = 5 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 203, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 160, texture = 3 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 81, texture = 2 },
			["tshirt"] = { item = 203, texture = 0 },
			["torso"] = { item = 395, texture = 2 },
			["accessory"] = { item = 37, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 9, texture = 0 },
			["glass"] = { item = 46, texture = 3 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	--PANELA
	["15"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 19, texture = 0 },
			["vest"] = { item = 10, texture = 3 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 25, texture = 0 },
			["torso"] = { item = 36, texture = 0 },
			["accessory"] = { item = 20, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 18, texture = 0 },
			["vest"] = { item = 11, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 24, texture = 0 },
			["tshirt"] = { item = 14, texture = 0 },
			["torso"] = { item = 15, texture = 0 },
			["accessory"] = { item = 10, texture = 1 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = -1, texture = 0 },
			["glass"] = { item = 5, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:presetFunctions")
AddEventHandler("player:presetFunctions",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Emergency") or vRP.hasGroup(user_id,"Uwucafe") then
			local model = vRP.modelPlayer(source)

			if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",source,preset[number][model])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local otherPlayer = vRPC.ClosestPed(source,1)
		if otherPlayer then
			local otherPlayer_id = vRP.getUserId(otherPlayer)
			if vSKINSHOP.checkShoes(otherPlayer) then
				if Active[otherPlayer_id] == nil then
					Active[otherPlayer_id] = os.time() + 15
					vRP.generateItem(user_id,"WEAPON_SHOES",2,true)
				else
					local waitTimers = parseInt(Active[otherPlayer_id] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..waitTimers.." segundos</b>.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local otherPlayer = vRPC.ClosestPed(source,1)
	if otherPlayer then
		TriggerClientEvent("player:checkTrunk",otherPlayer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	local source = source
	local otherPlayer = vRPC.ClosestPed(source,1)
	if otherPlayer then
		TriggerClientEvent("player:checkTrash",otherPlayer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
local removeFit = {
	["homem"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mulher"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:outfitFunctions")
AddEventHandler("player:outfitFunctions",function(mode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and not exports["hud"]:Repose(user_id) and not exports["hud"]:Wanted(user_id) then
		if mode == "aplicar" then
			local result = vRP.getSrvdata("saveClothes:"..user_id)
			if result["pants"] ~= nil then
				TriggerClientEvent("updateRoupas",source,result)
				TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
			end
		elseif mode == "preaplicar" then
			if vRP.userPremium(user_id) then
				local result = vRP.getSrvdata("premClothes:"..user_id)
				if result["pants"] ~= nil then
					TriggerClientEvent("updateRoupas",source,result)
					TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
				end
			end
		elseif mode == "salvar" then
			local checkBackpack = vSKINSHOP.checkBackpack(source)
			if not checkBackpack then
				local custom = vSKINSHOP.getCustomization(source)
				if custom then
					vRP.setSrvdata("saveClothes:"..user_id,custom)
					TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Remova do corpo o acessório item.",5000)
			end
		elseif mode == "presalvar" then
			if vRP.userPremium(user_id) then
				local checkBackpack = vSKINSHOP.checkBackpack(source)
				if not checkBackpack then
					local custom = vSKINSHOP.getCustomization(source)
					if custom then
						vRP.setSrvdata("premClothes:"..user_id,custom)
						TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Remova do corpo o acessório item.",5000)
				end
			end
		elseif mode == "remover" then
			local model = vRP.modelPlayer(source)
			if model == "mp_m_freemode_01" then
				TriggerClientEvent("updateRoupas",source,removeFit["homem"])
			elseif model == "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",source,removeFit["mulher"])
			end
		else
			TriggerClientEvent("skinshop:set"..mode,source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("add",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] and parseInt(args[2]) > 0 then
		local Group = args[1]
		local nuser_id = parseInt(args[2])

		local identity = vRP.userIdentity(nuser_id)
		if identity then
			if vRP.hasPermission(user_id,"set"..Group) then
				vRP.cleanPermission(nuser_id)
				vRP.setPermission(nuser_id,Group)
				TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..nuser_id.."</b> adicionado.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] and parseInt(args[2]) > 0 then
		local Group = args[1]
		local nuser_id = parseInt(args[2])

		local identity = vRP.userIdentity(nuser_id)
		if identity then
			if vRP.hasPermission(user_id,"set"..Group) then
				vRP.cleanPermission(nuser_id)
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..nuser_id.."</b> removido.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:deathLogs")
AddEventHandler("player:deathLogs",function(nSource)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and source ~= nSource then
		local nuser_id = vRP.getUserId(nSource)
		if nuser_id then
			TriggerEvent("discordLogs","Deaths","**Matou:** "..user_id.."\n**Morreu:** "..nuser_id.."\n**Horário:** "..os.date("%H:%M:%S"),3092790)
		end
	end
end)
------------------------------ -----------------------------------------------------------------------------------------------------------
-- DISCORDLINKS  
-----------------------------------------------------------------------------------------------------------------------------------------
local discordLinks = {
	["Disconnect"] = "",
	["Airport"] = "",
	["Deaths"] = "",----
	["SetGroup"] = "",--
	["PoliceS"] = "",---
	["Police"] = "",---
	["State"] = "",--
	["Sheriff"] = "",--
	["Corrections"] = "",--
	["Paramedic"] = "",--
	["Hackers"] = "",--
	["Gemstones"] = "",--
	["Badges"] = "",--
	["Suggestions"] = "",--
	["addValueBank"] = "",--
	["itemGeneration"] = "",--
	["PoliceCore"] = "",-----
	["Sheriff2"] = "",------
	["Comanf"] = "",------

	--ADMIN
	["God"] = "",--
	["Blips"] = "",-- 
	["Police"] = "",
	["Robberys"] = "",
	["Delete"] = "",
	
	--FACS
	["Cupula"] = "",
	["Ballas"] = "",
	["Motoclub"] = "",
	["Cosanostra"] ="",
	["Vinhedo"] ="",
	["Fazenda"] ="",
	["Pedreira"] ="",
	["Grota"] ="",
	["FavelaSV"] ="",
	["Vagos"] ="",
	["Bahamas"] ="",
	["Vanilla"] ="",
	["FavelaNH"] ="",
	["Arcade"] ="",
	["Bennys"] = "",
	["Chacara"] ="",
	["FavelaDK"] ="",
	["Salieris"] ="",
	["PlayBoy"] = "",
	["BDT"] = "",
	["FerroVelho"] = "",
	["Yakuza"] = "",
	["Crips"] = "",
	["Bloods"] = "",
	["Duros"] = "",
	["Primatas"] = "",
	["HotGirls"] = "",
	["BLX"] = "",

	["LiderBallas"] = "",
	["LiderMotoclub"] = "",
	["LiderCosanostra"] ="",
	["LiderVinhedo"] ="",
	["LiderFazenda"] ="",
	["LiderPedreira"] ="",
	["LiderGrota"] ="",
	["LiderFavelaSV"] ="",
	["LiderVagos"] ="",
	["LiderBahamas"] ="",
	["LiderVanilla"] ="",
	["LiderFavelaNH"] ="",
	["LiderArcade"] ="",
	["LiderChacara"] ="",
	["LiderFavelaDK"] ="",
	["LiderSalieris"] ="",
	["LiderBDT"] = "",
	["LiderYakuza"] = "",
	["LiderPrimatas"] = "",
	["LiderBLX"] = "",
	["LiderHotGirls"] = "",
	["LiderFerroVelho"] = "", 
	["LiderCrips"] = "",
	["LiderBloods"] = "",

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("discordLogs")
AddEventHandler("discordLogs",function(webhook,message,color)
	PerformHttpRequest(discordLinks[webhook],function(err,text,headers) end,"POST",json.encode({
		username = "STATE - LOGS",
		embeds = { { color = color, description = message } }
	}),{ ["Content-Type"] = "application/json" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bikesBackpack()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local amountWeight = 10
		local myWeight = vRP.getWeight(user_id)

		if parseInt(myWeight) < 45 then
			amountWeight = 15
		elseif parseInt(myWeight) >= 45 and parseInt(myWeight) <= 79 then
			amountWeight = 10
		elseif parseInt(myWeight) >= 80 and parseInt(myWeight) <= 95 then
			amountWeight = 5
		elseif parseInt(myWeight) >= 100 and parseInt(myWeight) <= 148 then
			amountWeight = 2
		elseif parseInt(myWeight) >= 150 then
			amountWeight = 1
		end

		vRP.setWeight(user_id,amountWeight)
	end
end
--PREFEM
RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	print("got to srv cmg3_animations:sync")
	print("got that fucking attach flag as: " .. tostring(attachFlag))
	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	print("triggering to target: " .. tostring(targetSrc))
	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if playerCarry[user_id] then
		TriggerClientEvent("player:Commands",playerCarry[user_id],false)
		playerCarry[user_id] = nil
	end

	if Active[user_id] then
		Active[user_id] = nil
	end
end)