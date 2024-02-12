-----------------------------------------------------------------------------------------------------------------------------------------
-- FALSEIDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.falseIdentity(user_id)
	local identity = vRP.query("fidentity/getResults",{ id = user_id })
	return identity[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERIDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userIdentity(user_id)
	if vRP.userSources[user_id] then
		if vRP.userInfos[user_id] == nil then
			local identity = vRP.query("characters/getUsers",{ id = user_id })

			vRP.userInfos[user_id] = {}
			vRP.userInfos[user_id]["id"] = identity[1]["id"]
			vRP.userInfos[user_id]["sex"] = identity[1]["sex"]
			vRP.userInfos[user_id]["port"] = identity[1]["port"]
			vRP.userInfos[user_id]["blood"] = identity[1]["blood"]
			vRP.userInfos[user_id]["prison"] = identity[1]["prison"]
			vRP.userInfos[user_id]["garage"] = identity[1]["garage"]
			vRP.userInfos[user_id]["fines"] = identity[1]["fines"]
			vRP.userInfos[user_id]["bank"] = identity[1]["bank"]
			vRP.userInfos[user_id]["serial"] = identity[1]["serial"]
			vRP.userInfos[user_id]["phone"] = identity[1]["phone"]
			vRP.userInfos[user_id]["name"] = identity[1]["name"]
			vRP.userInfos[user_id]["name2"] = identity[1]["name2"]
			vRP.userInfos[user_id]["steam"] = identity[1]["steam"]
		end

		return vRP.userInfos[user_id]
	else
		local identity = vRP.query("characters/getUsers",{ id = user_id })
		return identity[1] or false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.initPrison(user_id,amount)
	vRP.execute("characters/setPrison",{ user_id = user_id, prison = parseInt(amount) })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["prison"] = parseInt(amount)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updatePrison(user_id)
	
	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["prison"] = vRP.userInfos[user_id]["prison"] - math.random(5)
		vRP.execute("characters/atualizarPrison",{ user_id = user_id, prison = parseInt(vRP.userInfos[user_id]["prison"]) })

		if vRP.userInfos[user_id]["prison"] < 0 then
			vRP.userInfos[user_id]["prison"] = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getPorts()
	return vRP.query("characters/getPorts", {})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPORTBYPASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getPortByPassport(user_id)
	return vRP.query("characters/getPortByPassport", { user_id = user_id })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPORTBYID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getPortById(portId)
	return vRP.query("characters/getPortByid", { portId = portId })[1] 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.createPort(passport, serial, status, exam, nuser_id)
	local identity = vRP.userIdentity(passport)
	if identity then
		vRP.execute("characters/createPort", { user_id = passport, serial = serial, identity = identity["name"] .. " " .. identity["name2"], portType = status, exam = exam, date = os.date('%d/%m/%Y', os.time()), nuser_id = nuser_id })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradePort(portId, passport, serial, status, exam)
	vRP.execute("characters/updatePort",{ user_id = passport, portId = portId, serial = serial, portType = status, exam = exam })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.deletePort(portId)
	vRP.execute("characters/deletePort",{ portId = portId })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECRIMINAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeCriminal(user_id,statusCriminal)
	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["criminal"] = parseInt(statusCriminal)
	end

	vRP.execute("characters/updateCriminal",{ criminal = statusCriminal, id = user_id })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEGARAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeGarage(user_id)
	vRP.execute("characters/updateGarages",{ id = user_id })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["garage"] = vRP.userInfos[user_id]["garage"] + 1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeChars(user_id)
	vRP.execute("accounts/infosUpdatechars",{ steam = vRP.userInfos[user_id]["steam"] })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["chars"] = vRP.userInfos[user_id]["chars"] + 1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userGemstone(steam)
	local infoAccount = vRP.infoAccount(steam)
	return infoAccount["gems"] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeGemstone(user_id,amount)
	vRP.execute("accounts/infosUpdategems",{ steam = vRP.userInfos[user_id]["steam"], gems = amount })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADENAMES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeNames(user_id,name,name2)
	vRP.execute("characters/updateName",{ name = name, name2 = name2, user_id = user_id })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["name2"] = name2
		vRP.userInfos[user_id]["name"] = name
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradePhone(user_id,phone)
	vRP.execute("characters/updatePhone",{ phone = phone, id = user_id })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["phone"] = phone
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeID(user_id)
	vRP.execute("characters/getUsers",{ id = user_id })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["id"] = id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userPlate(vehPlate)
	local rows = vRP.query("vehicles/plateVehicles",{ plate = vehPlate })
	return rows[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERBLOOD
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userBlood(bloodTypes)
	local rows = vRP.query("characters/getBlood",{ blood = bloodTypes })
	if rows[1] then
		return rows[1]["id"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userPhone(phoneNumber)
	local rows = vRP.query("characters/getPhone",{ phone = phoneNumber })
	return rows[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRINGNUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateStringNumber(format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""

	for i = 1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then
    		number = number..string.char(zbyte + math.random(0,9))
		elseif char == "L" then
			number = number..string.char(abyte + math.random(0,25))
		else
			number = number..char
		end
	end

	return number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generatePlate()
	local user_id = nil
	local vehPlate = ""

	repeat
		vehPlate = vRP.generateStringNumber("DDLLLDDD")
		user_id = vRP.userPlate(vehPlate)
	until not user_id

	return vehPlate
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generatePhone()
	local user_id = nil
	local phone = ""

	repeat
		phone = vRP.generateStringNumber("DDD-DDD")
		user_id = vRP.userPhone(phone)
	until not user_id

	return phone
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERSERIAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userSerial(number)
	local rows = vRP.query("characters/getSerial",{ serial = number })
	return rows[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEBLOODTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateBloodTypes(format)
	local zbyte = string.byte("0")
	local number = ""

	for i = 1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then
    		number = number..string.char(zbyte + math.random(1,4))
		else
			number = number..char
		end
	end

	return number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEBLOOD
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateBlood()
	local user_id = nil
	local blood = ""

	repeat
		blood = vRP.generateBloodTypes("D")
		user_id = vRP.userBlood(blood)
	until not user_id

	return blood
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESERIAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateSerial()
	local user_id = nil
	local serial = ""

	repeat
		serial = vRP.generateStringNumber("LLLDDD")
		user_id = vRP.userSerial(serial)
	until not user_id

	return serial
end