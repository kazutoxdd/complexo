-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
emP = {}
Tunnel.bindInterface("facs",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO 
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Vagos") or vRP.hasPermission(user_id,"LiderVagos") or vRP.hasPermission(user_id,"LiderBloods") or vRP.hasPermission(user_id,"LiderFerroVelho") or vRP.hasPermission(user_id,"FerroVelho") or vRP.hasPermission(user_id,"Bloods") or vRP.hasPermission(user_id,"LiderCrips") or vRP.hasPermission(user_id,"Crips") or vRP.hasPermission(user_id,"LiderBLX") or vRP.hasPermission(user_id,"LiderPlayBoy") or vRP.hasPermission(user_id,"PlayBoy") or vRP.hasPermission(user_id,"BLX") or vRP.hasPermission(user_id,"LiderPrimatas") or vRP.hasPermission(user_id,"Primatas") or vRP.hasPermission(user_id,"Yakuza") or vRP.hasPermission(user_id,"LiderYakuza") or vRP.hasPermission(user_id,"Duros") or vRP.hasPermission(user_id,"LiderDuros") or vRP.hasPermission(user_id,"Ballas") or vRP.hasPermission(user_id,"LiderBallas") or vRP.hasPermission(user_id,"Vanilla") or vRP.hasPermission(user_id,"LiderVanilla") or vRP.hasPermission(user_id,"Vinhedo") or vRP.hasPermission(user_id,"LiderVinhedo") or vRP.hasPermission(user_id,"BDT") or vRP.hasPermission(user_id,"LiderBDT") or vRP.hasPermission(user_id,"Fazenda") or vRP.hasPermission(user_id,"LiderFazenda") or vRP.hasPermission(user_id,"FavelaNH") or vRP.hasPermission(user_id,"LiderFavelaNH") or vRP.hasPermission(user_id,"FavelaDK") or vRP.hasPermission(user_id,"LiderFavelaDK") or vRP.hasPermission(user_id,"Grota") or vRP.hasPermission(user_id,"LiderGrota") or vRP.hasPermission(user_id,"Pedreira") or vRP.hasPermission(user_id,"LiderPedreira") or vRP.hasPermission(user_id,"FavelaSV") or vRP.hasPermission(user_id,"LiderFavelaSV") or vRP.hasPermission(user_id,"Cosanostra") or vRP.hasPermission(user_id,"LiderCosanostra") or vRP.hasPermission(user_id,"Motoclub") or vRP.hasPermission(user_id,"LiderMotoclub") or vRP.hasPermission(user_id,"Salieris") or vRP.hasPermission(user_id,"LiderSalieris") or vRP.hasPermission(user_id,"Arcade") or vRP.hasPermission(user_id,"LiderArcade") or vRP.hasPermission(user_id,"Bahamas") or vRP.hasPermission(user_id,"LiderBahamas") or vRP.hasPermission(user_id,"HotGirls") or vRP.hasPermission(user_id,"LiderHotGirls") then 
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Você não tem acesso.", 5000)
			return false
		end						
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

-----------------------------------------------------------------------------------------------------------------------------------------
-- Vinhedo - Munição
-----------------------------------------------------------------------------------------------------------------------------------------
if vRP.hasPermission(user_id,"Vinhedo") or vRP.hasPermission(user_id,"LiderVinhedo") then
	local itens = math.random(100)
	local quantidade = math.random(90,100)
	if itens <= 100 then
			quantidade = math.random(90,100)
			quantidade2 = math.random(90,100)
			vRP.giveInventoryItem( user_id,"gunpowder",quantidade)
			vRP.giveInventoryItem( user_id,"capsule",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Polvora",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Capsula",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end	
-----------------------------------------------------------------------------------------------------------------------------------------
-- Fazenda - Munição
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Fazenda") or vRP.hasPermission(user_id,"LiderFazenda") then
	local itens = math.random(100)
	local quantidade = math.random(90,100)
	if itens <= 100 then
			quantidade = math.random(90,100)
			quantidade2 = math.random(90,100)
			vRP.giveInventoryItem( user_id,"gunpowder",quantidade)
			vRP.giveInventoryItem( user_id,"capsule",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Polvora",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Capsula",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end	
-----------------------------------------------------------------------------------------------------------------------------------------
-- FerroVelho - Munição
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"FerroVelho") or vRP.hasPermission(user_id,"LiderFerroVelho") then
	local itens = math.random(100)
	local quantidade = math.random(90,100)
	if itens <= 100 then
			quantidade = math.random(90,100)
			quantidade2 = math.random(90,100)
			vRP.giveInventoryItem( user_id,"gunpowder",quantidade)
			vRP.giveInventoryItem( user_id,"capsule",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Polvora",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Capsula",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end	
-----------------------------------------------------------------------------------------------------------------------------------------
-- PlayBoy - Arma
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"PlayBoy") or vRP.hasPermission(user_id,"LiderPlayBoy") then
	local itens = math.random(100)
	local quantidade = math.random(10,12)
	if itens <= 100 then
			quantidade = math.random(10,12)
			quantidade2 = math.random(10,12)
			quantidade3 = math.random(10,12)
			quantidade4 = math.random(20,22)
			quantidade5 = math.random(20,22)
			vRP.giveInventoryItem( user_id,"rubber",quantidade)
			vRP.giveInventoryItem( user_id,"glass",quantidade2)
			vRP.giveInventoryItem( user_id,"plastic",quantidade3)
			vRP.giveInventoryItem( user_id,"copper",quantidade4)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade5)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Borrachas",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Garrafa de vidro",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade3.."x Plastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade4.."x Cobre",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade5.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
	-----------------------------------------------------------------------------------------------------------------------------------------
-- Yakuza - Arma
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Yakuza") or vRP.hasPermission(user_id,"LiderYakuza") then
	local itens = math.random(100)
	local quantidade = math.random(10,12)
	if itens <= 100 then
			quantidade = math.random(10,12)
			quantidade2 = math.random(10,12)
			quantidade3 = math.random(10,12)
			quantidade4 = math.random(20,22)
			quantidade5 = math.random(20,22)
			vRP.giveInventoryItem( user_id,"rubber",quantidade)
			vRP.giveInventoryItem( user_id,"glass",quantidade2)
			vRP.giveInventoryItem( user_id,"plastic",quantidade3)
			vRP.giveInventoryItem( user_id,"copper",quantidade4)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade5)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Borrachas",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Garrafa de vidro",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade3.."x Plastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade4.."x Cobre",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade5.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Cosanostra - Arma
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Cosanostra") or vRP.hasPermission(user_id,"LiderCosanostra") then
	local itens = math.random(100)
	local quantidade = math.random(10,12)
	if itens <= 100 then
			quantidade = math.random(10,12)
			quantidade2 = math.random(10,12)
			quantidade3 = math.random(10,12)
			quantidade4 = math.random(20,22)
			quantidade5 = math.random(20,22)
			vRP.giveInventoryItem( user_id,"rubber",quantidade)
			vRP.giveInventoryItem( user_id,"glass",quantidade2)
			vRP.giveInventoryItem( user_id,"plastic",quantidade3)
			vRP.giveInventoryItem( user_id,"copper",quantidade4)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade5)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Borrachas",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Garrafa de vidro",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade3.."x Plastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade4.."x Cobre",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade5.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Vanilla -- LAVAGEM -- ALGEMA
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Vanilla") or vRP.hasPermission(user_id,"LiderVanilla") then
	local itens = math.random(100)
	local quantidade = math.random(1,3)
	if itens <= 100 then
			quantidade = math.random(1,3)
			quantidade2 = math.random(1,3)
			vRP.giveInventoryItem( user_id,"elastic",quantidade)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Elastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Bahamas -- LAVAGEM -- ALGEMA
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Bahamas") or vRP.hasPermission(user_id,"LiderBahamas") then
	local itens = math.random(100)
	local quantidade = math.random(1,3)
	if itens <= 100 then
			quantidade = math.random(1,3)
			quantidade2 = math.random(1,3)
			vRP.giveInventoryItem( user_id,"elastic",quantidade)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Elastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HotGirls -- LAVAGEM -- ALGEMA
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"HotGirls") or vRP.hasPermission(user_id,"LiderHotGirls") then
	local itens = math.random(100)
	local quantidade = math.random(1,3)
	if itens <= 100 then
			quantidade = math.random(1,3)
			quantidade2 = math.random(1,3)
			vRP.giveInventoryItem( user_id,"elastic",quantidade)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Elastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Motoclub e Primatas- Lockpick, Placa e ticket
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Motoclub") or vRP.hasPermission(user_id,"LiderMotoclub") or vRP.hasPermission(user_id,"LiderPrimatas") or vRP.hasPermission(user_id,"Primatas")  then
	local itens = math.random(100)
	local quantidade = math.random(2,3)
	if itens <= 100 then
			quantidade = math.random(2,3)
			quantidade2 = math.random(2,3)
			vRP.giveInventoryItem( user_id,"copper",quantidade)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Cobre",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VAGOS - Lanca
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Vagos") or vRP.hasPermission(user_id,"LiderVagos")  then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"plastic",quantidade)
			vRP.giveInventoryItem( user_id,"saline",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Plastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Soro Fisiológico",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Ballas - Ecstasy
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Ballas") or vRP.hasPermission(user_id,"LiderBallas")  then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"codeine",quantidade)
			vRP.giveInventoryItem( user_id,"saline",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Codeína",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Soro Fisiológico",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Bloods - Lsd
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Bloods") or vRP.hasPermission(user_id,"LiderBloods")  then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"glass",quantidade)
			vRP.giveInventoryItem( user_id,"saline",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Vidro",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Soro Fisiológico",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Crips - Xanax
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Crips") or vRP.hasPermission(user_id,"LiderCrips")  then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"glass",quantidade)
			vRP.giveInventoryItem( user_id,"codeine",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Vidro",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Codeina",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FavelaDK - Baseado
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"FavelaDK") or vRP.hasPermission(user_id,"LiderFavelaDK")  then
    local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"paper",quantidade)
			vRP.giveInventoryItem( user_id,"weedleaf",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Papel",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Folha de Maconha",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLX - Munição
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"BLX") or vRP.hasPermission(user_id,"BLX") then
	local itens = math.random(100)
	local quantidade = math.random(90,100)
	if itens <= 100 then
			quantidade = math.random(90,100)
			quantidade2 = math.random(90,100)
			vRP.giveInventoryItem( user_id,"gunpowder",quantidade)
			vRP.giveInventoryItem( user_id,"capsule",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Polvora",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Capsula",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end	
-----------------------------------------------------------------------------------------------------------------------------------------
-- Grota - Meth
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Grota") or vRP.hasPermission(user_id,"LiderGrota") then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"amphetamine",quantidade)
			vRP.giveInventoryItem( user_id,"glass",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Anfetamina",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Vidro",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Arcade - Attachs - Credencial
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Arcade") or vRP.hasPermission(user_id,"LiderArcade") then
	local itens = math.random(100)
	local quantidade = math.random(3,4)
	if itens <= 100 then
			quantidade = math.random(3,4)
			quantidade2 = math.random(3,4)
			quantidade3 = math.random(3,4)
			quantidade4 = math.random(3,4)
			quantidade5 = math.random(3,4)
			vRP.giveInventoryItem( user_id,"techtrash",quantidade)
			vRP.giveInventoryItem( user_id,"roadsigns",quantidade2)
			vRP.giveInventoryItem( user_id,"sheetmetal",quantidade3)
			vRP.giveInventoryItem( user_id,"copper",quantidade4)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade5)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Lixo Eletronico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Placa",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade3.."x Chapa de Metal",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Cobre",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Salieris - Attachs - Colete
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Salieris") or vRP.hasPermission(user_id,"LiderSalieris")  then
	local itens = math.random(100)
	local quantidade = math.random(3,4)
	if itens <= 100 then
			quantidade = math.random(3,4)
			quantidade2 = math.random(3,4)
			quantidade3 = math.random(3,4)
			vRP.giveInventoryItem( user_id,"techtrash",quantidade)
			vRP.giveInventoryItem( user_id,"roadsigns",quantidade2)
			vRP.giveInventoryItem( user_id,"sheetmetal",quantidade3)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Lixo Eletronico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Placa",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade3.."x Chapa de Metal",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FavelaNH - Cocaina
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"FavelaNH") or vRP.hasPermission(user_id,"LiderFavelaNH") then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"codeine",quantidade)
			vRP.giveInventoryItem( user_id,"saline",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Codeina",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Soro",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
	-----------------------------------------------------------------------------------------------------------------------------------------
-- Duros - Lança Perfume
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Duros") or vRP.hasPermission(user_id,"LiderDuros") then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"plastic",quantidade)
			vRP.giveInventoryItem( user_id,"saline",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Plastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Soro",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FavelaSV - Heroina
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"FavelaSV") or vRP.hasPermission(user_id,"LiderFavelaSV") then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"plastic",quantidade)
			vRP.giveInventoryItem( user_id,"saline",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Codeina.",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Soro.",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BDT - Heroine
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"BDT") or vRP.hasPermission(user_id,"LiderBDT") then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"codeine",quantidade)
			vRP.giveInventoryItem( user_id,"saline",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Codeina.",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Soro.",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDREIRA - Lean
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Pedreira") or vRP.hasPermission(user_id,"LiderPedreira") then
	local itens = math.random(100)
	local quantidade = math.random(3,5)
	if itens <= 100 then
			quantidade = math.random(3,5)
			quantidade2 = math.random(3,5)
			vRP.giveInventoryItem( user_id,"codeine",quantidade)
			vRP.giveInventoryItem( user_id,"plastic",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Codeina",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Plastico",5000)
		else
			TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
		end	
	end
	return true
end
end