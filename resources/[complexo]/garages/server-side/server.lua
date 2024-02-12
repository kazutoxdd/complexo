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
Tunnel.bindInterface("garages",cRP)
vPLAYER = Tunnel.getInterface("player")
vCLIENT = Tunnel.getInterface("garages")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local vehSpawn = {}
local vehSignal = {}
local searchTimers = {}
GlobalState["vehPlates"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.serverVehicle(model,x,y,z,heading,vehPlate,nitroFuel,vehDoors,vehBody)
	local spawnVehicle = 0
	local mHash = GetHashKey(model)
	local myVeh = CreateVehicle(mHash,x,y,z,heading,true,true)

	while not DoesEntityExist(myVeh) and spawnVehicle <= 1000 do
		spawnVehicle = spawnVehicle + 1
		Wait(100)
	end

	if DoesEntityExist(myVeh) then
		if vehPlate ~= nil then
			SetVehicleNumberPlateText(myVeh,vehPlate)
		else
			vehPlate = vRP.generatePlate()
			SetVehicleNumberPlateText(myVeh,vehPlate)
		end

		SetVehicleBodyHealth(myVeh,vehBody + 0.0)

		if vehDoors then
			local vehDoors = json.decode(vehDoors)
			if vehDoors ~= nil then
				for k,v in pairs(vehDoors) do
					if v then
						SetVehicleDoorBroken(myVeh,parseInt(k),true)
					end
				end
			end
		end

		local netVeh = NetworkGetNetworkIdFromEntity(myVeh)

		if model ~= "wheelchair" then
			local idNetwork = NetworkGetEntityFromNetworkId(netVeh)
			SetVehicleDoorsLocked(idNetwork,2)

			local Nitro = GlobalState["Nitro"]
			Nitro[vehPlate] = nitroFuel or 0
			GlobalState["Nitro"] = Nitro
		end

		return true,netVeh,mHash,myVeh
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGELOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local garageLocates = {
	["1"] = { name = "Garage", payment = false },
	["2"] = { name = "Garage", payment = false },
	["3"] = { name = "Garage", payment = false },
	["4"] = { name = "Garage", payment = false },
	--["5"] = { name = "Garage", payment = false },
	["6"] = { name = "Garage", payment = false },
	["7"] = { name = "Garage", payment = false },
	["8"] = { name = "Garage", payment = false },
	["9"] = { name = "Garage", payment = false },
	["10"] = { name = "Garage", payment = false },
	["11"] = { name = "Garage", payment = false },
	["12"] = { name = "Garage", payment = false },
	["13"] = { name = "Garage", payment = false },
	["14"] = { name = "Garage", payment = false },
	["15"] = { name = "Garage", payment = false },
	["16"] = { name = "Garage", payment = false },
	["17"] = { name = "Garage", payment = false },
	["18"] = { name = "Garage", payment = false },
	["19"] = { name = "Garage", payment = false },
	["20"] = { name = "Garage", payment = false },
	["21"] = { name = "Garage", payment = false },
	["22"] = { name = "Garage", payment = false },
	["23"] = { name = "Garage", payment = false },
	["24"] = { name = "Garage", payment = false },
	["25"] = { name = "Garage", payment = false },
	["26"] = { name = "Garage", payment = false },

	-- Paramedic
	["41"] = { name = "Paramedic", payment = false, perm = "Paramedic" },
	["42"] = { name = "heliParamedic", payment = false, perm = "Paramedic" },

	["43"] = { name = "Paramedic", payment = false, perm = "Paramedic" },
	["44"] = { name = "heliParamedic", payment = false, perm = "Paramedic" },

	["45"] = { name = "Paramedic", payment = false, perm = "Paramedic" },

	-- Police
	--["61"] = { name = "Police", payment = false, perm = "Police" },
	["62"] = { name = "heliPolice", payment = false, perm = "Police" },

	["63"] = { name = "Police", payment = false, perm = "Police" },
	["64"] = { name = "heliPolice", payment = false, perm = "Police" },

	["65"] = { name = "Police", payment = false, perm = "Police" },
	["66"] = { name = "heliPolice", payment = false, perm = "Police" },

	["67"] = { name = "Police", payment = false, perm = "Police" },
	["68"] = { name = "busPolice", payment = false, perm = "Police" },

	--["69"] = { name = "Police", payment = false, perm = "Police" }, -- COMANF
	
	["176"] = { name = "GaragemDIP", payment = false, perm = "Police" },

	--["70"] = { name = "Police", payment = false, perm = "Police" },
	--["71"] = { name = "heliPolice", payment = false, perm = "Police" },
	--["72"] = { name = "heliPolice", payment = false, perm = "Police" },

	["91"] = { name = "Ballas", payment = false },
	["92"] = { name = "Families", payment = false },
	["93"] = { name = "Vagos", payment = false },
	["94"] = { name = "Aztecas", payment = false },
	["95"] = { name = "Bloods", payment = false },
	["96"] = { name = "Triads", payment = false },
	["97"] = { name = "Razors", payment = false },

	-- Boats
	["121"] = { name = "Boats", payment = false },
	["122"] = { name = "Boats", payment = false },
	["123"] = { name = "Boats", payment = false },
	["124"] = { name = "Boats", payment = false },
	["125"] = { name = "Boats", payment = false },
	["126"] = { name = "Boats", payment = false },

	-- Works
	["141"] = { name = "Lumberman", payment = false },
	["142"] = { name = "Driver", payment = false },
	["143"] = { name = "Garbageman", payment = false },
	["144"] = { name = "Transporter", payment = false },
	["145"] = { name = "Taxi", payment = false },
	["146"] = { name = "TowDriver", payment = false },
	["147"] = { name = "Garbageman", payment = false },
	["148"] = { name = "Garbageman", payment = false },
	["149"] = { name = "Taxi", payment = false },
	["150"] = { name = "Trucker", payment = false },
	["151"] = { name = "GarageBike", payment = false },

	-- Free
	["152"] = { name = "Mechanic", payment = false, perm = "Mechanic" },
	["153"] = { name = "Bennys", payment = false, perm = "Bennys" },

	["154"] = { name = "GarageBarbe", payment = false },
	["155"] = { name = "Garage", payment = false },
	["156"] = { name = "Garage", payment = false },
	["157"] = { name = "Garage", payment = false },
	["158"] = { name = "Garage", payment = false },
	["159"] = { name = "Garage", payment = false },
	["160"] = { name = "Garage", payment = false },
	["161"] = { name = "Garage", payment = false },
	["162"] = { name = "Garage", payment = false },
	["163"] = { name = "Garage", payment = false },
	["164"] = { name = "Garage", payment = false },
	["165"] = { name = "Garage", payment = false },
	["166"] = { name = "Garage", payment = false },
	["167"] = { name = "Garage", payment = false },
	["168"] = { name = "Garage", payment = false },
	["169"] = { name = "Garage", payment = false },
	["170"] = { name = "Garage", payment = false },
	["171"] = { name = "Garage", payment = false },
	["172"] = { name = "Garage", payment = false },
	["173"] = { name = "Garage", payment = false },
	["174"] = { name = "Garage", payment = false },
	["175"] = { name = "Garage", payment = false },
	["177"] = { name = "Garage", payment = false },
	["178"] = { name = "Garage", payment = false },
	["179"] = { name = "Garage", payment = false },
	["180"] = { name = "GarageDP", payment = false, perm = "masterPolice" },
	["181"] = { name = "GaragemDPC", payment = false, perm = "Police" },
	["182"] = { name = "Cupula", payment = false, perm = "Cupula" },
	["184"] = { name = "Garage", payment = false },
	["183"] = { name = "Garage", payment = false, perm = "Cupula" },
	["185"] = { name = "Garage", payment = false },
	["187"] = { name = "Garage", payment = false },
	["186"] = { name = "Comanf", payment = false, perm = "Police" },
	["188"] = { name = "BLX", payment = false },
	["189"] = { name = "HotGirls", payment = false },
	["190"] = { name = "Garage", payment = false },
	["191"] = { name = "Garage", payment = false },
	["192"] = { name = "Garage", payment = false },
	["193"] = { name = "Garage", payment = false },
	["194"] = { name = "CasaLolo", payment = false, perm = "CasaLolo" }, -- NÃO RETIRAR PERM
	["195"] = { name = "Police", payment = false, perm = "Police" }, -- POLICE
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNALREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("signalRemove")
AddEventHandler("signalRemove",function(vehPlate)
	vehSignal[vehPlate] = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEREVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateReveryone")
AddEventHandler("plateReveryone",function(vehPlate)
	if GlobalState["vehPlates"][vehPlate] then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = nil
		GlobalState["vehPlates"] = vehPlates
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateEveryone")
AddEventHandler("plateEveryone",function(vehPlate)
	local vehPlates = GlobalState["vehPlates"]
	vehPlates[vehPlate] = true
	GlobalState["vehPlates"] = vehPlates
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("platePlayers")
AddEventHandler("platePlayers",function(vehPlate,user_id)
	local userPlate = vRP.userPlate(vehPlate)
	if not userPlate then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = user_id
		GlobalState["vehPlates"] = vehPlates
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateRobberys")
AddEventHandler("plateRobberys",function(vehPlate,vehName)
	if vehPlate ~= nil and vehName ~= nil then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			if GlobalState["vehPlates"][vehPlate] ~= user_id then
				local vehPlates = GlobalState["vehPlates"]
				vehPlates[vehPlate] = user_id
				GlobalState["vehPlates"] = vehPlates
			end

			vRP.generateItem(user_id,"vehkey-"..vehPlate,1,true,false)

			if math.random(100) >= 50 then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)

				local policeResult = vRP.numPermission("Police")
				for k,v in pairs(policeResult) do
					async(function()
						TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local workGarages = {
	
	["Paramedic"] = {
		"sprintersamu"
	},
	["heliParamedic"] = {
		"maverick2"
	},
	["Cupula"] = {
		"b412n"
	},
	["Comanf"] = {
		"barracks",
		"wrsgle63",
		"nc7",
		"amarokcomanf"
	},
	["Police"] = {
		"WRa45",
		"WR19ranger",
		"WRcrv",
		"WRm5",
		"WRr1200",
		"mercedesgt632",
		--"WRsubaru",
		"ducati1200",
		"WRtiger900"
	},
	["GaragemDIP"] = {
		"WRxc90",
		"WRgle",
		"WRcrv",
		"WRbmwx6",
		"WRbmwx7",
		"WRyukon"
	},
	["GaragemDPC"] = {
		"nkamarok",
		"wrsurus",
		"bcat",
		"WRclassxv2"                    
	},
	["heliPolice"] = {
		"polmav",
		"B412"
	},
	["busPolice"] = {
		"pbus",
		"riot"
	},
	["Driver"] = {
		"bus"
	},
	["Boats"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark",
		"speeder",
		"squalo",
		"suntrap",
		"toro",
		"tropic"
	},
	["Transporter"] = {
		"stockade"
	},
	["Lumberman"] = {
		"ratloader"
	},
	["TowDriver"] = {
		"flatbed",
		"towtruck",
		"towtruck2"
	},
	["Garbageman"] = {
		"trash"
	},
	["Taxi"] = {
		"taxi"
	},
	["Bennys"] = {
		"flatbed",
		"Fcb500mecK",
		"Ff450mecK"
	},
	["Mechanic"] = {
		"flatbed",
		"Fcb500mecK",
		"Ff450mecK"
	},
	["Trucker"] = {
		"hauler",
		"hauler2",
		"packer",
		"phantom"
	},
	["GarageBike"] = {
		"bmx",
		"cruiser",
		"fixter",
		"scorcher",
		"tribike",
		"tribike2",
		"tribike3"
	},
	["GarageBarbe"] = {
		"taxi"
	},
	["GarageDP"] = {
		"fordmustanggt2",
		"bcat",
		"nkamarok",
		"wrsurus",
		"audir82"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Vehicles(Garage)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and not exports["hud"]:Wanted(user_id) then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"vermelho","Multas pendentes encontradas.",3000)
			return false
		end

		local garageName = garageLocates[Garage]["name"]
		if string.sub(garageName,0,5) == "Propertys" then
			local consult = vRP.query("propertys/userPermissions",{ name = garageName, user_id = user_id })
			if consult[1] == nil then
				return false
			else
				local ownerConsult = vRP.query("propertys/userOwnermissions",{ name = garageName })
				if ownerConsult[1] then
					if ownerConsult[1]["tax"] <= os.time() then
						TriggerClientEvent("Notify",source,"amarelo","Taxa da propriedade atrasada.",10000)
						return false
					end
				end
			end
		end

		if garageLocates[Garage]["perm"] then
			if not vRP.hasGroup(user_id,garageLocates[Garage]["perm"]) then
				return false
			end
		end

		local Vehicle = {}
		if workGarages[garageName] then
			for k,v in pairs(workGarages[garageName]) do
				table.insert(Vehicle,{ ["model"] = v, ["name"] = vehicleName(v) })
			end
		else
			local vehicle = vRP.query("vehicles/getVehicles",{ user_id = user_id })
			for k,v in ipairs(vehicle) do
				if v["work"] == "false" then
					table.insert(Vehicle,{ ["model"] = vehicle[k]["vehicle"], ["name"] = vehicleName(vehicle[k]["vehicle"]) })
				end
			end
		end

		return Vehicle
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Impound()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myVehicle = {}
		local vehicle = vRP.query("vehicles/getVehicles",{ user_id = user_id })

		for k,v in ipairs(vehicle) do
			if v["arrest"] >= os.time() then
				table.insert(myVehicle,{ ["model"] = vehicle[k]["vehicle"], ["name"] = vehicleName(vehicle[k]["vehicle"]) })
			end
		end

		return myVehicle
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Impound")
AddEventHandler("garages:Impound",function(vehName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehPrice = vehiclePrice(vehName)
		TriggerClientEvent("dynamic:closeSystem",source)

		if vRP.request(source,"A liberação do veículo tem o custo de <b>$"..parseFormat(vehPrice * 0.25).."</b> dólares, deseja prosseguir com a liberação do mesmo?","Sim","Não") then
			if vRP.paymentFull(user_id,vehPrice * 0.25) then
				vRP.execute("vehicles/paymentArrest",{ user_id = user_id, vehicle = vehName })
				TriggerClientEvent("Notify",source,"verde","Veículo liberado.",5000)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Spawn")
AddEventHandler("garages:Spawn",function(Table)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local splitName = splitString(Table,"-")
		local garageName = splitName[2]
		local vehName = splitName[1]

		local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehName })
		if vehicle[1] == nil then
			vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = vehName, plate = vRP.generatePlate(), work = "true" })
			TriggerClientEvent("Notify",source,"verde","Veículo adicionado em sua lista de veículos.",5000)
		else
			local vehPlates = GlobalState["vehPlates"]
			local vehPlate = vehicle[1]["plate"]

			if vehSpawn[vehPlate] then
				if vehSignal[vehPlate] == nil then
					if searchTimers[user_id] == nil then
						searchTimers[user_id] = os.time()
					end

					if os.time() >= parseInt(searchTimers[user_id]) then
						searchTimers[user_id] = os.time() + 60

						local vehNet = vehSpawn[vehPlate][3]
						local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
						if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
							vCLIENT.searchBlip(source,GetEntityCoords(idNetwork))
							TriggerClientEvent("Notify",source,"amarelo","Rastreador do veículo foi ativado por <b>30 segundos</b>, lembrando que se o mesmo estiver em movimento a localização pode ser imprecisa.",10000)
						else
							if vehSpawn[vehPlate] then
								vehSpawn[vehPlate] = nil
							end

							if vehPlates[vehPlate] then
								vehPlates[vehPlate] = nil
								GlobalState["vehPlates"] = vehPlates
							end

							TriggerClientEvent("Notify",source,"verde","A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.",5000)
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","Rastreador só pode ser ativado a cada <b>60 segundos</b>.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Rastreador está desativado.",5000)
				end
			else
				if vehicle[1]["tax"] <= os.time() then
					TriggerClientEvent("Notify",source,"amarelo","Taxa do veículo atrasada, efetue o pagamento<br>através do sistema da concessionária.",5000)
				elseif vehicle[1]["arrest"] >= os.time() then
					TriggerClientEvent("Notify",source,"amarelo","Veículo apreendido, dirija-se até o <b>Impound</b> e efetue o pagamento da liberação do mesmo.",5000)
				else

					local Coords = vCLIENT.spawnPosition(source,garageName)
					if Coords then
						local vehMods = nil
						local custom = vRP.query("entitydata/getData",{ dkey = "custom:"..user_id..":"..vehName })
						if parseInt(#custom) > 0 then
							vehMods = custom[1]["dvalue"]
						end

						if garageLocates[garageName]["payment"] then
							if vRP.userPremium(user_id) then
								TriggerClientEvent("dynamic:closeSystem",source)
								local netExist,netVeh,mHash = cRP.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

								if netExist then
									vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
									TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
									vehSpawn[vehPlate] = { user_id,vehName,netVeh }

									vehPlates[vehPlate] = user_id
									GlobalState["vehPlates"] = vehPlates
									
									TriggerClientEvent("Notify",source,"azul",completeTimers(vehicle[1]["tax"] - os.time()),1000)
								end
							else
								local vehPrice = vehiclePrice(vehName)
								if vRP.request(source,"Retirar o veículo por <b>$"..parseFormat(vehPrice * 0.05).."</b> dólares?") then
									if vRP.getBank(user_id) >= parseInt(vehPrice * 0.05) then
										TriggerClientEvent("dynamic:closeSystem",source)
										local netExist,netVeh,mHash = cRP.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

										if netExist then
											vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
											TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
											vehSpawn[vehPlate] = { user_id,vehName,netVeh }

											vehPlates[vehPlate] = user_id
											GlobalState["vehPlates"] = vehPlates
											
											TriggerClientEvent("Notify",source,"azul",completeTimers(vehicle[1]["tax"] - os.time()),1000)
										end
									else
										TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
									end
								end
							end
						else
							TriggerClientEvent("dynamic:closeSystem",source)
							local netExist,netVeh,mHash = cRP.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

							if netExist then
								vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
								TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
								vehSpawn[vehPlate] = { user_id,vehName,netVeh }

								vehPlates[vehPlate] = user_id
								GlobalState["vehPlates"] = vehPlates
								
								TriggerClientEvent("Notify",source,"azul",completeTimers(vehicle[1]["tax"] - os.time()),1000)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasGroup(user_id,"Moderator") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)
			local vehPlate = "VEH"..math.random(10000,99999)
			local netExist,netVeh,mHash,myVeh = cRP.serverVehicle(args[1],coords["x"],coords["y"],coords["z"],heading,vehPlate,2000,nil,1000)

			if not netExist then
				return
			end

			vCLIENT.createVehicle(-1,mHash,netVeh,1000,nil,false,false)
			vehSpawn[vehPlate] = { user_id,vehName,netVeh }
			TriggerEvent("engine:tryFuel",vehPlate,100)
			SetPedIntoVehicle(ped,myVeh,-1)

			local vehPlates = GlobalState["vehPlates"]
			vehPlates[vehPlate] = user_id
			GlobalState["vehPlates"] = vehPlates
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasGroup(user_id,"Moderator") then
			TriggerClientEvent("garages:Delete",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:VEHICLEKEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:vehicleKey")
AddEventHandler("garages:vehicleKey",function(entity)
	local source = source
	local vehPlate = entity[1]
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["vehPlates"][vehPlate] == user_id then
			vRP.generateItem(user_id,"vehkey-"..vehPlate,1,true,false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:lockVehicle")
AddEventHandler("garages:lockVehicle",function(vehNet,vehPlate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["vehPlates"][vehPlate] == user_id then
			TriggerEvent("garages:keyVehicle",source,vehNet)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:KEYVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:keyVehicle")
AddEventHandler("garages:keyVehicle",function(source,vehNet)
	local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
	local doorStatus = GetVehicleDoorLockStatus(idNetwork)

	if parseInt(doorStatus) <= 1 then
		TriggerClientEvent("Notify",source,"locked","Veículo trancado.",5000)
		TriggerClientEvent("sounds:source",source,"locked",0.4)
		SetVehicleDoorsLocked(idNetwork,2)
	else
		TriggerClientEvent("Notify",source,"unlocked","Veículo destrancado.",5000)
		TriggerClientEvent("sounds:source",source,"unlocked",0.4)
		SetVehicleDoorsLocked(idNetwork,1)
	end

	if not vRPC.inVehicle(source) then
		vRPC.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
		Wait(400)
		vRPC.stopAnim(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tryDelete(vehNet,vehEngine,vehBody,vehFuel,vehDoors,vehWindows,vehTyres,vehPlate)
	if vehSpawn[vehPlate] then
		local user_id = vehSpawn[vehPlate][1]
		local vehName = vehSpawn[vehPlate][2]

		if parseInt(vehEngine) <= 100 then
			vehEngine = 100
		end

		if parseInt(vehBody) <= 100 then
			vehBody = 100
		end

		if parseInt(vehFuel) >= 100 then
			vehFuel = 100
		end

		if parseInt(vehFuel) <= 0 then
			vehFuel = 0
		end

		local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehName })
		if vehicle[1] ~= nil then
			vRP.execute("vehicles/updateVehicles",{ user_id = user_id, vehicle = vehName, nitro = GlobalState["Nitro"][vehPlate] or 0, engine = parseInt(vehEngine), body = parseInt(vehBody), fuel = parseInt(vehFuel), doors = json.encode(vehDoors), windows = json.encode(vehWindows), tyres = json.encode(vehTyres) })
		end
	end

	TriggerEvent("garages:deleteVehicle",vehNet,vehPlate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLEADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicleAdmin")
AddEventHandler("garages:deleteVehicleAdmin",function(entity)
	TriggerEvent("garages:deleteVehicle",entity[1],entity[2])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicle")
AddEventHandler("garages:deleteVehicle",function(vehNet,vehPlate)
	if GlobalState["vehPlates"][vehPlate] then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = nil
		GlobalState["vehPlates"] = vehPlates
	end

	if GlobalState["Nitro"][vehPlate] then
		local Nitro = GlobalState["Nitro"]
		Nitro[vehPlate] = nil
		GlobalState["Nitro"] = Nitro
	end

	if vehSignal[vehPlate] then
		vehSignal[vehPlate] = nil
	end

	if vehSpawn[vehPlate] then
		vehSpawn[vehPlate] = nil
	end

	local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
		if GetVehicleNumberPlateText(idNetwork) == vehPlate then
			DeleteEntity(idNetwork)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATEGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:updateGarages")
AddEventHandler("garages:updateGarages",function(homeName,homeInfos)
	garageLocates[homeName] = { ["name"] = homeName, ["payment"] = false }

	-- CONFIG
	local configFile = LoadResourceFile("logs","garageConfig.json")
	local configTable = json.decode(configFile)
	configTable[homeName] = { ["name"] = homeName, ["payment"] = false }
	SaveResourceFile("logs","garageConfig.json",json.encode(configTable),-1)

	-- LOCATES
	local locatesFile = LoadResourceFile("logs","garageLocates.json")
	local locatesTable = json.decode(locatesFile)
	locatesTable[homeName] = homeInfos
	SaveResourceFile("logs","garageLocates.json",json.encode(locatesTable),-1)

	TriggerClientEvent("garages:updateLocs",-1,homeName,homeInfos)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:REMOVEGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:removeGarages")
AddEventHandler("garages:removeGarages",function(homeName)
	if garageLocates[homeName] then
		garageLocates[homeName] = nil

		local configFile = LoadResourceFile("logs","garageConfig.json")
		local configTable = json.decode(configFile)
		if configTable[homeName] then
			configTable[homeName] = nil
			SaveResourceFile("logs","garageConfig.json",json.encode(configTable),-1)
		end

		local locatesFile = LoadResourceFile("logs","garageLocates.json")
		local locatesTable = json.decode(locatesFile)
		if locatesTable[homeName] then
			locatesTable[homeName] = nil
			SaveResourceFile("logs","garageLocates.json",json.encode(locatesTable),-1)
		end

		TriggerClientEvent("garages:updateRemove",-1,homeName)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:TAX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Tax")
AddEventHandler("garages:Tax",function(vehModel)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehModel })
		if vehicle[1] then
			if vehicle[1]["tax"] <= os.time() then
				local vehiclePrice = parseInt(vehiclePrice(vehModel) * 0.10)

				if vRP.paymentFull(user_id,vehiclePrice) then
					vRP.execute("vehicles/updateVehiclesTax",{ user_id = user_id, vehicle = vehModel })
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			else
				TriggerClientEvent("Notify",source,"azul",completeTimers(vehicle[1]["tax"] - os.time()),1000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:SELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Sell")
AddEventHandler("garages:Sell",function(vehModel)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("dynamic:closeSystem",source)

		if actived[user_id] == nil then
			actived[user_id] = true

			if vRP.getFines(user_id) > 0 then
				TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
				actived[user_id] = nil
				return false
			end

			local vehType = vehicleType(vehModel)
			if vehType == "work" then
				TriggerClientEvent("Notify",source,"amarelo","Veículos de serviço não podem ser vendidos.",3000)
				actived[user_id] = nil
				return false
			end

			local vehPrices = vehiclePrice(vehModel) * 0.5
			local sellText = "Vender o veículo <b>"..vehicleName(vehModel).."</b> por <b>$"..parseFormat(vehPrices).."</b>?"

			if vehType == "rental" then
				sellText = "Remover o veículo de sua lista de possuídos?"
			end

			if vRP.request(source,sellText) then
				local vehicles = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehModel })
				if vehicles[1] then
					vRP.remSrvdata("custom:"..user_id..":"..vehModel)
					vRP.remSrvdata("vehChest:"..user_id..":"..vehModel)
					vRP.remSrvdata("vehGloves:"..user_id..":"..vehModel)
					vRP.execute("vehicles/removeVehicles",{ user_id = user_id, vehicle = vehModel })

					if vehType ~= "rental" then
						vRP.addBank(user_id,vehPrices,"Private")
						TriggerClientEvent("itensNotify",source,{ "recebeu","dollars",parseFormat(vehPrices),"Dólares" })
					end
				end
			end

			actived[user_id] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Transfer")
AddEventHandler("garages:Transfer",function(vehModel)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("dynamic:closeSystem",source)

		local myVehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehModel })
		if myVehicle[1] then
			local passport = vKEYBOARD.keySingle(source,"Passaporte:")
            if not passport then
                return
            end

			local nuser_id = parseInt(passport[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				if vRP.request(source,"Transferir o veículo <b>"..vehicleName(vehModel).."</b> para <b>"..identity["name"].." "..identity["name2"].."</b>?") then
					local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = parseInt(nuser_id), vehicle = vehModel })
					if vehicle[1] then
						TriggerClientEvent("Notify",source,"amarelo","<b>"..identity["name"].." "..identity["name2"].."</b> já possui este modelo de veículo.",5000)
					else
						vRP.execute("vehicles/moveVehicles",{ user_id = user_id, nuser_id = parseInt(nuser_id), vehicle = vehModel })

						local custom = vRP.query("entitydata/getData",{ dkey = "custom:"..user_id..":"..vehModel })
						if parseInt(#custom) > 0 then
							vRP.execute("entitydata/setData",{ dkey = "custom:"..nuser_id..":"..vehModel, value = custom[1]["dvalue"] })
							vRP.execute("entitydata/removeData",{ dkey = "custom:"..user_id..":"..vehModel })
						end

						local vehChest = vRP.getSrvdata("vehChest:"..user_id..":"..vehModel)
						if vehChest ~= nil then
							vRP.setSrvdata("vehChest:"..nuser_id..":"..vehModel,vehChest)
							vRP.remSrvdata("vehChest:"..user_id..":"..vehModel)
						end

						local vehGloves = vRP.getSrvdata("vehGloves:"..user_id..":"..vehModel)
						if vehGloves ~= nil then
							vRP.setSrvdata("vehGloves:"..nuser_id..":"..vehModel,vehGloves)
							vRP.remSrvdata("vehGloves:"..user_id..":"..vehModel)
						end

						TriggerClientEvent("Notify",source,"verde","Transferência concluída.",5000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCFUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local configFile = LoadResourceFile("logs","garageConfig.json")
	local configTable = json.decode(configFile)

	for k,v in pairs(configTable) do
		garageLocates[k] = v
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	local locatesFile = LoadResourceFile("logs","garageLocates.json")
	local locatesTable = json.decode(locatesFile)

	TriggerClientEvent("garages:allLocs",source,locatesTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if actived[user_id] then
		actived[user_id] = nil
	end

	if searchTimers[user_id] then
		searchTimers[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHSIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("vehSignal",function(vehPlate)
	return vehSignal[vehPlate]
end)