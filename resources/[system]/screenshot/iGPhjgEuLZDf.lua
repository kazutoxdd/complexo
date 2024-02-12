local Tunnel = module("vrp", "lib/Tunnel")
arc = Tunnel.getInterface("High_AC")

local ProhibitedVariables = { -- Add as many as you want from mod menus you find!
"fESX", "Plane", "TiagoMenu", "Outcasts666", "dexMenu", "Cience", "LynxEvo", "zzzt", "AKTeam",
"gaybuild", "ariesMenu", "WarMenu", "SwagMenu", "Dopamine", "Gatekeeper", "MIOddhwuie", "MagnataMenu", "FelipeMenu", "HydroMenu"
}

CreateThread(function()
    while true do
        Wait(1000)
        for i, v in pairs(ProhibitedVariables) do
            if _G[v] ~= nil then
                arc.banplayer("Variável do menu do mod\nInformações da variável: "..v.."")
            end
        end
        local DetectableTextures = {
			{txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu"},
			{txd = "mpmissmarkers256", txt = "mpmissmarkers256", name = "DrawFov"},
			{txd = "John", txt = "John2", name = "SugarMenu"},
			{txd = "darkside", txt = "logo", name = "Darkside"},
			{txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU"},
			{txd = "dopatest", txt = "duiTex", name = "Copypaste Menu"},
			{txd = "fm", txt = "menu_bg", name = "Fallout"},
			{txd = "wave", txt = "logo", name ="Wave"},
			{txd = "wave1", txt = "logo1", name = "Wave (alt.)"},
			{txd = "meow2", txt = "woof2", name ="Alokas66", x = 1000, y = 1000},
			{txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name ="Guest Menu"},
			{txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name="HugeV Menu"},
			{txd = "MM", txt = "menu_bg", name="MetrixFallout"},
			{txd = "MagnataMenu", txt = "MagnataMenu", name="MagnataMenu"},
			{txd = "FelipeMenu", txt = "FelipeMenu", name="FelipeMenu"},
			{txd = "MM", txt = "menu_bg", name="MetrixFallout"},
			{txd = "aries ~n~~r~MENU", txt = "aries ~n~~r~MENU", name="Aries Menu"},
			{txd = "wm", txt = "wm2", name="WM Menu"}
			
		}
		
		for i, data in pairs(DetectableTextures) do
			if data.x and data.y then
				if GetTextureResolution(data.txd, data.txt).x == data.x and GetTextureResolution(data.txd, data.txt).y == data.y then
					arc.banplayer("Hack Menu\nHack Info: "..data.name.."")
				end
			else 
				if GetTextureResolution(data.txd, data.txt).x ~= 4.0 then
					arc.banplayer("Hack Menu\nHack Info: "..data.name.."")
				end
			end
		end
    end
end)

AddEventHandler("onClientResourceStop", function(rsc)
	local source = source
	if source ~= 0 then
		if rsc == "Five Anticheat" then
			local source = source
			if source ~= 0 and source ~= -1 then
				arc.banplayer("Anticheat Stopado")
				CancelEvent()
			end
		end
	end
end)