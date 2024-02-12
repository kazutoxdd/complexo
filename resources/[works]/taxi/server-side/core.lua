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
Tunnel.bindInterface("taxi",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- mamaki kill
-----------------------------------------------------------------------------------------------------------------------------------------
local blockedPlayers = {} -- Lista de jogadores bloqueados
local discordWebhook = "SEU_WEBHOOK_AQUI"
local timeBetweenExploits = 5 -- Tempo mínimo entre os usos do exploit em segundos

local playerExploitTimes = {} -- Armazena os tempos em que o exploit foi usado pelo jogador

function checkExploitUsage(source)
	local currentTime = os.time()
	if playerExploitTimes[source] then
		local lastExploitTime = playerExploitTimes[source]
		if currentTime - lastExploitTime < timeBetweenExploits then
			-- O jogador usou o exploit repetidamente, banir e chutar o jogador
			local user_id = vRP.getUserId(source)
			if user_id then
				vRP.execute("banneds/insertBanned", { steam = identity["steam"], time = time })
				vRP.execute("accounts/setwl", { steam = identity["steam"], whitelist = 0 })
				vRP.kick(source, "Você foi banido por usar exploits.")

				-- Enviar log para o Discord via webhook
				local playerName = GetPlayerName(source)
				local steamID = identity["steam"]
				local discordMessage = string.format("**Jogador Banido por Explorar Exploits**\nID do Jogador: %s\nNome do Jogador: %s\nSteam ID: %s", user_id, playerName, steamID)
				PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({ content = discordMessage }), { ['Content-Type'] = 'application/json' })

				return true
			end
		end
	end

	-- Atualiza o tempo do último uso do exploit pelo jogador
	playerExploitTimes[source] = currentTime
	return false
end

function cRP.mamakillService()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		-- Verifica se o jogador está bloqueado por explorar exploits
		if blockedPlayers[source] then
			checkExploitUsage(source)
		else
			-- O jogador não está bloqueado, continuar com a execução normal
			vRP.upgradeStress(user_id, 2)
			local value = math.random(340, 340)
			vRP.generateItem(user_id, "dollars", value, true)

			if vRP.userPremium(user_id) then
				vRP.generateItem(user_id, "dollars", value * 0.10, true)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initService(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if status then
			vRP.insertPermission(source,user_id,"Taxi")
		else
			vRP.removePermission(user_id,"Taxi")
		end
	end

	return true
end