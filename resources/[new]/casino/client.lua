local inCasino = false
local spinningObject = nil
local spinningCar = nil
--local carOnShow = GetHashKey('teslaprior')

function IsTable(T)
	return type(T) == 'table'
end

function SetIplPropState(interiorId, props, state, refresh)
	if refresh == nil then refresh = false end
	if IsTable(interiorId) then
		for key, value in pairs(interiorId) do
			SetIplPropState(value, props, state, refresh)
		end
	else
		if IsTable(props) then
			for key, value in pairs(props) do
				SetIplPropState(interiorId, value, state, refresh)
			end
		else
			if state then
				if not IsInteriorPropEnabled(interiorId, props) then EnableInteriorProp(interiorId, props) end
			else
				if IsInteriorPropEnabled(interiorId, props) then DisableInteriorProp(interiorId, props) end
			end
		end
		if refresh == true then RefreshInterior(interiorId) end
	end
end
  
CreateThread(function()
	Wait(0)
	RequestIpl('vw_casino_main')
	RequestIpl('vw_dlc_casino_door')
	RequestIpl('hei_dlc_casino_door')
	RequestIpl("hei_dlc_windows_casino")
	RequestIpl("vw_casino_penthouse")
	SetIplPropState(274689, "Set_Pent_Tint_Shell", true, true)
	SetInteriorEntitySetColor(274689, "Set_Pent_Tint_Shell", 3)
	RequestIpl("hei_dlc_windows_casino_lod")
	RequestIpl("vw_casino_carpark")
	RequestIpl("vw_casino_garage")
	RequestIpl("hei_dlc_casino_aircon")
	RequestIpl("hei_dlc_casino_aircon_lod")
	RequestIpl("hei_dlc_casino_door")
	RequestIpl("hei_dlc_casino_door_lod")
	RequestIpl("hei_dlc_vw_roofdoors_locked")
	RequestIpl("vw_ch3_additions")
	RequestIpl("vw_ch3_additions_long_0")
	RequestIpl("vw_ch3_additions_strm_0")
	RequestIpl("vw_dlc_casino_door")
	RequestIpl("vw_dlc_casino_door_lod")
	RequestIpl("vw_casino_billboard")
	RequestIpl("vw_casino_billboard_lod(1)")
	RequestIpl("vw_casino_billboard_lod")
	RequestIpl("vw_int_placement_vw")
	RequestIpl("vw_dlc_casino_apart")
	
	local interiorID = GetInteriorAtCoords(1100.000, 220.000, -50.000)
	
	if IsValidInterior(interiorID) then
		RefreshInterior(interiorID)
	end
end)


--TELEPORT
key_to_teleport = 38

positions = {

	-- cassino main door
    {
		{935.8365, 46.94, 80.09, 0}, -- enter
		{1090.00, 207.00, -50.0, 358}, -- leave
		{205,89,0}, -- colour
	}, 
	
	-- casino to roof
	{
		{964.2912597, 58.9096641, 111.56, 52.36}, -- enter
		{1085.69, 214.83, -50.2, 308.88}, -- leave
		{205,89,0},
	},
	
	-- management to penthouse
	{
		{980.47, 56.66, 115.16, 51.23}, -- enter
		{1119.46, 262.92, -52.0, 348.51}, -- leave
		{205,89,0},
	},
	
	-- roof to penthouse
	{
		{967.2, 63.99, 111.55, 34.29}, -- enter
		{969.62, 63.14, 111.55, 238.44}, -- leave
		{205,89,0},
	},
}

local player = GetPlayerPed(-1)

CreateThread(function ()
    while true do
        Wait(1)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do
            teleport_text = location[4]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }
            Red = location[3][1]
            Green = location[3][2]
            Blue = location[3][3]

            DrawMarker(27, loc1.x, loc1.y, loc1.z+0.0, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, Red, Green, Blue, 0, 0, 0, 0, 1)
            DrawMarker(27, loc2.x, loc2.y, loc2.z+0.5, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, Red, Green, Blue, 0, 0, 0, 0, 1)

			if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then 
				drawNativeNotification('Pressione ~INPUT_PICKUP~ Para entrar')
                if IsControlJustReleased(1, key_to_teleport) then
					DoScreenFadeOut(500)
    				Wait(500)
                    SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
                    SetEntityHeading(player, loc2.heading)
					DoScreenFadeIn(500)
					enterCasino(false)
		            Wait(1)
			        enterCasino(true)
					scanned = true
					scanwait = 200
                end
			elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then
				drawNativeNotification('Pressione ~INPUT_PICKUP~ Para sair')
                if IsControlJustReleased(1, key_to_teleport) then
					DoScreenFadeOut(500)
    				Wait(500)
                    SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                    SetEntityHeading(player, loc1.heading)
					DoScreenFadeIn(500)
					enterCasino(false)
		            Wait(1)
			        enterCasino(false)
					scanned = false
					scanwait = 200
                end
            end            
        end
    end
end)

function drawNativeNotification(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

--END TELEPORT

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- END CAR FOR WINS

function enterCasino(pIsInCasino, pFromElevator, pCoords, pHeading)
	if pIsInCasino == inCasino then return end
	inCasino = pIsInCasino
	if DoesEntityExist(spinningCar) then
	  DeleteEntity(spinningCar)
	end
	Wait(500)
	spinMeRightRoundBaby()
	showDiamondsOnScreenBaby()
	playSomeBackgroundAudioBaby()
end
  
function spinMeRightRoundBaby()
	CreateThread(function()
	    while inCasino do
		if not spinningObject or spinningObject == 0 or not DoesEntityExist(spinningObject) then
		  spinningObject = GetClosestObjectOfType(1100.0, 220.0, -51.0, 10.0, -1561087446, 0, 0, 0)
		  drawCarForWins()
		end
		if spinningObject ~= nil and spinningObject ~= 0 then
		  local curHeading = GetEntityHeading(spinningObject)
		  local curHeadingCar = GetEntityHeading(spinningCar)
		  if curHeading >= 360 then
			curHeading = 0.0
			curHeadingCar = 0.0
		  elseif curHeading ~= curHeadingCar then
			curHeadingCar = curHeading
		  end
		  SetEntityHeading(spinningObject, curHeading + 0.075)
		  SetEntityHeading(spinningCar, curHeadingCar + 0.075)
		end
		Wait(0)
	  end
	  spinningObject = nil
	end)
end
  
-- Casino Screens
local Playlists = {
	"CASINO_DIA_PL", -- diamonds
	"CASINO_SNWFLK_PL", -- snowflakes
	"CASINO_WIN_PL", -- win
	"CASINO_HLW_PL", -- skull
}
 
-- Render
function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
  
	return handle
end

-- render tv 
function showDiamondsOnScreenBaby()
	CreateThread(function()
	  local model = GetHashKey("vw_vwint01_video_overlay")
	  local timeout = 21085 -- 5000 / 255
  
	  local handle = CreateNamedRenderTargetForModel("CasinoScreen_01", model)
  
	  RegisterScriptWithAudio(0)
	  SetTvChannel(-1)
	  SetTvVolume(0)
	  SetScriptGfxDrawOrder(4)
	  SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
	  SetTvChannel(2)
	  EnableMovieSubtitles(1)
  
	function doAlpha()
		SetTimeout(timeout, function()
		SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
		SetTvChannel(2)
		doAlpha()
		end)
	end
	doAlpha()
  
	CreateThread(function()
	while inCasino do
	  SetTextRenderId(handle)
	  DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
	  SetTextRenderId(GetDefaultScriptRendertargetRenderId())
	  Wait(0)
	end
	SetTvChannel(-1)
	ReleaseNamedRendertarget(GetHashKey("CasinoScreen_01"))
	SetTextRenderId(GetDefaultScriptRendertargetRenderId())
	end)
   end)
end
  
function playSomeBackgroundAudioBaby()
	CreateThread(function()
	  local function audioBanks()
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", false, -1) do
		  Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", false, -1) do
		  Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", false, -1) do
		  Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", false, -1) do
		  Wait(0)
		end
	  end
	  audioBanks()
	  while inCasino do
		if not IsStreamPlaying() and LoadStream("casino_walla", "DLC_VW_Casino_Interior_Sounds") then
		  PlayStreamFromPosition(1111, 230, -47)
		end
		if IsStreamPlaying() and not IsAudioSceneActive("DLC_VW_Casino_General") then
		  StartAudioScene("DLC_VW_Casino_General")
		end
		Wait(1000)
	  end
	  if IsStreamPlaying() then
		StopStream()
	  end
	  if IsAudioSceneActive("DLC_VW_Casino_General") then
		StopAudioScene("DLC_VW_Casino_General")
	  end
	end)
end