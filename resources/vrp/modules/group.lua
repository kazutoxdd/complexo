-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local permList = {}
local selfReturn = {}
permList["Taxi"] = {}
permList["Police"] = {}
permList["Emergency"] = {}
permList["Foods"] = {}
permList["Runners"] = {}
permList["Bennys"] = {}
permList["Paramedic"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local permissions = {
	["Admin"] = {
		["Admin"] = true,
	},
	["Moderator"] = {
		["Admin"] = true,
		["Moderator"] = true
	},
	["masterPolice"] = {
		["masterPolice"] = true
	},
	["Police"] = {
		["Police"] = true,
		["State"] = true,
		["Ranger"] = true,
		["Sheriff"] = true,
		["Corrections"] = true
	},
	["Ranger"] = {
		["Ranger"] = true
	},
	["State"] = {
		["State"] = true
	},
	["Corrections"] = {
		["Corrections"] = true
	},
	["Police"] = {
		["Police"] = true,
		["masterPolice"] = true,
	},
	["Sheriff"] = {
		["Sheriff"] = true
	},
	["masterParamedic"] = {
		["masterParamedic"] = true
	},
	["Paramedic"] = {
		["Paramedic"] = true,
		["masterParamedic"] = true
	},
	["Emergency"] = {
		["Police"] = true,
		["State"] = true,
		["masterPolice"] = true,
		["Ranger"] = true,
		["Sheriff"] = true,
		["Paramedic"] = true,
		["Corrections"] = true,
		["Bennys"] = true
	},
	["Cupula"] = {
		["Cupula"] = true
	},
	["Mechanic"] = { 
		["Mechanic"] = true
	},
	["LiderBennys"] = { -- Bennys = Nitro
	    ["LiderBennys"] = true                       
    },
	["Bennys"] = { -- Bennys = Nitro               
	    ["Bennys"] = true,
		["LiderBennys"] = true  
    },
	["LiderBallas"] = { --  Cocaine
	    ["LiderBallas"] = true
    },
	["Ballas"] = { --  Cocaine
	    ["Ballas"] = true,
		["LiderBallas"] = true
	},
	["LiderFavelaDK"] = { -- Baseado
	    ["LiderFavelaDK"] = true
    },
	["FavelaDK"] = { -- Baseado
		["FavelaDK"] = true,
		["LiderFavelaDK"] = true
	},
	["LiderPedreira"] = { -- Lean
		["LiderPedreira"] = true
	},
	["Pedreira"] = { -- Lean
	    ["Pedreira"] = true,
		["LiderPedreira"] = true
    },
	["LiderPlayBoy"] = { -- Arma
	    ["LiderPlayBoy"] = true
    },
    ["PlayBoy"] = { -- Arma
	    ["PlayBoy"] = true,
	    ["LiderPlayBoy"] = true
    },
	["LiderVagos"] = { -- Cocaína
	    ["LiderVagos"] = true
    },
	["Vagos"] = { -- Cocaína
		["Vagos"] = true,
		["LiderVagos"] = true
	},
	["LiderFavelaNH"] = { -- Direita da Grota = Attachs e Ticket de Corrida
	    ["LiderFavelaNH"] = true
    },
	["FavelaNH"] = { -- Direita da Grota = Attachs e Ticket de Corrida
	    ["FavelaNH"] = true,
		["LiderFavelaNH"] = true
	},
	["LiderVanilla"] = { -- Lavagem - Lockpick 
	    ["LiderVanilla"] = true
    },
	["Vanilla"] = { -- Lavagem - Lockpick 
		["Vanilla"] = true,
		["LiderVanilla"] = true
	},
	["LiderBahamas"] = { -- Lavagem - Lockpick 
	    ["LiderBahamas"] = true
    },
	["Bahamas"] = { -- Lavagem - Lockpick 
		["Bahamas"] = true,
		["LiderBahamas"] = true
	},
	["LiderGrota"] = { -- Meta
	    ["LiderGrota"] = true
    },
	["Grota"] = { -- Meta
		["Grota"] = true,
		["LiderGrota"] = true
	},
	["LiderFavelaSV"] = { --  Colete e Algema
	    ["LiderFavelaSV"] = true
    },
	["FavelaSV"] = { --  Colete e Algema
		["FavelaSV"] = true,
		["LiderFavelaSV"] = true
	},
	["LiderFazenda"] = { -- Municao
	    ["LiderFazenda"] = true
    },
	["Fazenda"] = { -- Municao
		["Fazenda"] = true,
		["LiderFazenda"] = true
	},
	["LiderArcade"] = { -- Tequila = Attachs e Ticket de Corrida
	    ["LiderArcade"] = true 
    },
	["Arcade"] = { -- Tequila = Attachs e Ticket de Corrida
		["Arcade"] = true,
		["LiderArcade"] = true 
	},
	["LiderVinhedo"] = { -- Municao
	    ["LiderVinhedo"] = true
    },
	["Vinhedo"] = { -- Municao
		["Vinhedo"] = true,
		["LiderVinhedo"] = true
	},
	["LiderMotoclub"] = { -- Armas
		["LiderMotoclub"] = true
	},
	["Motoclub"] = { -- Armas
		["Motoclub"] = true,
		["LiderMotoclub"] = true
	},
	["LiderBDT"] = { -- Heroine
	    ["LiderBDT"] = true
   },
    ["BDT"] = { --  Heroine
	    ["BDT"] = true,
		["LiderBDT"] = true
    },
	["LiderCosanostra"] = { -- Armas
	    ["LiderCosanostra"] = true
	    
    },
	["Cosanostra"] = { -- Armas
		["Cosanostra"] = true,
		["LiderCosanostra"] = true	
	},
	["LiderBloods"] = { -- Lsd
	    ["LiderBloods"] = true
    },
    ["Bloods"] = { -- Lsd
	    ["Bloods"] = true,
	    ["LiderBloods"] = true
    },
	["LiderCrips"] = { -- Xanax
	    ["LiderCrips"] = true
    },
    ["Crips"] = { -- Xanax
	    ["Crips"] = true,
	    ["LiderCrips"] = true
    },
	["LiderFerroVelho"] = { -- Munição
	    ["LiderFerroVelho"] = true
    },
    ["FerroVelho"] = { -- Munição
	    ["FerroVelho"] = true,
	    ["LiderFerroVelho"] = true
     },
	["LiderChacara"] = { -- charcara = sabonete e carões de roubo
	    ["LiderChacara"] = true
    },
	["Chacara"] = { -- charcara = sabonete e carões de roubo
		["Chacara"] = true,
		["LiderChacara"] = true
	},
	["LiderSalieris"] = { -- Salieris = Attachs e Colete
	    ["LiderSalieris"] = true
    },
	["Salieris"] = { -- Salieris = Attachs e Colete
		["Salieris"] = true,
		["LiderSalieris"] = true
	},
	["LiderDuros"] = { -- arma
	    ["LiderDuros"] = true
    },
	["Duros"] = { -- arma
		["Duros"] = true,
		["LiderDuros"] = true
	},
	["LiderYakuza"] = { -- arma
	    ["LiderYakuza"] = true
    },
	["Yakuza"] = { -- arma
		["Yakuza"] = true,
		["LiderYakuza"] = true
		--["Weapons"] = true
	},
	["Runners"] = {
		["Runners"] = true
	},
	["BurgerShot"] = {
		["BurgerShot"] = true
	},
	["Primatas"] = {
		["Primatas"] = true,
		["LiderPrimatas"] = true
	},
	["LiderPrimatas"] = {
		["LiderPrimatas"] = true
	},
	["Tunners"] = { 
		["Tunners"] = true
	},
	["LiderTunners"] = { 
		["LiderTunners"] = true
	},
	["Verify"] = { -- Verificado do Insta
		["Verify"] = true
	},
	["PizzaThis"] = {
		["PizzaThis"] = true
	},
	["BLX"] = {
		["LiderBLX"] = true,
		["BLX"] = true
	},
	["LiderBLX"] = {
		["LiderBLX"] = true
	},
	["SS"] = {
		["SS"] = true
	},
	["Helper"] = {
		["Helper"] = true
	},
	["HotGirls"] = {
		["HotGirls"] = true,
		["LiderHotGirls"] = true
	},
	["LiderHotGirls"] = {
		["LiderHotGirls"] = true
	},
	["Foods"] = {
		["Desserts"] = true,
		["BurgerShot"] = true,
		["PizzaThis"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DataGroups
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DataGroups(permission)
    -- Consulta o banco de dados ou a fonte de dados para obter as informações dos grupos com base na permissão
    
    -- Exemplo de implementação usando um banco de dados:
    
    local groupsData = {}  -- Tabela para armazenar os dados dos grupos
    
    -- Consulta o banco de dados para obter as informações dos grupos com base na permissão
    -- Substitua "databaseQuery" com a lógica real para consultar o banco de dados
    local queryResult = databaseQuery("SELECT user_id FROM groups WHERE permission = ?", permission)
    
    if queryResult then
        -- Itera sobre o resultado da consulta e preenche a tabela de dados dos grupos
        for i, row in ipairs(queryResult) do
            local userId = row.user_id
            groupsData[userId] = true  -- Define o usuário como tendo a permissão no grupo
        end
    end
    
    -- Retorna a tabela de dados dos grupos
    return groupsData
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasPermission(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] then
			if dataTable["perm"][perm] then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setPermission(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)
	local userTables = vRP.userData(user_id,"Datatable")

	if dataTable then
		if dataTable["perm"] == nil then
			dataTable["perm"] = {}
		end

		if dataTable["perm"][perm] == nil then
			dataTable["perm"][perm] = true
		end
		-- ADICIONADO O userTables AQUI LUCKY
		if userTables["inventory"] then
			if userTables["perm"] == nil then
				userTables["perm"] = {}
			end

			if userTables["perm"][perm] == nil then
				userTables["perm"][perm] = true
			end
		end
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
	else

		if userTables["inventory"] then
			if userTables["perm"] == nil then
				userTables["perm"] = {}
			end

			if userTables["perm"][perm] == nil then
				userTables["perm"][perm] = true
			end

			vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.cleanPermission(user_id)
	local dataTable = vRP.getDatatable(user_id)
	local userTables = vRP.userData(user_id,"Datatable")

	if dataTable then
		if dataTable["perm"] then
			dataTable["perm"] = {}
		end
		-- ADICIONADO O userTables AQUI LUCKY
		if userTables["inventory"] then
			if userTables["perm"] then
				userTables["perm"] = {}
			end
		end
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
	else

		if userTables["inventory"] then
			if userTables["perm"] then
				userTables["perm"] = {}
				vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remPermission(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)
	local userTables = vRP.userData(user_id,"Datatable")

	if dataTable then
		if dataTable["perm"] then
			if dataTable["perm"][perm] then
				dataTable["perm"][perm] = nil
			end
		end
		-- ADICIONADO O userTables AQUI LUCKY
		if userTables["inventory"] then
			if userTables["perm"] then
				if userTables["perm"][perm] then
					userTables["perm"][perm] = nil
				end
			end
		end
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
	else
		if userTables["inventory"] then
			if userTables["perm"] then
				if userTables["perm"][perm] then
					userTables["perm"][perm] = nil
					vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updatePermission(user_id,perm,new)
	local new = tostring(new)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] == nil then
			dataTable["perm"] = {}
		end

		if dataTable["perm"][perm] then
			dataTable["perm"][perm] = nil
		end

		dataTable["perm"][new] = true
	else
		local userTables = vRP.userData(user_id,"Datatable")
		if userTables["inventory"] then
			if userTables["perm"] == nil then
				userTables["perm"] = {}
			end

			if userTables["perm"][perm] then
				userTables["perm"][perm] = nil
			end

			userTables["perm"][new] = true

			vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasGroup(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	selfReturn[user_id] = false

	if dataTable then
		if dataTable["perm"] then
			for k,v in pairs(dataTable["perm"]) do
			  if permissions then
					if permissions[perm][k] then
						selfReturn[user_id] = true
						break
					end
			 	end
			end
		end
	end

	return selfReturn[user_id]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.numPermission(perm)
	local tableList = {}

	for k,v in pairs(permList[perm]) do
		table.insert(tableList,v)
	end

	return tableList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.insertPermission(source,user_id,perm)
	if permList[perm] then
		permList[perm][user_id] = source
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removePermission(user_id,perm)
	if permList[perm][user_id] then
		permList[perm][user_id] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERSBYPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUsersByPermission(perm)
    local tableList = {}

    for user_id,source in pairs(vRP.userList()) do
        if vRP.hasPermission(user_id, perm) then
            table.insert(tableList, user_id)
        end
    end

    return tableList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id,source)
	if permList["Police"][user_id] then
		permList["Police"][user_id] = nil
	end

	if permList["Paramedic"][user_id] then
		permList["Paramedic"][user_id] = nil
	end

	if permList["Taxi"][user_id] then
		permList["Taxi"][user_id] = nil
	end

	if permList["Bennys"][user_id] then
		permList["Bennys"][user_id] = nil
	end

	if permList["Runners"][user_id] then
		permList["Runners"][user_id] = nil
	end

	if selfReturn[user_id] then
		selfReturn[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	if vRP.hasPermission(user_id,"Corrections") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Corrections",true)
		TriggerClientEvent("service:Label",source,"Corrections","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"Ranger") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Ranger",true)
		TriggerClientEvent("service:Label",source,"Ranger","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"State") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"State",true)
		TriggerClientEvent("service:Label",source,"State","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"Police") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Police",true)
		TriggerClientEvent("service:Label",source,"Police","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"Sheriff") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Sheriff",true)
		TriggerClientEvent("service:Label",source,"Sheriff-1","Sair de Serviço",5000)
		TriggerClientEvent("service:Label",source,"Sheriff-2","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"Paramedic") then
		permList["Paramedic"][user_id] = source
		TriggerClientEvent("vRP:ParamedicService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Paramedic",true)
		TriggerClientEvent("service:Label",source,"Paramedic-1","Sair de Serviço",5000)
		TriggerClientEvent("service:Label",source,"Paramedic-2","Sair de Serviço",5000)
		TriggerClientEvent("service:Label",source,"Paramedic-3","Sair de Serviço",5000)
	end

	if vRP.hasGroup(user_id,"Bennys") then
		permList["Bennys"][user_id] = source
		TriggerClientEvent("service:Label",source,"Bennys","Sair de Serviço",5000)
	end

	if vRP.hasGroup(user_id,"Runners") then
		permList["Runners"][user_id] = source
	end

	if vRP.hasGroup(user_id,"Ballas") then
		TriggerClientEvent("player:Relationship",source,"Ballas")
	end

	if vRP.hasGroup(user_id,"Families") then
		TriggerClientEvent("player:Relationship",source,"Families")
	end

	if vRP.hasGroup(user_id,"Vagos") then
		TriggerClientEvent("player:Relationship",source,"Vagos")
	end

	if vRP.hasGroup(user_id,"Motoclub") then
		TriggerClientEvent("player:Relationship",source,"Motoclub")
	end
end)

function vRP.getUsersByPermission(perm)
    local tableList = {}

    for user_id,source in pairs(vRP.userList()) do
        if vRP.hasPermission(user_id, perm) then
            table.insert(tableList, user_id)
        end
    end

    return tableList
end