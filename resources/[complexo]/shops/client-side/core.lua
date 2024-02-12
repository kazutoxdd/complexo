-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("shops",cRP)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(data,cb)
	local inventoryShop,inventoryUser,invPeso,invMaxpeso,shopSlots = vSERVER.requestShop(data["shop"])
	if inventoryShop then
		cb({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, invPeso = invPeso, invMaxpeso = invMaxpeso, shopSlots = shopSlots })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(data)
	if MumbleIsConnected() then
		vSERVER.functionShops(data["shop"],data["item"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("shops:populateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("shops:updateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateShops(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local shopList = {
	{ -550.41,-192.39,38.22,"Identity",false },
	{ -552.67,-193.72,38.22,"Identity",false },
	{ 1275.6,-1710.27,54.76,"Identity2",false },
	{ -565.97,5325.87,73.58,"Lenhador",false },
	{ 24.9,-1346.8,29.49,"Departament",true },
	{ 2556.74,381.24,108.61,"Departament",true },
	{ 1164.82,-323.65,69.2,"Departament",true },
	{ -706.15,-914.53,19.21,"Departament",true },
	{ -47.38,-1758.68,29.42,"Departament",true },
	{ 373.1,326.81,103.56,"Departament",true },
	{ -3242.75,1000.46,12.82,"Departament",true },
	{ 1728.47,6415.46,35.03,"Departament",true },
	{ 1960.2,3740.68,32.33,"Departament",true },
	{ 2677.8,3280.04,55.23,"Departament",true },
	{ 1697.31,4923.49,42.06,"Departament",true },
	{ -1819.52,793.48,138.08,"Departament",true },
	{ 1391.69,3605.97,34.98,"Departament",true },
	{ -2966.41,391.55,15.05,"Departament",true },
	{ -3039.54,584.79,7.9,"Departament",true },
	{ 1134.33,-983.11,46.4,"Departament",true },
	{ 1165.28,2710.77,38.15,"Departament",true },
	{ -1486.72,-377.55,40.15,"Departament",true },
	{ -1221.45,-907.92,12.32,"Departament",true },
	{ 161.2,6641.66,31.69,"Departament",true },
	{ -160.62,6320.93,31.58,"Departament",true },
	{ 548.7,2670.73,42.16,"Departament",true },
	{ 1693.2,3760.13,34.69,"Ammunation",false },
	{ 252.61,-50.12,69.94,"Ammunation",false },
	{ 842.37,-1034.01,28.19,"Ammunation",false },
	{ -330.71,6084.1,31.46,"Ammunation",false },
	{ -662.28,-934.85,21.82,"Ammunation",false },
	{ -1305.36,-394.36,36.7,"Ammunation",false },
	{ -1118.1,2698.84,18.55,"Ammunation",false },
	{ 2567.9,293.86,108.73,"Ammunation",false },
	{ -3172.39,1087.88,20.84,"Ammunation",false },
	{ 22.17,-1106.71,29.79,"Ammunation",false },
	{ 810.18,-2157.77,29.62,"Ammunation",false },
	{ -1082.25,-247.52,37.76,"Premium",false },
	{ 45.26,-1750.61,29.64,"StoreM",false },
	{ 2748.19,3473.89,55.67,"StoreM",false },
	{ 47.2,-1748.26,29.64,"StoreV",false },
	{ -1816.64,-1193.73,14.31,"Fishing",false },
	{ 1523.69,3782.48,34.51,"Fishing2",true },
	{ -695.56,5802.12,17.32,"Hunting",false },
	{ -679.13,5839.52,17.32,"Hunting2",false },
	{ -665.06,320.11,83.09,"Pharmacy",false },
	{ 1140.1,-1563.63,35.38,"Pharmacy",false },
	{ 1140.12,-1562.03,35.38,"Pharmacy",false },
	{ 326.5,-1074.43,29.47,"Pharmacy",false },
	{ -457.2,-309.65,34.91,"Pharmacy",false },
	{ 114.62,-5.3,67.82,"Pharmacy",false },
	{ 1690.38,3581.25,35.62,"Pharmacy",false },
	{ -172.49,6380.97,31.48,"Pharmacy",false },
	{ -72.71,-815.98,243.38,"Diagram",false },
	{ -680.03,329.07,88.01,"Paramedic",false },
	{ 1822.70,3686.64,34.26,"Paramedic",false },
	{ -254.64,6326.95,32.82,"Paramedic",false },
	{ -691.43,322.41,83.09,"Coffee",false },
	{ 385.73,-828.02,29.3,"Digital",false },
	{ -428.57,-1728.35,19.78,"Recycle",false },
	{ 180.55,2793.45,45.65,"Recycle",false },
	{ -195.79,6264.95,31.49,"Recycle",false },
	{ -947.82,-2040.5,9.4,"Police",false },
	{ 1838.43,3686.29,34.19,"Police",false },
	{ -447.15,6016.51,36.99,"Police",false },
	{ 385.5,799.94,190.49,"Police",false },
	{ 362.37,-1603.12,25.44,"Police",false },
	{ -748.0,-1417.83,5.14,"Police",false },
	{ -620.95,-228.67,38.05,"Miners",false },
	{ 475.1,3555.28,33.23,"Criminal",false },
	{ 112.41,3373.68,35.25,"Criminal2",false },
	{ 2013.95,4990.88,41.21,"Criminal3",false },
	{ 186.9,6374.75,32.33,"Criminal4",false },
	{ -653.12,-1502.67,5.22,"Criminal",false },
	{ 389.71,-942.61,29.42,"Criminal2",false },
	{ 154.98,-1472.47,29.35,"Criminal3",false },
	{ 488.1,-1456.11,29.28,"Criminal4",false },
	{ 465.62,-750.75,27.36,"Criminal5",false },
	{ 169.76,-1535.88,29.25,"Weapons",false },
	{ 301.14,-195.75,61.57,"Weapons",false },
	{ 883.96,-2023.63,30.62,"mechanicBuy",false },
	{ 883.06,-2034.39,30.62,"mechanicBuy",false },
	{ 882.04,-2045.47,30.62,"mechanicBuy",false },
	{ -1141.23,-2005.29,13.18,"mechanicBuy",false },
	{ 1189.09,2636.7,38.4,"mechanicBuy",false },
	{ 98.06,6619.23,32.44,"mechanicBuy",false },
	{ -216.4,-1318.9,30.89,"mechanicBuy",false },
	{ -197.4,-1320.51,31.09,"mechanicBuy",false },
	{ -199.41,-1319.81,31.09,"mechanicBuy",false },
	{ -1407.48,-443.59,35.91,"mechanicBuy",false },
	{ -40.08,-1056.54,28.39,"mechanicBuy",false },
	{ -33.49,-1040.83,28.59,"mechanicBuy",false },
	{ -32.14,-1039.04,28.59,"mechanicBuy",false },
	{ 1179.12,2635.86,37.74,"mechanicBuy",false },
	{ 839.42,-948.68,26.49,"mechanicBuy",false },
	{ 839.61,-957.83,26.49,"mechanicBuy",false },
	{ 839.75,-967.38,26.49,"mechanicBuy",false },
	{ 839.74,-975.0,26.49,"mechanicBuy",false },
	{ -1636.74,-1092.17,13.08,"Oxy",false },
	-----{ 563.31,2751.64,42.87,"Petz",false },
	{ -1196.9,-901.58,13.99,"BurgerShot",false },
	{ 806.22,-761.68,26.77,"PizzaThis",false },
	{ -588.5,-1066.23,22.34,"UwuCoffee",false },
	{ 124.01,-1036.72,29.27,"BeanMachine",false },
	{ -1127.26,-1439.35,5.22,"Clothes",false },
	{ 78.26,-1388.91,29.37,"Clothes",false },
	{ -706.73,-151.38,37.41,"Clothes",false },
	{ -166.69,-301.55,39.73,"Clothes",false },
	{ -817.5,-1074.03,11.32,"Clothes",false },
	{ -1197.33,-778.98,17.32,"Clothes",false },
	{ -1447.84,-240.03,49.81,"Clothes",false },
	{ -0.07,6511.8,31.88,"Clothes",false },
	{ 1691.6,4818.47,42.06,"Clothes",false },
	{ 123.21,-212.34,54.56,"Clothes",false },
	{ -380.49,266.02,86.46,"Lasttrain",false },
	{ 1995.04,3721.98,34.93,"Lasttrain",false },
	{ 621.24,2753.37,42.09,"Clothes",false },
	{ 1200.68,2707.35,38.22,"Clothes",false },
	{ -3172.39,1055.31,20.86,"Clothes",false },
	{ -1096.53,2711.1,19.11,"Clothes",false },
	{ 422.7,-810.25,29.49,"Clothes",false },
	{ -1174.54,-1571.4,4.35,"Weeds",false },
	{ 1116.51,221.77,-49.44,"ChipsV",false },
	{ 1116.45,218.15,-49.44,"ChipsC",false },
	{ 835.75,-1298.78,24.31,"Police",false },
	{ 1111.98,206.7,-49.44,"Cassino",false },
	{ 1111.14,209.23,-49.44,"Cassino",false },
	{ 380.58,793.94,187.67,"Police",false },
	{ 1853.25,3690.08,34.26,"Police",false }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)

	for k,v in pairs(shopList) do
		exports["target"]:AddCircleZone("Shops:"..k,vec3(v[1],v[2],v[3]),0.75,{
			name = "Shops:"..k,
			heading = 3374176
		},{
			shop = k,
			distance = 1.75,
			options = {
				{
					event = "shops:openSystem",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:openSystem",function(shopId)
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.requestPerm(shopList[shopId][4]) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = shopList[shopId][4], type = vSERVER.getShopType(shopList[shopId][4]) })

			if shopList[shopId][5] then
				TriggerEvent("sounds:source","shop",0.5)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "coffeeMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "sodaMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "donutMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "burgerMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "hotdogMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:CHIHUAHUA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Chihuahua",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "Chihuahua", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "waterMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEDICBAG
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:medicBag",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.requestPerm("Paramedic") then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = "Paramedic", type = "Buy" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Fuel",function()
	SendNUIMessage({ action = "showNUI", name = "Fuel", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEGAZORD:SCREENSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("megazord:Screenshot")
AddEventHandler("megazord:Screenshot",function(Webhook)
	exports["screenshot"]:requestScreenshotUpload(Webhook,"files[]",function(Data) end)
end)