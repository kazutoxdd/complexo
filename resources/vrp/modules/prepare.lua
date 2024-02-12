-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("characters/allChars","SELECT * FROM summerz_characters")
vRP.prepare("characters/getUsers","SELECT * FROM summerz_characters WHERE id = @id")
vRP.prepare("characters/getPhone","SELECT id FROM summerz_characters WHERE phone = @phone")
vRP.prepare("characters/getSerial","SELECT id FROM summerz_characters WHERE serial = @serial")
vRP.prepare("characters/getBlood","SELECT id FROM summerz_characters WHERE blood = @blood")
vRP.prepare("characters/updatePort","UPDATE summerz_characters SET port = @port WHERE id = @id")
vRP.prepare("characters/updateCriminal","UPDATE summerz_characters SET criminal = @criminal WHERE id = @id")
vRP.prepare("characters/updatePhone","UPDATE summerz_characters SET phone = @phone WHERE id = @id")
vRP.prepare("characters/updateBackpack","UPDATE summerz_characters SET backpack = @backpack WHERE id = @id")
vRP.prepare("characters/removeCharacters","UPDATE summerz_characters SET deleted = 1 WHERE id = @id")
vRP.prepare("characters/addFines","UPDATE summerz_characters SET fines = fines + @fines WHERE id = @id")
vRP.prepare("characters/setPrison","UPDATE summerz_characters SET prison = @prison WHERE id = @user_id")
vRP.prepare("characters/updateGarages","UPDATE summerz_characters SET garage = garage + 1 WHERE id = @id")
vRP.prepare("characters/removeFines","UPDATE summerz_characters SET fines = fines - @fines WHERE id = @id")
vRP.prepare("characters/getCharacters","SELECT * FROM summerz_characters WHERE steam = @steam and deleted = 0")
vRP.prepare("characters/removePrison","UPDATE summerz_characters SET prison = prison - @prison WHERE id = @user_id")
vRP.prepare("characters/atualizarPrison","UPDATE summerz_characters SET prison = @prison WHERE id = @user_id")
vRP.prepare("characters/updateName","UPDATE summerz_characters SET name = @name, name2 = @name2 WHERE id = @user_id")
vRP.prepare("characters/lastCharacters","SELECT id FROM summerz_characters WHERE steam = @steam ORDER BY id DESC LIMIT 1")
vRP.prepare("characters/countPersons","SELECT COUNT(steam) as qtd FROM summerz_characters WHERE steam = @steam and deleted = 0")
vRP.prepare("characters/newCharacter","INSERT INTO summerz_characters(steam,name,name2,sex,phone,serial,blood) VALUES(@steam,@name,@name2,@sex,@phone,@serial,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PORTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("characters/getPorts","SELECT * FROM summerz_ports WHERE 1")
vRP.prepare("characters/getPortByPassport","SELECT * FROM summerz_ports WHERE user_id = @user_id")
vRP.prepare("characters/getPortByid","SELECT * FROM summerz_ports WHERE portId = @portId")
vRP.prepare("characters/createPort","INSERT INTO summerz_ports (user_id, serial, identity, portType, exam, nuser_id, date) VALUES(@user_id, @serial, @identity, @portType, @exam, @nuser_id, @date)")
vRP.prepare("characters/updatePort","UPDATE summerz_ports SET serial = @serial, portType = @portType, exam = @exam, user_id = @user_id  WHERE portId = @portId")
vRP.prepare("characters/deletePort","DELETE FROM summerz_ports WHERE portId = @portId")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("prison/cleanRecords","DELETE FROM summerz_prison WHERE nuser_id = @nuser_id")
vRP.prepare("prison/getRecords","SELECT * FROM summerz_prison WHERE nuser_id = @nuser_id ORDER BY id DESC")
vRP.prepare("prison/getRecordsById","SELECT * FROM summerz_prison WHERE id = @id")
vRP.prepare("prison/insertPrison","INSERT INTO summerz_prison(police,nuser_id,services,fines,text,date,association,residual,cops,url) VALUES(@police,@nuser_id,@services,@fines,@text,@date,@association,@residual,@cops,@url)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARRANTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("warrants/getAll", "SELECT * FROM summerz_warrants WHERE 1")
vRP.prepare("warrants/getWarrant", "SELECT * FROM summerz_warrants WHERE id = @id")
vRP.prepare("warrants/setWarrant", "INSERT INTO summerz_warrants (user_id, identity, status, nidentity, timeStamp, reason) VALUES(@user_id, @identity, @status, @nidentity, @timeStamp, @reason)")
vRP.prepare("warrants/deleteWarrant", "DELETE FROM summerz_warrants WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("bank/getInfos","SELECT * FROM summerz_bank WHERE user_id = @user_id AND mode = @mode AND owner = 1")
vRP.prepare("bank/newAccount","INSERT INTO summerz_bank(user_id,value,mode,owner) VALUES(@user_id,@value,@mode,@owner)")
vRP.prepare("bank/addValue","UPDATE summerz_bank SET value = value + @value WHERE user_id = @user_id AND mode = @mode AND owner = 1")
vRP.prepare("bank/remValue","UPDATE summerz_bank SET value = value - @value WHERE user_id = @user_id AND mode = @mode AND owner = 1")

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("log/addValueBank","INSERT INTO klein_log_deposit_bank(user_id,value,dt_atualizacao) VALUES(@user_id,@value,NOW())")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("accounts/getInfos","SELECT * FROM summerz_accounts WHERE steam = @steam")
vRP.prepare("accounts/newAccount","INSERT INTO summerz_accounts(steam) VALUES(@steam)")
vRP.prepare("accounts/updateWhitelist","UPDATE summerz_accounts SET whitelist = 0 WHERE steam = @steam")
vRP.prepare("accounts/removeGems","UPDATE summerz_accounts SET gems = gems - @gems WHERE steam = @steam")
vRP.prepare("accounts/setPriority","UPDATE summerz_accounts SET priority = @priority WHERE steam = @steam")
vRP.prepare("accounts/infosUpdatechars","UPDATE summerz_accounts SET chars = chars + 1 WHERE steam = @steam")
vRP.prepare("accounts/infosUpdategems","UPDATE summerz_accounts SET gems = gems + @gems WHERE steam = @steam")
vRP.prepare("accounts/updatePremium","UPDATE summerz_accounts SET premium = premium + 2592000 WHERE steam = @steam")
vRP.prepare("accounts/setPremium","UPDATE summerz_accounts SET premium = @premium, priority = @priority WHERE steam = @steam")
vRP.prepare("accounts/get_discord", "SELECT discord FROM summerz_accounts WHERE steam = @steam")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("playerdata/getUserdata","SELECT dvalue FROM summerz_playerdata WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("playerdata/setUserdata","REPLACE INTO summerz_playerdata(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("entitydata/removeData","DELETE FROM summerz_entitydata WHERE dkey = @dkey")
vRP.prepare("entitydata/getData","SELECT dvalue FROM summerz_entitydata WHERE dkey = @dkey")
vRP.prepare("entitydata/setData","REPLACE INTO summerz_entitydata(dkey,dvalue) VALUES(@dkey,@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vehicles/plateVehicles","SELECT * FROM summerz_vehicles WHERE plate = @plate")
vRP.prepare("vehicles/getVehicles","SELECT * FROM summerz_vehicles WHERE user_id = @user_id")
vRP.prepare("vehicles/removeVehicles","DELETE FROM summerz_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/selectVehicles","SELECT * FROM summerz_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/paymentArrest","UPDATE summerz_vehicles SET arrest = 0 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/moveVehicles","UPDATE summerz_vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/plateVehiclesUpdate","UPDATE summerz_vehicles SET plate = @plate WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/rentalVehiclesDays","UPDATE summerz_vehicles SET rental = rental + 31104000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/arrestVehicles","UPDATE summerz_vehicles SET arrest = UNIX_TIMESTAMP() + 31104000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/updateVehiclesTax","UPDATE summerz_vehicles SET tax = UNIX_TIMESTAMP() + 31104000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/rentalVehiclesUpdate","UPDATE summerz_vehicles SET rental = UNIX_TIMESTAMP() + 31104000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/addVehicles","INSERT IGNORE INTO summerz_vehicles(user_id,vehicle,plate,work,tax) VALUES(@user_id,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 604800)")
vRP.prepare("vehicles/rentalVehicles","INSERT IGNORE INTO summerz_vehicles(user_id,vehicle,plate,work,rental,tax) VALUES(@user_id,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 31104000,UNIX_TIMESTAMP() + 604800)")
vRP.prepare("vehicles/updateVehicles","UPDATE summerz_vehicles SET engine = @engine, body = @body, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres, nitro = @nitro WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("propertys/selling","DELETE FROM summerz_propertys WHERE name = @name")
vRP.prepare("propertys/permissions","SELECT * FROM summerz_propertys WHERE name = @name")
vRP.prepare("propertys/totalHomes","SELECT name,tax FROM summerz_propertys WHERE owner = 1")
vRP.prepare("propertys/userList","SELECT name FROM summerz_propertys WHERE user_id = @user_id")
vRP.prepare("propertys/countUsers","SELECT COUNT(*) as qtd FROM summerz_propertys WHERE user_id = @user_id")
vRP.prepare("propertys/countPermissions","SELECT COUNT(*) as qtd FROM summerz_propertys WHERE name = @name")
vRP.prepare("propertys/userOwnermissions","SELECT * FROM summerz_propertys WHERE name = @name AND owner = 1")
vRP.prepare("propertys/removePermissions","DELETE FROM summerz_propertys WHERE name = @name AND user_id = @user_id")
vRP.prepare("propertys/userPermissions","SELECT * FROM summerz_propertys WHERE name = @name AND user_id = @user_id")
vRP.prepare("propertys/updateOwner","UPDATE summerz_propertys SET user_id = @nuser_id WHERE user_id = @user_id AND name = @name")
vRP.prepare("propertys/updateTax","UPDATE summerz_propertys SET tax = UNIX_TIMESTAMP() + 2592000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/updateVault","UPDATE summerz_propertys SET vault = vault + 10, price = price + 10000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/updateFridge","UPDATE summerz_propertys SET fridge = fridge + 10, price = price + 10000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/newPermissions","INSERT IGNORE INTO summerz_propertys(name,interior,user_id,owner) VALUES(@name,@interior,@user_id,@owner)")
vRP.prepare("propertys/buying","INSERT IGNORE INTO summerz_propertys(name,interior,price,user_id,tax,residents,vault,fridge,owner) VALUES(@name,@interior,@price,@user_id,UNIX_TIMESTAMP() + 604800,@residents,@vault,@fridge,1)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("prison/cleanRecords","DELETE FROM summerz_prison WHERE nuser_id = @nuser_id")
vRP.prepare("prison/getRecords","SELECT * FROM summerz_prison WHERE nuser_id = @nuser_id ORDER BY id DESC")
vRP.prepare("prison/insertPrison","INSERT INTO summerz_prison(police,nuser_id,services,fines,text,date) VALUES(@police,@nuser_id,@services,@fines,@text,@date)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNEDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("banneds/getBanned","SELECT * FROM summerz_banneds WHERE steam = @steam")
vRP.prepare("banneds/removeBanned","DELETE FROM summerz_banneds WHERE steam = @steam")
vRP.prepare("banneds/insertBanned","INSERT INTO summerz_banneds(steam,time) VALUES(@steam,UNIX_TIMESTAMP() + 86400 * @time)")

vRP.prepare("accounts/setwl","UPDATE summerz_accounts SET whitelist = @whitelist WHERE steam = @steam")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("chests/getChests","SELECT * FROM summerz_chests WHERE name = @name")
vRP.prepare("chests/upgradeChests","UPDATE summerz_chests SET weight = weight + 25 WHERE name = @name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("warehouses/getWarehouses","SELECT * FROM summerz_warehouses WHERE name = @name")
vRP.prepare("warehouses/getownerWarehouses","SELECT * FROM summerz_warehouses WHERE name = @name AND user_id = @user_id")
vRP.prepare("warehouses/upgradeWarehouses","UPDATE summerz_warehouses SET weight = weight + 10 WHERE name = @name")
vRP.prepare("warehouses/checkpassWarehouses","SELECT * FROM summerz_warehouses WHERE name = @name AND password = @password")
vRP.prepare("warehouses/updatepassWarehouses","UPDATE summerz_warehouses SET password = @password WHERE name = @name AND user_id = @user_id")
vRP.prepare("warehouses/buyWarehouses","INSERT IGNORE INTO summerz_warehouses(name,weight,password,user_id,tax) VALUES(@name,@weight,@password,@user_id,UNIX_TIMESTAMP() + 2592000)")
vRP.prepare("warehouses/Tax","UPDATE summerz_warehouses SET tax = UNIX_TIMESTAMP() + 2592000 WHERE name = @name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("races/checkResult","SELECT * FROM summerz_races WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/requestRanking","SELECT * FROM summerz_races WHERE raceid = @raceid ORDER BY points ASC LIMIT 5")
vRP.prepare("races/updateRecords","UPDATE summerz_races SET points = @points, vehicle = @vehicle WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/insertRecords","INSERT INTO summerz_races(raceid,user_id,name,vehicle,points) VALUES(@raceid,@user_id,@name,@vehicle,@points)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("fidentity/getResults","SELECT * FROM summerz_fidentity WHERE id = @id")
vRP.prepare("fidentity/lastIdentity","SELECT id FROM summerz_fidentity ORDER BY id DESC LIMIT 1")
vRP.prepare("fidentity/newIdentity","INSERT INTO summerz_fidentity(name,name2,blood) VALUES(@name,@name2,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("summerz/playerdata","DELETE FROM summerz_playerdata WHERE dvalue = '[]' OR dvalue = '{}'")
vRP.prepare("summerz/entitydata","DELETE FROM summerz_entitydata WHERE dvalue = '[]' OR dvalue = '{}'")
vRP.prepare("summerz/cleanPremium","UPDATE summerz_accounts SET premium = '0', priority = '0' WHERE UNIX_TIMESTAMP() >= premium")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("groupSystem/setData","INSERT INTO gregos_members(user_id,name,cargo,status,organizacao) VALUES(@user_id ,@name,@cargo,@status , @organizacao)")
vRP.prepare("groupSystem/checkData","SELECT * FROM gregos_members WHERE user_id = @user_id ")
vRP.prepare("groupSystem/membersData","SELECT * FROM gregos_members WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/updateData","UPDATE gregos_members SET cargo = @cargo WHERE user_id = @user_id")
vRP.prepare("groupSystem/deleteData","DELETE FROM gregos_members WHERE user_id = @user_id")
vRP.prepare("groupSystem/updateStatus","UPDATE gregos_members SET status = @status WHERE user_id = @user_id")
vRP.prepare("groupSystem/HowStatus","SELECT count(status) FROM gregos_members WHERE status = @status AND organizacao = @organizacao")
vRP.prepare("groupSystem/membersQtd","SELECT count(user_id) FROM gregos_members WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/orgQtd","SELECT membros FROM gregos_organizacao WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/updateDataMembers","UPDATE gregos_organizacao SET membros = @membros WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/groupMensage","SELECT mensagem FROM gregos_organizacao WHERE organizacao = @organizacao")
vRP.prepare("groupSystem/setMensage","UPDATE gregos_organizacao SET mensagem = @mensagem WHERE organizacao = @organizacao")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCLEANERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.execute("summerz/playerdata")
	vRP.execute("summerz/entitydata")
	vRP.execute("summerz/cleanPremium")
end)