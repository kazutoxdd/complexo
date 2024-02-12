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
Tunnel.bindInterface("works",cRP)
vCLIENT = Tunnel.getInterface("works")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local works = {
	["Transportador"] = {
		["coords"] = { -4.7,-654.71,33.45 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = true,
		["deliveryVehicle"] = 1747439474,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 10,
		["collectDuration"] = 10000,
		["collectText"] = "VASCULHAR",
		["deliveryText"] = "ENTREGAR",
		["collectAnim"] = { false,"amb@prop_human_atm@male@idle_a","idle_a",true },
		["prandom"] = {
			["min"] = 2,
			["max"] = 3
		},
		["collectCoords"] = {
			{ 256.92,214.69,101.67,164.41 },
			{ 259.38,213.75,101.67,158.75 },
			{ 260.68,217.56,101.67,325.99 },
			{ 258.56,218.44,101.67,340.16 },
			{ 263.73,216.32,101.67,340.16 },
			{ 265.72,215.83,101.67,340.16 },
			{ 266.37,214.59,101.67,249.45 },
			{ 265.79,212.75,101.67,238.12 },
			{ 264.41,211.93,101.67,155.91 },
			{ 262.25,212.71,101.67,155.91 }
		},
		["deliveryItem"] = "pouch",
		["deliveryName"] = "Malotes",
		["deliveryConsume"] = {
			["min"] = 2,
			["max"] = 3
		},
		["deliveryCoords"] = {
			{ 285.47,143.37,104.17,158.75 },
			{ 527.36,-160.7,57.09,272.13 },
			{ 1153.64,-326.75,69.2,99.22 },
			{ 1167.01,-456.07,66.79,345.83 },
			{ 1138.25,-468.9,66.73,73.71 },
			{ 1077.71,-776.5,58.23,187.09 },
			{ 299.35,-581.2,43.25,257.96 },
			{ 296.46,-894.25,29.23,249.45 },
			{ 295.76,-896.14,29.22,252.29 },
			{ 147.58,-1035.79,29.34,161.58 },
			{ 145.93,-1035.19,29.34,161.58 },
			{ 289.1,-1256.87,29.44,277.8 },
			{ 288.82,-1282.36,29.64,272.13 },
			{ 126.85,-1296.59,29.27,25.52 },
			{ 127.84,-1296.03,29.27,28.35 },
			{ 33.16,-1348.25,29.49,175.75 },
			{ 24.48,-945.95,29.35,343.0 },
			{ 5.24,-919.83,29.55,252.29 },
			{ 112.58,-819.4,31.34,158.75 },
			{ 114.44,-776.41,31.41,343.0 },
			{ 111.25,-775.25,31.44,345.83 },
			{ -27.99,-724.54,44.23,345.83 },
			{ -30.19,-723.71,44.23,343.0 },
			{ -203.8,-861.37,30.26,31.19 },
			{ -301.7,-830.01,32.42,351.5 },
			{ -303.24,-829.74,32.42,354.34 },
			{ -258.87,-723.38,33.48,70.87 },
			{ -256.2,-715.99,33.53,73.71 },
			{ -254.41,-692.49,33.6,161.58 },
			{ -537.85,-854.49,29.28,178.59 },
			{ -660.73,-854.07,24.48,187.09 },
			{ -710.01,-818.9,23.72,0.0 },
			{ -712.89,-818.92,23.72,0.0 },
			{ -717.7,-915.65,19.21,85.04 },
			{ -821.63,-1081.88,11.12,31.19 },
			{ -1315.71,-834.75,16.95,314.65 },
			{ -1314.75,-836.03,16.95,314.65 },
			{ -1305.41,-706.37,25.33,127.56 },
			{ -1570.14,-546.72,34.95,218.27 },
			{ -1571.06,-547.39,34.95,215.44 },
			{ -1415.94,-212.04,46.51,235.28 },
			{ -1430.18,-211.06,46.51,113.39 },
			{ -1409.76,-100.47,52.39,104.89 },
			{ -1410.32,-98.75,52.42,110.56 },
			{ -1282.52,-210.92,42.44,306.15 },
			{ -1286.28,-213.44,42.44,119.06 },
			{ -1285.54,-224.32,42.44,306.15 },
			{ -1289.31,-226.78,42.44,124.73 },
			{ -1205.02,-326.3,37.83,113.39 },
			{ -1205.78,-324.8,37.86,116.23 },
			{ -866.69,-187.74,37.84,121.89 },
			{ -867.63,-186.07,37.84,119.06 },
			{ -846.31,-341.26,38.67,113.39 },
			{ -846.81,-340.2,38.67,116.23 },
			{ -721.06,-415.58,34.98,269.3 },
			{ -556.18,-205.18,38.22,119.06 },
			{ -57.66,-92.65,57.78,294.81 },
			{ 89.73,2.46,68.29,343.0 },
			{ -165.17,232.77,94.91,90.71 },
			{ -165.16,234.8,94.91,85.04 },
			{ 158.6,234.23,106.63,343.0 },
			{ 228.18,338.38,105.56,158.75 },
			{ 380.76,323.4,103.56,158.75 },
			{ 357.01,173.54,103.07,340.16 }
		},
		["deliveryPayment"] = {
			["min"] = 28,
			["max"] = 34,
			["item"] = "dollars"
		}
	},
	["Lenhador"] = {
		["coords"] = { -841.14,5401.24,34.61 },
		["upgradeStress"] = 2,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "CORTAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1.50,
		["collectShowDistance"] = 150,
		["collectDuration"] = 3000,
		["collectAnim"] = { false,"melee@hatchet@streamed_core","plyr_front_takedown_b",true },
		["prandom"] = {
			["min"] = 2,
			["max"] = 3
		},
		["collectCoords"] = {
			{ -793.99,5448.74,33.58,189.93 },
			{ -737.48,5470.38,39.24,343.0 },
			{ -704.55,5486.71,44.85,5.67 },
			{ -713.02,5403.51,52.07,158.75 },
			{ -735.23,5407.52,49.23,104.89 },
			{ -749.12,5397.86,45.66,85.04 },
			{ -762.32,5378.25,50.87,260.79 },
			{ -717.19,5329.72,70.74,249.45 },
			{ -767.06,5317.17,75.34,102.05 },
			{ -744.07,5304.64,75.05,243.78 },
			{ -690.79,5305.32,70.1,266.46 },
			{ -667.85,5498.54,47.53,204.1 },
			{ -639.38,5505.0,51.27,223.94 },
			{ -619.12,5498.06,51.31,121.89 },
			{ -588.29,5494.67,54.39,70.87 },
			{ -581.2,5471.6,59.41,204.1 },
			{ -586.56,5446.63,60.07,340.16 },
			{ -642.14,5460.4,53.31,73.71 },
			{ -638.36,5441.42,52.47,209.77 },
			{ -668.25,5497.19,47.77,306.15 }
		},
		["deliveryItem"] = {
			"woodlog"
		}
	},
	["Minerador"] = {
		["coords"] = { -594.88,2090.5,131.56 },
		["upgradeStress"] = 3,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "MINERAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 500,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"amb@world_human_const_drill@male@drill@base","base",true },
		["collectCoords"] = {
			{ -562.62,2012.06,127.42,116.23 },
			{ -554.37,1999.26,127.22,127.56 },
			{ -549.19,1995.9,126.98,306.15 },
			{ -546.81,1985.04,127.11,119.06 },
			{ -542.18,1976.34,127.05,266.46 },
			{ -539.57,1956.66,126.49,269.3 },
			{ -536.92,1945.9,125.92,294.81 },
			{ -536.42,1926.98,124.69,82.21 },
			{ -535.06,1915.09,123.69,266.46 },
			{ -540.77,1908.12,123.34,45.36 },
			{ -543.24,1900.49,123.0,226.78 },
			{ -554.29,1890.78,123.04,201.26 },
			{ -562.41,1889.12,123.12,31.19 },
			{ -533.73,1982.38,126.95,354.34 },
			{ -528.1,1978.79,126.88,158.75 },
			{ -524.59,1980.91,126.78,348.67 },
			{ -517.25,1977.76,126.56,161.58 },
			{ -517.09,1980.3,126.47,348.67 },
			{ -509.35,1980.33,126.2,357.17 },
			{ -501.53,1978.53,125.97,178.59 },
			{ -497.72,1982.0,125.53,19.85 },
			{ -487.29,1983.74,124.62,192.76 },
			{ -483.21,1988.1,124.15,17.01 },
			{ -476.66,1989.99,123.86,17.01 },
			{ -469.02,1990.9,123.63,238.12 },
			{ -468.46,1993.84,123.56,14.18 },
			{ -463.8,1997.6,123.54,45.36 },
			{ -457.12,2000.54,123.56,221.11 },
			{ -448.82,2009.5,123.54,232.45 },
			{ -450.59,2022.0,123.53,96.38 },
			{ -449.4,2029.82,123.42,274.97 },
			{ -453.85,2036.63,123.02,93.55 },
			{ -454.08,2044.42,122.73,317.49 },
			{ -460.29,2050.34,122.43,113.39 },
			{ -452.46,2053.79,122.3,192.76 },
			{ -428.18,2064.69,120.71,0.0 },
			{ -463.76,2056.7,121.66,104.89 }
		}
	},
	["Mergulhador"] = {
		["coords"] = { 1520.56,3780.08,34.46 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "VASCULHAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 500,
		["collectDuration"] = 12500,
		["collectAnim"] = { false,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",true },
		["prandom"] = {
			["min"] = 2,
			["max"] = 3
		},
		["collectCoords"] = {
			{ 1018.69,4095.91,12.7 },
			{ 963.91,4036.36,3.35 },
			{ 960.66,3973.73,1.11 },
			{ 1015.39,3959.19,-3.0 },
			{ 1064.1,3974.58,-12.5 },
			{ 1045.07,4008.94,-12.45 },
			{ 995.48,4048.54,4.52 },
			{ 961.85,4034.99,2.95 },
			{ 907.1,3958.09,-4.3 },
			{ 935.89,3911.83,-9.69 },
			{ 927.22,3836.77,3.79 },
			{ 935.42,3791.86,16.85 },
			{ 975.34,3800.73,16.55 },
			{ 1030.63,3823.97,9.64 },
			{ 1068.02,3863.78,-7.23 },
			{ 1138.51,3991.73,-4.28 },
			{ 1093.69,4050.16,0.86 },
			{ 1045.61,4141.31,21.85 }
		},
		["deliveryItem"] = {
			"key",
			"octopus",
			"shrimp",
			"carp",
			"codfish",
			"catfish",
			"goldenfish",
			"horsefish",
			"tilapia",
			"pacu",
			"pirarucu",
			"tambaqui",
			"bait",
			"emptybottle",
			"plastic",
			"glass",
			"rubber",
			"aluminum",
			"copper",
			"silvercoin",
			"goldcoin"
		}
	},
	["Agricultor"] = {
		["coords"] = { 405.5,6526.26,27.68 },
		["upgradeStress"] = 2,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 100,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"amb@prop_human_movie_bulb@base","base",true },
		["prandom"] = {
			["min"] = 3,
			["max"] = 4
		},
		["collectCoords"] = {
			{ 378.66,6517.64,28.34,96.38 },
			{ 378.45,6505.79,27.94,85.04 },
			{ 370.21,6505.4,28.41,5.67 },
			{ 363.33,6505.43,28.54,19.85 },
			{ 347.6,6517.11,28.78,14.18 },
			{ 339.2,6517.65,28.93,138.9 },
			{ 339.88,6505.88,28.68,164.41 },
			{ 330.88,6505.26,28.56,0.0 },
			{ 322.0,6517.02,29.12,17.01 },
			{ 329.17,6531.33,28.64,221.11 },
			{ 338.54,6531.86,28.54,170.08 },
			{ 345.51,6531.26,28.73,283.47 },
			{ 353.39,6530.79,28.39,291.97 },
			{ 361.13,6531.22,28.34,308.98 },
			{ 368.96,6531.71,28.39,291.97 },
			{ 363.14,6517.96,28.29,116.23 },
			{ 369.49,6517.59,28.37,300.48 }
		},
		["deliveryItem"] = {
			"tomato",
			"banana",
			"passion",
			"grape",
			"tange",
			"orange",
			"apple",
			"strawberry",
			"coffee2"
		}
	},
	["Motorista"] = {
		["coords"] = { 453.05,-607.72,28.59 },
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		["collectVehicle"] = -713569950,
		["usingVehicle"] = true,
		["collectRandom"] = false,
		["collectText"] = "PEGAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["prandom"] = {
			["min"] = 80,
			["max"] = 80
		},
		["collectCoords"] = {
			{ 418.92,-571.03,28.68 },
			{ 923.78,186.7,75.81 },
			{ 1644.11,1166.89,84.26 },
			{ 2104.23,2630.44,51.76 },
			{ 2402.38,2918.04,49.31 },
			{ 1786.57,3356.21,40.51 },
			{ 1620.82,3813.85,34.94 },
			{ 1911.6,3793.09,32.31 },
			{ 2493.37,4088.69,38.04 },
			{ 2068.51,4693.82,41.19 },
			{ 1676.39,4822.41,42.02 },
			{ 2250.19,4986.36,42.23 },
			{ 1667.97,6397.56,30.12 },
			{ 235.51,6574.7,31.57 },
			{ -85.11,6584.3,29.47 },
			{ -137.53,6440.85,31.42 },
			{ -235.39,6304.34,31.39 },
			{ -422.67,6031.56,31.34 },
			{ -756.66,5515.02,35.49 },
			{ -1538.42,4976.01,62.28 },
			{ -2246.9,4283.26,46.68 },
			{ -2731.13,2292.23,19.05 },
			{ -3233.06,1009.3,12.18 },
			{ -3002.44,416.76,14.97 },
			{ -1960.25,-504.23,11.82 },
			{ -1371.7,-982.24,8.43 },
			{ -1166.92,-1471.31,4.34 },
			{ -1052.56,-1511.78,5.09 },
			{ -900.75,-1206.71,4.94 },
			{ -628.94,-924.13,23.28 },
			{ -557.24,-845.49,27.61 },
			{ -1059.11,-2066.85,13.2 },
			{ -543.79,-2194.84,6.01 },
			{ -60.68,-1806.51,27.21 },
			{ 228.64,-1837.9,26.73 },
			{ 291.46,-2002.07,20.31 },
			{ 739.81,-2233.34,29.24 },
			{ 1045.03,-2384.93,30.28 },
			{ 1200.9,-685.64,60.6 },
			{ 954.37,-146.43,74.45 },
			{ 566.42,218.64,102.54 },
			{ -429.1,252.36,83.02 },
			{ -732.3,3.21,37.88 },
			{ -1244.38,-302.64,37.32 },
			{ -1403.93,-566.3,30.22 },
			{ -1202.05,-876.7,13.28 },
			{ -691.37,-961.63,19.79 },
			{ -387.71,-851.57,31.5 },
			{ 149.9,-1028.06,29.25 },
			{ 120.26,-1356.98,29.19 },
			{ 118.29,-785.88,31.3 },
			{ 98.34,-628.98,31.57 }
		},
		["deliveryItem"] = "dollars"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collectAmount = {}
local paymentAmount = {}
local deliveryAmount = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- prandom
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.prandom(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if works[serviceName]["collectRandom"] then
			local amountItem = 0
			local selectItem = ""

			if serviceName == "Minerador" then
				local randomItem = math.random(100)

				if randomItem <= 1 then
					amountItem = 1
					selectItem = "emerald"
				elseif randomItem >= 2 and randomItem <= 3 then
					selectItem = "diamond"
					amountItem = math.random(2)
				elseif randomItem >= 4 and randomItem <= 8 then
					selectItem = "ruby"
					amountItem = math.random(2)
				elseif randomItem >= 9 and randomItem <= 16 then
					selectItem = "sapphire"
					amountItem = math.random(3)
				elseif randomItem >= 17 and randomItem <= 27 then
					selectItem = "amethyst"
					amountItem = math.random(3)
				elseif randomItem >= 28 and randomItem <= 44 then
					selectItem = "amber"
					amountItem = math.random(3)
				elseif randomItem >= 45 and randomItem <= 60 then
					selectItem = "turquoise"
					amountItem = math.random(3)
				elseif randomItem >= 61 and randomItem <= 79 then
					selectItem = "aluminum"
					amountItem = math.random(2)
				elseif randomItem >= 80 then
					selectItem = "copper"
					amountItem = math.random(2)
				end
			else
				local randomItem = math.random(#works[serviceName]["deliveryItem"])
				selectItem = works[serviceName]["deliveryItem"][randomItem]
				amountItem = math.random(works[serviceName]["prandom"]["min"], works[serviceName]["prandom"]["max"])
			end

			if (vRP.inventoryWeight(user_id) + (itemWeight(selectItem) * parseInt(amountItem))) <= vRP.getWeight(user_id) then
				vRP.generateItem(user_id, selectItem, amountItem, true)

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id, works[serviceName]["upgradeStress"])
				end
				
				if serviceName == "Transportador" then
					vRP.insertReputation(user_id, "Transporter", math.random(5, 10))
				end

				return true
			else
				TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", 5000)
			end
		else
			local deliveryItem = works[serviceName]["deliveryItem"]
			collectAmount[user_id] = math.random(works[serviceName]["prandom"]["min"], works[serviceName]["prandom"]["max"])

			if (vRP.inventoryWeight(user_id) + (itemWeight(deliveryItem) * parseInt(collectAmount[user_id]))) <= vRP.getWeight(user_id) then
				vRP.generateItem(user_id, deliveryItem, collectAmount[user_id], true)

				if deliveryItem == "dollars" then
					if vRP.userPremium(user_id) then
						vRP.generateItem(user_id, deliveryItem, collectAmount[user_id] * 0.10, true)
					end
				end

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id, works[serviceName]["upgradeStress"])
				end

				collectAmount[user_id] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", 5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERYCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deliveryConsume(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local deliveryItem = works[serviceName]["deliveryPayment"]["item"]
		deliveryAmount[user_id] = math.random(works[serviceName]["deliveryConsume"]["min"],works[serviceName]["deliveryConsume"]["max"])
		paymentAmount[user_id] = math.random(works[serviceName]["deliveryPayment"]["min"],works[serviceName]["deliveryPayment"]["max"])

		if (vRP.inventoryWeight(user_id) + (itemWeight(deliveryItem) * parseInt(paymentAmount[user_id]))) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id,works[serviceName]["deliveryItem"],deliveryAmount[user_id]) then
				local paymentPrice = parseInt(paymentAmount[user_id] * deliveryAmount[user_id])

				vRP.generateItem(user_id,deliveryItem,paymentPrice,true)

				if deliveryItem == "dollars" then
					if vRP.userPremium(user_id) then
						vRP.generateItem(user_id,deliveryItem,paymentPrice * 0.10,true)
					end
				end

				deliveryAmount[user_id] = nil
				paymentAmount[user_id] = nil

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id,works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>"..parseFormat(deliveryAmount[user_id]).."x "..itemName(works[serviceName]["deliveryItem"]).."</b> para entregar.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
local blockedPlayers = {} -- Lista de jogadores bloqueados
local discordWebhook = ""

RegisterServerEvent("works:tunnel_req") -- Evento para receber o pedido do jogador
AddEventHandler("works:tunnel_req", function(request, args)
    local source = source

    if request == "prandom" then
        local serviceName = args[1]

        -- Verifica se o jogador está bloqueado
        if blockedPlayers[source] then
            -- O jogador está bloqueado, banir e chutar o jogador
            local user_id = vRP.getUserId(source)
            if user_id then
                vRP.execute("banneds/insertBanned", { steam = identity["steam"], time = time })
                vRP.execute("accounts/setwl", { steam = identity["steam"], whitelist = 0 })
                vRP.kick(source, "Você foi banido por usar exploits.")

                -- Enviar log para o Discord via webhook
                local identity = vRP.userIdentity(user_id)
                local playerName = GetPlayerName(source)
                local steamID = identity["steam"]
                local discordMessage = string.format("**Jogador Banido por Exploits**\nID do Jogador: %s\nNome do Jogador: %s\nSteam ID: %s", user_id, playerName, steamID)
                PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({ content = discordMessage }), { ['Content-Type'] = 'application/json' })
            end
        else
            -- O jogador não está bloqueado, continuar com a execução normal
            cRP.prandom(serviceName)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if works[serviceName]["perm"] == nil then
			return true
		end

		if vRP.hasGroup(user_id,works[serviceName]["perm"]) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	vCLIENT.updateWorks(source,works)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ensureworks
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ensureworks",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			vCLIENT.updateWorks(-1,works)
			vCLIENT.updateWorks(source,works)
			TriggerClientEvent("Notify",source,"amarelo","Ensure.",3000)
		end
	end
end)