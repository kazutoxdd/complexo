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
Tunnel.bindInterface("shops",cRP)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local shops = {
	["Weeds"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["silk"] = 3
		}
	},
	["ChipsV"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["chips"] = 10
		}
	},
	["ChipsC"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["chips"] = 10
		}
	},
	["Identity"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 200
		}
	},
	["Identity2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["fidentity"] = 10000
		}
	},
	--["Petz"] = {
		--["mode"] = "Buy",
		--["type"] = "Cash",
		--["list"] = {
		--	["rottweiler"] = 25000,
		--	["husky"] = 25000,
		--	["shepherd"] = 25000,
		--	["retriever"] = 25000,
		--	["poodle"] = 25000,
		--	["pug"] = 25000,
		--	["westy"] = 25000,
		--	["cat"] = 25000
	--	}
	--},
	["Coffee"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 125,
			["guarananatural"] = 150,
			["orangejuice"] = 125,
			["tangejuice"] = 100,
			["grapejuice"] = 175,
			["strawberryjuice"] = 160,
			["bananajuice"] = 135,
			["passionjuice"] = 78
		}
	},
	["Cassino"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 20,
			["guarananatural"] = 20,
			["orangejuice"] = 20,
			["tangejuice"] = 20,
			["grapejuice"] = 20,
			["strawberryjuice"] = 20,
			["bananajuice"] = 20,
			["passionjuice"] = 20
		}
	},
	["StoreM"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_WRENCH"] = 395,
			["toolbox"] = 600,
			["advtoolbox"] = 800,
			["tyres"] = 400,
			["notepad"] = 10,
			["cigarette"] = 5,
			--["emptybottle"] = 45,
			["rope"] = 250,
			["firecracker"] = 100,
			["emptybottle"] = 30,
			["lighter"] = 50,
			["postit"] = 20,
			["backpack"] = 950,
			["rose"] = 25,
			["teddy"] = 45,
			--["megaphone"] = 1750
		}
	},
	--["StoreV"] = {
		--["mode"] = "Sell",
		--["type"] = "Cash",
		--["list"] = {
		--	["WEAPON_WRENCH"] = 1725,
		--	["toolbox"] = 1625,
		--	["advtoolbox"] = 2525,
		--	["tyres"] = 1225,
		--	["notepad"] = 10,
		--	["cigarette"] = 10,
		--	["rope"] = 875,
		--	["firecracker"] = 100,
		--	["emptybottle"] = 30,
		--	["lighter"] = 175,
		--	["postit"] = 20,
		--	["rose"] = 25
	--	}
--	},
	["Digital"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cellphone"] = 575,
			["carregador"] = 200,
			["radio"] = 250,
			["binoculars"] = 275,
			["camera"] = 275,
			--["scanner"] = 650,
			["tablet"] = 100,
			["vape"] = 150
		}
	},
	["Departament"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["energetic"] = 30,
			["notepad"] = 10,
			["cigarette"] = 5,
			["lighter"] = 50,
			["emptybottle"] = 30,
			["bread"] = 10,
			["chocolate"] = 12,
			["hamburger"] = 20,
			["cola"] = 15, 
			["absolut"]=50,
			["chandon"]=55,
			["hennessy"]=60,
			["sandwich"] = 15,
			["soda"] = 15
		}
	},
	["UwuCoffee"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Uwucafe",
		["list"] = {
			["bread"] = 100,
			["fishfillet"] = 275,
			["chocolate"] = 350,
			["milkbottle"] = 575,
			["coffee2"] = 450,
			["mushroom"] = 475,
			["water"] = 100,
			["apple"] = 275,
			["sugar"] = 250
		}
	},
	["Lasttrain"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 25,
			["hamburger2"] = 50,
			["onionrings"] = 35,
			["chickenfries"] = 50,
			["pizzamozzarella"] = 45,
			["strawberryjuice"] = 40,
			["bananajuice"] = 25,
			["acerolajuice"] = 35,
			["passionjuice"] = 25,
			["grapejuice"] = 30,
			["tangejuice"] = 35,
			["orangejuice"] = 25,
			["calzone"] = 20,
			["hotdog"] = 25,
		}
	},
	["Clothes"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["teddy"] = 75,
			["WEAPON_BRICK"] = 25,
			["WEAPON_SHOES"] = 25,
			["rope"] = 875
		}
	},
	["Diagram"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["diagram"] = 40000
		}
	},
	["Mechanic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_WRENCH"] = 375,
			["toolbox"] = 550,
			["advtoolbox"] = 750,
			["notebook"] = 450,
			["tyres"] = 375,
			["notebook"] = 475,
			["WEAPON_CROWBAR"] = 355
		}
	},
	["mechanicBuy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Bennys",
		["list"] = {
			["WEAPON_WRENCH"] = 165,
			["toolbox"] = 100,
			["advtoolbox"] = 115,
			["notebook"] = 125,
			["tyres"] = 25,
			["nitro"] = 1100,
			["WEAPON_CROWBAR"] = 135
		}
	},
	-- ["Weapons"] = {
	-- 	["mode"] = "Sell",
	-- 	["type"] = "Cash",
	-- 	["list"] = {
	-- 		["pistolbody"] = 425,
	-- 		["smgbody"] = 525,
	-- 		["riflebody"] = 625
		--}
	--},
	["Lenhador"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["woodlog"] = 40
		}
	},
	["Oxy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["oxy"] = 35
		}
	},
	["Pharmacy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["analgesic"] = 125,
			["gauze"] = 175,
			["bandage"] = 225,
			["medkit"] = 575,
			["ritmoneury"] = 425,
			["adrenaline"] = 1000
		}
	},
	["Paramedic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["syringe"] = 50,
			["syringe01"] = 50,
			["syringe02"] = 50,
			["syringe03"] = 50,
			["syringe04"] = 50,
			["gauze"] = 750,
			["medkit"] = 275,
			--["sinkalmy"] = 325,
			["analgesic"] = 75,
			["ritmoneury"] = 225,
			["adrenaline"] = 500,
			["bandage"] = 125,
			["wheelchair"] = 70000,
			--["defibrillator"] = 325,
			["medicbag"] = 425
		}
	},
	["Ammunation"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["GADGET_PARACHUTE"] = 475,
			["WEAPON_HATCHET"] = 975,
			["WEAPON_BAT"] = 975,
			["WEAPON_BATTLEAXE"] = 975,
			["WEAPON_GOLFCLUB"] = 975,
			["WEAPON_HAMMER"] = 725,
			["WEAPON_MACHETE"] = 975,
			["WEAPON_KATANA"] = 975,
			["WEAPON_KARAMBIT"] = 975,
			["WEAPON_POOLCUE"] = 975,
			["WEAPON_STONE_HATCHET"] = 975,
			["WEAPON_KNUCKLE"] = 975,
			["WEAPON_FLASHLIGHT"] = 675
		}
	},
	["Premium"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["list"] = {
			["newchars"] = 30,
			["chip"] = 20,
			-- ["subscriber"] = 10,
			["backpack2"] = 10,
			["newgarage"] = 15,
			["premiumplate"] = 15,
			["instaverify"] = 10,
			["spotify"] = 60,
			["premium"] = 75,
			["namechange"] = 5
		}
	},
	["Fishing"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["octopus"] = 20,
			["shrimp"] = 20,
			["carp"] = 18,
			["horsefish"] = 18,
			["tilapia"] = 20,
			["codfish"] = 22,
			["catfish"] = 22,
			["goldenfish"] = 24,
			["pirarucu"] = 24,
			["pacu"] = 24,
			["tambaqui"] = 24
		}
	},
	["Fishing2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["bait"] = 4,
			["fishingrod"] = 725
		}
	},
	["Hunting2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["switchblade"] = 525,
			["WEAPON_MUSKET"] = 3250,
			["WEAPON_MUSKET_AMMO"] = 40
		}
	},
	["Hunting"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["meat"] = 20,
			["animalpelt"] = 25,
			["tomato"] = 8,
			["banana"] = 6,
			["passion"] = 6,
			["grape"] = 6,
			["tange"] = 6,
			["orange"] = 6,
			["apple"] = 6,
			["strawberry"] = 6,
			["coffee2"] = 6,
			["animalfat"] = 10,
			["leather"] = 25
		}
	},
	["Recycle"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["newspaper"] = 30,
			["glassbottle"] = 20,
			["metalcan"] = 25,
			["aluminum"] = 15,
			["binoculars"] = 135,
			["notepad"] = 5,
			["rubber"] = 10,
			["switchblade"] = 115,
			["cellphone"] = 185,
			["copper"] = 15,
			["rope"] = 235,
			["camera"] = 135,
			["firecracker"] = 50,
			["emptybottle"] = 15,
			["bait"] = 2,
			["lighter"] = 25,
			["goldcoin"] = 20,
			["silvercoin"] = 10,
			["plastic"] = 10,
			["tyres"] = 100,
			["rose"] = 15,
			["divingsuit"] = 485,
			["radio"] = 155,
			["teddy"] = 35,
			["vape"] = 75,
			["fishingrod"] = 65,
			["battery"] = 15,
			["elastic"] =  20,
			["glass"] = 10
		}
	},
	["Miners"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["emerald"] = 75,
			["diamond"] = 55,
			["ruby"] = 35,
			["sapphire"] = 30,
			["amethyst"] = 25,
			["amber"] = 20,
			["turquoise"] = 15
		}
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 20
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cola"] = 15,
			["soda"] = 15
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["donut"] = 15,
			["chocolate"] = 15
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 25
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 15
		}
	},
	["Chihuahua"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 15,
			["hamburger"] = 25,
			["coffee"] = 20,
			["cola"] = 15,
			["soda"] = 15
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 30
		}
	},
	["Police"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["list"] = {
			["vest"] = 500,
			["gsrkit"] = 35,
			["gdtkit"] = 35,
			["barrier"] = 20,
			["handcuff"] = 60,
			["divingsuit"] = 125,
			["WEAPON_SMG"] = 550,
			["WEAPON_PUMPSHOTGUN"] = 2250,
			["WEAPON_CARBINERIFLE"] = 1800,
			["WEAPON_SMOKEGRENADE"] = 75,
			["WEAPON_CARBINERIFLE_MK2"] = 1900,
			--["WEAPON_STUNGUN"] = 45,
			["WEAPON_COMBATPISTOL"] = 400,
			["WEAPON_HEAVYPISTOL"] = 450,
			["WEAPON_FLASHLIGHT"] = 25,
			["WEAPON_NIGHTSTICK"] = 425,
			["WEAPON_PISTOL_AMMO"] = 4,
			["WEAPON_SMG_AMMO"] = 5,
			["WEAPON_RIFLE_AMMO"] = 6,
			["WEAPON_SHOTGUN_AMMO"] = 15,
			["WEAPON_SMG_MK2"] = 1500,
			["attachsFlashlight"] = 1000,
            ["attachsCrosshair" ] = 1000,
            ["attachsSilencer" ] = 1000,
            ["attachsMagazine" ] = 1000,
            ["attachsGrip" ] = 1000,
            ["attachsMuzzleFat" ] = 1000,
            ["attachsBarrel"] = 1000,
            ["attachsMuzzleHeavy" ] = 1000
			
		}
	},
	["Criminal"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["keyboard"] = 45,
			["mouse"] = 45,
			["playstation"] = 50,
			["xbox"] = 50,
			["dish"] = 45,
			["pan"] = 70,
			["fan"] = 45,
			["blender"] = 45,
			["switch"] = 20,
			["cup"] = 70,
			["lampshade"] = 60
		}
	},
	["Criminal2"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["silverring"] = 45,
			["goldring"] = 70,
			["watch"] = 50,
			["bracelet"] = 50,
			["dildo"] = 45,
			["spray01"] = 45,
			["spray02"] = 45,
			["spray03"] = 45,
			["spray04"] = 45,
			["slipper"] = 40,
			["rimel"] = 45,
			["brush"] = 45,
			["soap"] = 40
		}
	},
	["Criminal3"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["eraser"] = 40,
			["legos"] = 45,
			["ominitrix"] = 45,
			["dices"] = 20,
			["domino"] = 35,
			["floppy"] = 30,
			["horseshoe"] = 45,
			["deck"] = 40
		}
	},
	["Criminal4"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["goldbar"] = 450,
			["lockpick"] = 40,
			["lockpick2"] = 40,
			["pliers"] = 40,
			["pager"] = 110,
			["card01"] = 275,
			["card02"] = 275,
			["card03"] = 300,
			["card04"] = 225,
			["card05"] = 315,
			["pendrive"] = 275
		}
	},
	["Criminal5"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["vest"] = 750,
			["attachsBarrel"] = 1000,
			["attachsMuzzleHeavy"] = 1000,
			["attachsMuzzleFat"] = 1000,
			["attachsGrip"] = 1000,
			["attachsCrosshair"] = 1000,
			["attachsSilencer"] = 3500,
			["attachsFlashlight"] = 1000,
			["attachsMagazine"] = 1200
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMES
-----------------------------------------------------------------------------------------------------------------------------------------
local nameMale = { "James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy","Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan","Justin","Terry","Gerald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell","Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio" }
local nameFemale = { "Mary","Patricia","Linda","Barbara","Elizabeth","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy","Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah","Kimberly","Deborah","Jessica","Shirley","Cynthia","Angela","Melissa","Brenda","Amy","Anna","Rebecca","Virginia","Kathleen","Pamela","Martha","Debra","Amanda","Stephanie","Carolyn","Christine","Marie","Janet","Catherine","Frances","Ann","Joyce","Diane","Alice","Julie","Heather","Teresa","Doris","Gloria","Evelyn","Jean","Cheryl","Mildred","Katherine","Joan","Ashley","Judith","Rose","Janice","Kelly","Nicole","Judy","Christina","Kathy","Theresa","Beverly","Denise","Tammy","Irene","Jane","Lori","Rachel","Marilyn","Andrea","Kathryn","Louise","Sara","Anne","Jacqueline","Wanda","Bonnie","Julia","Ruby","Lois","Tina","Phyllis","Norma","Paula","Diana","Annie","Lillian","Emily","Robin" }
local userName2 = { "Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		-- if vRP.getFines(user_id) > 0 then
			-- TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			-- return false
		-- end

		if exports["hud"]:Wanted(user_id,source) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasGroup(user_id,shops[shopType]["perm"]) then
				return false
			end
		end
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local shopSlots = 20
		local inventoryShop = {}
		for k,v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop,{ key = k, price = parseInt(v), name = itemName(k), index = itemIndex(k), peso = itemWeight(k), type = itemType(k), max = itemMaxAmount(k), desc = itemDescription(k), economy = itemEconomy(k) })
		end

		local inventoryUser = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["economy"] = itemEconomy(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			inventoryUser[k] = v
		end

		if parseInt(#inventoryShop) > 20 then
			shopSlots = parseInt(#inventoryShop)
		end

		return inventoryShop,inventoryUser,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),shopSlots
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getShopType(name)
    return shops[name]["mode"]
end
---------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionShops(shopType,shopItem,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shops[shopType] then
			if shopAmount == nil then shopAmount = 1 end
			if shopAmount <= 0 then shopAmount = 1 end

			local inventory = vRP.userInventory(user_id)
			if (inventory[tostring(slot)] and inventory[tostring(slot)]["item"] == shopItem) or inventory[tostring(slot)] == nil then
				if shops[shopType]["mode"] == "Buy" then
					if vRP.checkMaxItens(user_id,shopItem,shopAmount) then
						TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
						vCLIENT.updateShops(source,"requestShop")
						return
					end

					if (vRP.inventoryWeight(user_id) + (itemWeight(shopItem) * parseInt(shopAmount))) <= vRP.getWeight(user_id) then
						if shops[shopType]["type"] == "Cash" then
							if shops[shopType]["list"][shopItem] then
								if vRP.paymentFull(user_id,shops[shopType]["list"][shopItem] * shopAmount) then
									if shopItem == "identity" or string.sub(shopItem,1,5) == "badge" then
										vRP.generateItem(user_id,shopItem.."-"..user_id,parseInt(shopAmount),false,slot)
									elseif shopItem == "fidentity" then
										local identity = vRP.userIdentity(user_id)
										if identity then
											if identity["sex"] == "M" then
												vRP.execute("fidentity/newIdentity",{ name = nameMale[math.random(#nameMale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											else
												vRP.execute("fidentity/newIdentity",{ name = nameFemale[math.random(#nameFemale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											end

											local identity = vRP.userIdentity(user_id)
											local consult = vRP.query("fidentity/lastIdentity")
											if consult[1] then
												vRP.generateItem(user_id,shopItem.."-"..consult[1]["id"],parseInt(shopAmount),false,slot)
											end
										end
									else
										vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
									end

									if shopType == "Police" then
										TriggerEvent("discordLogs","Police","**Passaport:** "..parseFormat(user_id).."\n**Comprou:** "..shopItem.."\n**Quantidade:** "..parseFormat(shopAmount).."\n**Horário:** "..os.date("%H:%M:%S"),13541152)
									end

									TriggerClientEvent("sounds:source",source,"cash",0.1)
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
								end
							end
						elseif shops[shopType]["type"] == "Consume" then
							if vRP.tryGetInventoryItem(user_id,shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem] * shopAmount)) then
								vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
								TriggerClientEvent("sounds:source",source,"cash",0.1)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(shops[shopType]["item"]).."</b> insuficiente.",5000)
							end
						elseif shops[shopType]["type"] == "Premium" then
							if vRP.paymentGems(user_id,shops[shopType]["list"][shopItem] * shopAmount) then
								TriggerClientEvent("sounds:source",source,"cash",0.1)
								vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
								TriggerClientEvent("Notify",source,"verde","Comprou <b>"..parseFormat(shopAmount).."x "..itemName(shopItem).."</b> por <b>"..parseFormat(shops[shopType]["list"][shopItem] * shopAmount).." Gemas</b>.",5000)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				elseif shops[shopType]["mode"] == "Sell" then
					local splitName = splitString(shopItem,"-")

					if shops[shopType]["list"][splitName[1]] then
						local itemPrice = shops[shopType]["list"][splitName[1]]

						if itemPrice > 0 then
							if vRP.checkBroken(shopItem) then
								TriggerClientEvent("Notify",source,"vermelho","Itens quebrados não podem ser vendidos.",5000)
								vCLIENT.updateShops(source,"requestShop")
								return
							end
						end

						if shops[shopType]["type"] == "Cash" then
							if vRP.tryGetInventoryItem(user_id,shopItem,parseInt(shopAmount),true,slot) then
								if itemPrice > 0 then
									vRP.generateItem(user_id,"dollars",parseInt(itemPrice * shopAmount),false)
									TriggerClientEvent("sounds:source",source,"cash",0.1)
								end
							end
						elseif shops[shopType]["type"] == "Consume" then
							if vRP.tryGetInventoryItem(user_id,shopItem,parseInt(shopAmount),true,slot) then
								if itemPrice > 0 then
									vRP.generateItem(user_id,shops[shopType]["item"],parseInt(itemPrice * shopAmount),false)
									TriggerClientEvent("sounds:source",source,"cash",0.1)
								end
							end
						end
					end
				end
			end
		else
			print(shopType,shopItem,shopAmount,slot)
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
			vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			vCLIENT.updateShops(source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inventory = vRP.userInventory(user_id)
		if inventory[tostring(slot)] and inventory[tostring(target)] and inventory[tostring(slot)]["item"] == inventory[tostring(target)]["item"] then
			if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
				vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			end
		else
			vRP.swapSlot(user_id,slot,target)
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DIVINGSUIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:divingSuit")
AddEventHandler("shops:divingSuit",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source,"Comprar <b>Roupa de Mergulho</b> por <b>$975</b>?") then
			if vRP.paymentFull(user_id,975) then
				vRP.generateItem(user_id,"divingsuit",1,true)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local ScreenShotsWebhook = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCREENSHOOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tela", function(source, args, rawCommand)
    local source = source
    local Passport = vRP.getUserId(source)
    if args[1] then
        if vRP.hasPermission(Passport, "Admin") then
            local Source = vRP.getUserSource(parseInt(args[1]))
            TriggerClientEvent("megazord:Screenshot",Source,ScreenShotsWebhook)
        end
    end
end)