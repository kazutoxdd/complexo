-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("lockpicking",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local done = false
local result = false
local running = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("cancel",function(data,cb)
	result = false
	done = true
	SetNuiFocus(false,false)
	cb("ok")
end)

RegisterNUICallback("fail",function(data,cb)
	result = false
	done = true
	SetNuiFocus(false,false)
	cb("ok")
end)

RegisterNUICallback("success",function(data,cb)
	result = true
	done = true
	SetNuiFocus(false,false)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INÍCIO
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tryLockpick()
	if not running then
		done = false
		result = false
		SendNUIMessage({start=true})
		SetNuiFocus(true,true)
		while not done do
			Wait(1)
		end
		running = false
	end
	return result
end