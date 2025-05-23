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
Tunnel.bindInterface("police",cRP)
vCLIENT = Tunnel.getInterface("police")
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local prisonMarkers = {}
-------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 5, texture = 7 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 0, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 0, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 71, texture = 6 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 16, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 5, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRISONCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:prisonClothes")
AddEventHandler("police:prisonClothes",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasGroup(user_id,"Police") then
			local mHash = vRP.modelPlayer(entity[1])
			if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",entity[1],preset[mHash])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANREC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleanrec",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id,"setState") then
			local nuser_id = parseInt(args[1])
			if nuser_id > 0 then
				vRP.execute("prison/cleanRecords",{ nuser_id = nuser_id })
				TriggerClientEvent("Notify",source,"verde","Limpeza efetuada.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRISONID
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPrisionId(id)
	local records = vRP.query("prison/getRecordsById",{ id = id })
	local identity = vRP.userIdentity(records[1]["nuser_id"])
	return { true, identity["name"] .. " " .. identity["name2"], records[1] }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWARRANTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getWarrants()
	return { true, vRP.query("warrants/getAll") }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWARRANTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWarrantId(id)
	local query = vRP.query("warrants/getWarrant", { id = id })[1]
	return { query or false, query["identity"], query }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWARRANTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setWarrant(passport, reason)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(passport)
	local nidentity = vRP.userIdentity(user_id)

	vRP.execute("warrants/setWarrant", { user_id = passport, identity = identity["name"] .. identity["name2"], status = "Procurado", nidentity = nidentity["name"] .. nidentity["name2"], timeStamp = os.date('%d/%m/%Y', os.time()), reason = reason })
	TriggerClientEvent("police:Update",source,"reloadProcurados")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWARRANTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deleteWarrant(id)
	local source = source

	vRP.execute("warrants/deleteWarrant", { id = id })

	TriggerClientEvent("police:Update",source,"reloadProcurados")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initPrison(nuser_id,services,fines,text,association,material,url,cops)
	print(association,material,url,cops)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if actived[user_id] == nil then
			actived[user_id] = true

			local identity = vRP.userIdentity(user_id)
			if identity then
				local otherPlayer = vRP.userSource(nuser_id)
				if otherPlayer then
					vCLIENT.syncPrison(otherPlayer,true,false)
					TriggerClientEvent("radio:outServers",otherPlayer)
				end

				local residual = 0
				if material == "Sim" then
					residual = 1 
				end

				vRP.execute("prison/insertPrison",{ police = identity["name"].." "..identity["name2"], nuser_id = parseInt(nuser_id), services = services, fines = fines, text = text, date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M"), association = association, cops = cops, url = url, residual = residual })
				vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"verde","Prisão efetuada.",5000)
				TriggerClientEvent("police:Update",source,"reloadPrison")
				vRP.initPrison(nuser_id,services)

				if fines > 0 then
					vRP.addFines(nuser_id,fines)
				end

				TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Serviços:** "..parseFormat(services).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,13541152)
			end

			actived[user_id] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchUser(nuser_id)
	print(source)
	local source = source
	local user_id = vRP.getUserId(source)
	print(user_id)

	if user_id then
		local nuser_id = parseInt(nuser_id)
		local identity = vRP.userIdentity(nuser_id)
		if identity then
			local port = vRP.getPortByPassport(nuser_id) or {}
			print(json.encode(port))
			local fines = vRP.getFines(nuser_id)
			local records = vRP.query("prison/getRecords",{ nuser_id = parseInt(nuser_id) })
			print("ok")
			return { true, identity["name"].." "..identity["name2"],identity["phone"],fines,records,nil,port,identity["locate"] }
		end
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchPort()
	local result = {}
	for k,v in pairs(vRP.getPorts()) do
		local data = v
		local nidentity = vRP.userIdentity(data["nuser_id"])
		local name = nidentity["name"] .. " " .. nidentity["name2"]
		data["nidentity"] = name

		result[#result + 1] = data
	end

	return { true, result }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPORTBYID
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getPortById(id)
	local data = vRP.getPortById(id)
	if data then
		local nidentity = vRP.userIdentity(data["nuser_id"])
		local name = nidentity["name"] .. " " .. nidentity["name2"]
		data["nidentity"] = name
	end

	return  { data or false, data }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.givePort(passport, serial, status, exam)
	local source = source
	
	vRP.createPort(passport, serial, status, exam, vRP.getUserId(source))

	TriggerClientEvent("police:Update",source,"reloadPortes")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EDITPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.editPort(portId, passport, serial, status, exam)
	local source = source

	vRP.upgradePort(portId, passport, serial, status, exam)

	TriggerClientEvent("police:Update",source,"reloadPortes")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deletePort(portId)
	local source = source
	vRP.deletePort(portId)

	TriggerClientEvent("police:Update",source,"reloadPortes")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initFine(nuser_id,fines,text)
  	local source = source
  	local user_id = vRP.getUserId(source)
  
 	if fines <= 0 then -- Verificar se o valor da multa é maior que zero
    	TriggerClientEvent("Notify",source,"vermelho","Valor da multa inválido.",5000)
   		return
  	end
  
	if user_id and fines > 0 then
    	if actived[user_id] == nil then
    		actived[user_id] = true

    		TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,2316674)
    		TriggerClientEvent("Notify",source,"verde","Multa aplicada.", 5000)
    		TriggerClientEvent("police:Update",source,"reloadFine")
    		vRP.addFines(nuser_id,fines)

    		actived[user_id] = nil
		end
  	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updatePort(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local portStatus = "Desativado"
		local nuser_id = parseInt(nuser_id)
		local identity = vRP.userIdentity(nuser_id)

		if parseInt(identity["port"]) == 0 then
			portStatus = "Ativado"
			vRP.upgradePort(nuser_id,1)
		else
			vRP.upgradePort(nuser_id,0)
		end

		TriggerClientEvent("police:Update",source,"reloadSearch",parseInt(nuser_id))
		TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Porte:** "..portStatus.."\n**Horário:** "..os.date("%H:%M:%S"),6303352)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k,v in pairs(prisonMarkers) do
			if prisonMarkers[k][1] > 0 then
				prisonMarkers[k][1] = prisonMarkers[k][1] - 1

				if prisonMarkers[k][1] <= 0 then
					if vRP.userSource(prisonMarkers[k][2]) then
						TriggerEvent("blipsystem:serviceExit",k)
					end

					prisonMarkers[k] = nil
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local prisonItens = {
	{ ["item"] = "cigarette", ["min"] = 4, ["max"] = 8, ["perc"] = 100 },
	{ ["item"] = "cannedsoup", ["min"] = 1, ["max"] = 1, ["perc"] = 20 },
	{ ["item"] = "canofbeans", ["min"] = 1, ["max"] = 1, ["perc"] = 20 },
	{ ["item"] = "key", ["min"] = 1, ["max"] = 1, ["perc"] = 10 },
	{ ["item"] = "cotton", ["min"] = 1, ["max"] = 1, ["perc"] = 50 },
	{ ["item"] = "saline", ["min"] = 1, ["max"] = 1, ["perc"] = 50 },
	{ ["item"] = "sulfuric", ["min"] = 1, ["max"] = 1, ["perc"] = 50 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.reducePrison()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local randPercent = math.random(1000)
		local randItens = math.random(#prisonItens)
		local amountItens = math.random(prisonItens[randItens]["min"],prisonItens[randItens]["max"])

		if parseInt(randPercent) <= parseInt(prisonItens[randItens]["perc"]) then
			vRP.generateItem(user_id,prisonItens[randItens]["item"],amountItens,true)
		end

		vRP.updatePrison(user_id)

		local identity = vRP.userIdentity(user_id)
		if parseInt(identity["prison"]) <= 0 then
			vCLIENT.syncPrison(source,false,true)
		else
			vCLIENT.asyncServices(source)
			TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(identity["prison"]).." serviços</b>.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKKEY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkKey()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policeResult = vRP.numPermission("Police")
		if parseInt(#policeResult) <= 5 then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
			return false
		end

		local consultItem = vRP.getInventoryItemAmount(user_id,"key")
		if consultItem[1] > 0 then
			if not vRP.checkBroken(consultItem[2]) then
				if vRP.tryGetInventoryItem(user_id,consultItem[2],1,true) then
					vCLIENT.syncPrison(source,false,false)
					prisonMarkers[source] = { 600,user_id }
					vRP.execute("characters/fixPrison",{ user_id = user_id })

					for k,v in pairs(policeResult) do
						async(function()
							TriggerClientEvent("Notify",v,"amarelo","Recebemos a informação de um fugitivo da penitenciária.",5000)
						end)
					end

					TriggerEvent("blipsystem:serviceEnter",source,"Prisioneiro",48)

					return true
				end
			end
		end

		return false
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	local identity = vRP.userIdentity(user_id)
	if parseInt(identity["prison"]) > 0 then
		TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(identity["prison"]).." serviços</b>.",5000)
		vCLIENT.syncPrison(source,true,true)
	end
end)