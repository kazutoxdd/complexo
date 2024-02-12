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
Tunnel.bindInterface("dynamic",cRP)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Experience()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local Experiences = {
			["Desmanche"] = vRP.checkReputation(user_id,"Dismantle"),
			["Reboque"] = vRP.checkReputation(user_id,"Tows"),
			["Entregador"] = vRP.checkReputation(user_id,"Delivery"),
			["Transportador"] = vRP.checkReputation(user_id,"Transporter"),
			["Lenhador"] = vRP.checkReputation(user_id,"Lumberman")
		}

		return Experiences
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermissions(Permission)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,Permission) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:SETGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:setGroup")
AddEventHandler("dynamic:setGroup",function(Group)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("dynamic:closeSystem",source)

		local passport = vKEYBOARD.keySingle(source,"Passaporte:")
		if not passport then
			return
		end

		local nuser_id = parseInt(passport[1])
		local identity = vRP.userIdentity(nuser_id)
		if identity then
			if vRP.request(source,"Confirma adicionar <b>["..parseInt(passport[1]).."]</b> <b>"..identity["name"].." "..identity["name2"].."</b> ao seu grupo?") then
				if Group == "waitPolice" then
					if vRP.hasPermission(user_id,"Police") then
						vRP.setPermission(parseInt(passport[1]),"Police")
					elseif vRP.hasPermission(user_id,"State") then
						vRP.setPermission(parseInt(passport[1]),"State")
					elseif vRP.hasPermission(user_id,"Ranger") then
						vRP.setPermission(parseInt(passport[1]),"Ranger")
					elseif vRP.hasPermission(user_id,"Sheriff") then
						vRP.setPermission(parseInt(passport[1]),"Sheriff")
					elseif vRP.hasPermission(user_id,"Corrections") then
						vRP.setPermission(parseInt(passport[1]),"Corrections")
					end

					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..parseInt(passport[1]).."</b> adicionado ao seu grupo.",5000)
				elseif Group == "waitParamedic" then
					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..parseInt(passport[1]).."</b> adicionado ao seu grupo.",5000)
					vRP.setPermission(parseInt(passport[1]),"waitParamedic")
				end

				if Group == "waitUwu" then
					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..parseInt(passport[1]).."</b> adicionado ao seu grupo.",5000)
					vRP.setPermission(parseInt(passport[1]),"waitUwu")
				end

				TriggerEvent("discordLogs","SetGroup","**Passaporte:** "..parseFormat(user_id).."\n**Adicionou o set de Police/Paramedic/Café ao Passaporte:** "..parseFormat(nuser_id).."\n**Horário:** "..os.date("%H:%M:%S"),3042892)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:REMGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:remGroup")
AddEventHandler("dynamic:remGroup",function(Group)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("dynamic:closeSystem",source)

		local passport = vKEYBOARD.keySingle(source,"Passaporte:")
		if not passport then
			return
		end

		local nuser_id = parseInt(passport[1])
		local identity = vRP.userIdentity(nuser_id)
		if identity then
			if vRP.request(source,"Confirma remover <b>["..parseInt(passport[1]).."]</b> <b>"..identity["name"].." "..identity["name2"].."</b> do seu grupo?") then
				if Group == "waitPolice" then
					if vRP.hasPermission(user_id,"Lspd") then
						vRP.remPermission(parseInt(passport[1]),"Lspd")
					elseif vRP.hasPermission(user_id,"State") then
						vRP.remPermission(parseInt(passport[1]),"State")
					elseif vRP.hasPermission(user_id,"Ranger") then
						vRP.remPermission(parseInt(passport[1]),"Ranger")
					elseif vRP.hasPermission(user_id,"Sheriff") then
						vRP.remPermission(parseInt(passport[1]),"Sheriff")
					elseif vRP.hasPermission(user_id,"Corrections") then
						vRP.remPermission(parseInt(passport[1]),"Corrections")
					end

					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..parseInt(passport[1]).."</b> adicionado ao seu grupo.",5000)
				elseif Group == "waitParamedic" then
					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..parseInt(passport[1]).."</b> adicionado ao seu grupo.",5000)
					vRP.remPermission(parseInt(passport[1]),"waitParamedic")
				end

				TriggerEvent("discordLogs","SetGroup","**Passaporte:** "..parseFormat(user_id).."\n**Removeu o set de Police/Paramedic do Passaporte:** "..parseFormat(nuser_id).."\n**Horário:** "..os.date("%H:%M:%S"),3042892)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local animal = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalRegister(netId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		animal[user_id] = netId
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMACLEANER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalCleaner()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("tryDeletePed",animal[user_id])
		animal[user_id] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if animal[user_id] then
		TriggerEvent("tryDeletePed",animal[user_id])
		animal[user_id] = nil
	end
end)