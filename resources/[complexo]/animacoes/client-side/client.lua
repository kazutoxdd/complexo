-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_min = 5.0
local fov_max = 70.0
local cameras = false
local binoculos = false
local tratamento = false
local fov = (fov_max + fov_min) * 0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLEDANCES
-----------------------------------------------------------------------------------------------------------------------------------------
local poleDances = {
	{ 108.98,-1289.45,29.25,252.29 },
	{ 102.40,-1290.06,29.25,320.32 },
	{ 104.95,-1294.35,29.25,323.15 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	{ 1631638868,0.0,0.0 },
	{ 2117668672,0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 },
	{ `shmann_ehos_resbed01`,0.0,90.0 },
	{ `shmann_ehos_resbed02`,0.0,90.0 },
	{ `shmann_ehos_resbed03`,0.0,0.0 },
	{ `shmann_ehos_bed05`,0.0,0.0 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local animacoes = {
	["pneu"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "imp_prop_impexp_tyre_01a", flag = 49, mao = 28422, altura = -0.02, pos1 = -0.1, pos2 = 0.2, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["bong"] = { dict = "anim@safehouse@bong", anim = "bong_stage1", prop = "prop_bong_01", flag = 49, mao = 18905, altura = 0.10, pos1 = -0.25, pos2 = 0.0, pos3 = 95.0, pos4 = 190.0, pos5 = 180.0 },
	["mic"] = { dict = "missfra1", anim = "mcs2_crew_idle_m_boom", prop = "prop_v_bmike_01", flag = 50, mao = 28422, altura = -0.08, pos1 = 0.0, pos2 = 0.0, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["mic2"] = { dict = "missmic4premiere", anim = "interview_short_lazlow", prop = "p_ing_microphonel_01", flag = 50, mao = 28422 },
	["mic3"] = { dict = "anim@random@shop_clothes@watches", anim = "base", prop = "p_ing_microphonel_01", flag = 49, mao = 60309, altura = 0.10, pos1 = 0.04, pos2 = 0.012, pos3 = -60.0, pos4 = 60.0, pos5 = -30.0 },
	["megaphone"] = { dict = "anim@random@shop_clothes@watches", anim = "base", prop = "prop_megaphone_01", flag = 49, mao = 60309, altura = 0.10, pos1 = 0.04, pos2 = 0.012, pos3 = -60.0, pos4 = 100.0, pos5 = -30.0 },
	["livro"] = { dict = "cellphone@", anim = "cellphone_text_read_base", prop = "prop_novel_01", flag = 49, mao = 6286, altura = 0.15, pos1 = 0.03, pos2 = -0.065, pos3 = 0.0, pos4 = 180.0, pos5 = 90.0 },
	["radio2"] = { prop = "prop_boombox_01", flag = 50, mao = 57005, altura = 0.30, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa"] = { prop = "prop_ld_case_01", flag = 50, mao = 57005, altura = 0.16, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa2"] = { prop = "prop_ld_case_01_s", flag = 50, mao = 57005, altura = 0.16, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa3"] = { prop = "prop_security_case_01", flag = 50, mao = 57005, altura = 0.16, pos1 = 0, pos2 = -0.01, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa4"] = { prop = "w_am_case", flag = 50, mao = 57005, altura = 0.08, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa5"] = { prop = "xm_prop_smug_crate_s_medical", flag = 50, mao = 57005, altura = 0.32, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["caixa2"] = { prop = "prop_tool_box_04", flag = 50, mao = 57005, altura = 0.45, pos1 = 0, pos2 = 0.05, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["lixo"] = { prop = "prop_cs_rub_binbag_01", flag = 50, mao = 57005, altura = 0.11, pos1 = 0, pos2 = 0.0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["prebeber"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "p_amb_coffeecup_01", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["prebeber2"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "prop_ld_flow_bottle", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["prebeber3"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "prop_cs_bs_cup", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.10, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["prebeber4"] = { dict = "anim@heists@humane_labs@finale@keycards", anim = "ped_a_enter_loop", prop = "prop_drink_champ", flag = 49, mao = 18905, altura = 0.10, pos1 = -0.05, pos2 = 0.03, pos3 = -100.0, pos4 = 0.0, pos5 = -10.0 },
	["verificar"] = { dict = "amb@medic@standing@tendtodead@idle_a", anim = "idle_a", andar = false, loop = true },
	["mexer"] = { dict = "amb@prop_human_parking_meter@female@idle_a", anim = "idle_a_female", andar = true, loop = true },
	["cuidar"] = { dict = "mini@cpr@char_a@cpr_str", anim = "cpr_pumpchest", andar = true, loop = true },
	["cuidar2"] = { dict = "mini@cpr@char_a@cpr_str", anim = "cpr_kol", andar = true, loop = true },
	["cuidar3"] = { dict = "mini@cpr@char_a@cpr_str", anim = "cpr_kol_idle", andar = true, loop = true },
	["cansado"] = { dict = "rcmbarry", anim = "idle_d", andar = false, loop = true },
	["alongar2"] = { dict = "mini@triathlon", anim = "idle_e", andar = false, loop = true },
	["poledance"] = { dict = "mini@strip_club@pole_dance@pole_dance1", anim = "pd_dance_01", andar = false, loop = true, extra = function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(poleDances) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance <= 1 then
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3] - 1,1,0,0,0)
				break
			end
		end
	end },
	["poledance2"] = { dict = "mini@strip_club@pole_dance@pole_dance2", anim = "pd_dance_02", andar = false, loop = true, extra = function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(poleDances) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance <= 1 then
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3] - 1,1,0,0,0)
				break
			end
		end
	end },
	["poledance3"] = { dict = "mini@strip_club@pole_dance@pole_dance3", anim = "pd_dance_03", andar = false, loop = true, extra = function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(poleDances) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance <= 1 then
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3] - 1,1,0,0,0)
				break
			end
		end
	end },
	["meleca"] = { dict = "anim@mp_player_intuppernose_pick", anim = "idle_a", andar = true, loop = true },
	["bora"] = { dict = "missfam4", anim = "say_hurry_up_a_trevor", andar = true, loop = false },
	["limpar"] = { dict = "missfbi3_camcrew", anim = "final_loop_guy", andar = true, loop = false },
	["galinha"] = { dict = "random@peyote@chicken", anim = "wakeup", andar = true, loop = true },
	["amem"] = { dict = "rcmepsilonism8", anim = "worship_base", andar = true, loop = true },
	["nervoso"] = { dict = "rcmme_tracey1", anim = "nervous_loop", andar = true, loop = true },
	["ajoelhar"] = { dict = "amb@medic@standing@kneel@idle_a", anim = "idle_a", andar = false, loop = true },
	["sinalizar"] = { dict = "amb@world_human_car_park_attendant@male@base", anim = "base", prop = "prop_parking_wand_01", flag = 49, mao = 28422 },
	["placa"] = { dict = "amb@world_human_bum_freeway@male@base", anim = "base", prop = "prop_beggers_sign_01", flag = 49, mao = 28422 },
	["placa2"] = { dict = "amb@world_human_bum_freeway@male@base", anim = "base", prop = "prop_beggers_sign_03", flag = 49, mao = 28422 },
	["placa3"] = { dict = "amb@world_human_bum_freeway@male@base", anim = "base", prop = "prop_beggers_sign_04", flag = 49, mao = 28422 },
	["abanar"] = { dict = "timetable@amanda@facemask@base", anim = "base", andar = true, loop = true },
	["cocada"] = { dict = "mp_player_int_upperarse_pick", anim = "mp_player_int_arse_pick", andar = true, loop = true },
	["cocada2"] = { dict = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch", andar = true, loop = true },
	["lero"] = { dict = "anim@mp_player_intselfiejazz_hands", anim = "idle_a", andar = true, loop = false },
	["dj2"] = { dict = "anim@mp_player_intupperair_synth", anim = "idle_a_fp", andar = false, loop = true },
	["beijo"] = { dict = "anim@mp_player_intselfieblow_kiss", anim = "exit", andar = true, loop = false },
	["malicia"] = { dict = "anim@mp_player_intupperdock", anim = "idle_a", andar = true, loop = false },
	["ligar"] = { dict = "cellphone@", anim = "cellphone_call_in", prop = "prop_npc_phone_02", flag = 50, mao = 28422 },
	["radio"] = { dict = "cellphone@", anim = "cellphone_call_in", prop = "prop_cs_hand_radio", flag = 50, mao = 28422 },
	["cafe"] = { dict = "amb@world_human_aa_coffee@base", anim = "base", prop = "p_amb_coffeecup_01", flag = 50, mao = 28422 },
	["cafe2"] = { dict = "amb@world_human_aa_coffee@idle_a", anim = "idle_a", prop = "p_amb_coffeecup_01", flag = 49, mao = 28422 },
	["cafe3"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "p_amb_coffeecup_01", flag = 49, mao = 28422 },
	["caixa"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "hei_prop_heist_box", flag = 50, mao = 28422 },
	["caixaarma"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "ba_prop_battle_rsply_crate_gr_02a", flag = 50, mao = 28422, altura = 0.0, pos1 = -0.12, pos2 = 0.03, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["caixa3"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "xm_prop_smug_crate_s_medical", flag = 50, mao = 28422 },
	["caixaprime"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "caixavg", flag = 50, mao = 28422 },

	["televisao"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_tv_flat_03", flag = 50, mao = 28422 },
	
	["aocpack"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "aoc_box08", flag = 50, mao = 28422, altura = 0.0, pos1 = -0.10, pos2 = -0.17, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },

	["caixapizza"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_pizza_box_02", flag = 50, mao = 28422, altura = 0.0, pos1 = -0.12, pos2 = -0.17, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["katchup"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "v_ret_247_ketchup2", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },

	["bandeja"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_food_tray_01", flag = 50, mao = 28422, altura = 0.0, pos1 = -0.10, pos2 = -0.17, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["bandeja2"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_food_tray_02", flag = 50, mao = 28422, altura = 0.0, pos1 = -0.10, pos2 = -0.17, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["bandeja3"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_food_tray_03", flag = 50, mao = 28422, altura = 0.0, pos1 = -0.10, pos2 = -0.17, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["bandeja4"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_food_cb_tray_01", flag = 50, mao = 28422, altura = 0.0, pos1 = -0.10, pos2 = -0.17, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["bandeja5"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_food_cb_tray_02", flag = 50, mao = 28422, altura = 0.0, pos1 = -0.10, pos2 = -0.17, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["bandeja6"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "prop_food_cb_tray_03", flag = 50, mao = 28422, altura = 0.0, pos1 = -0.10, pos2 = -0.17, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["hosp"] = { dict = "anim@amb@clubhouse@bar@drink@idle_a", anim = "idle_a_bartender", prop = "v_med_bed2", flag = 50, mao = 28422, altura = -0.42, pos1 = -1.15, pos2 = -0.65, pos3 = 3.8, pos4 = 7.5, pos5 = -37.5 },
--	["srthulium"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "v_res_d_dildo_f", flag = 49, mao = 28422, altura = 0.0, pos1 = -0.05, pos2 = -0.07, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["maconha"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "bkr_prop_weed_med_01a", flag = 50, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.40, pos3 = 20.0, pos4 = 0.0, pos5 = 0.0 },
	["placapaulo"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "placa_paulinholoco", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 180.0 },
-- COPA
	["hino"] = { dict = "hinobrasil", anim = "brasil", andar = false, loop = true },

--  PAULO
	["fazox2"] = { dict = "asking@animx", anim = "animx", andar = true, loop = true },
	["paulo"] = { dict = "asking@paulo", anim = "paulo", andar = true, loop = true },
	["fazox"] = { dict = "asking@x", anim = "x", andar = true, loop = true },
-- NOVAS ANIMAÇÕES
	["cupscpx"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "cupscpx", flag = 49, mao = 28422 },
	["cupscpx2"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "cupscpx2", flag = 49, mao = 28422 },
	["cupscpx3"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "cupscpx3", flag = 49, mao = 28422 },
	["cupscpx4"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "cupscpx4", flag = 49, mao = 28422 },
	["melancia2"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "melanciabkn", flag = 49, hand = 28422 },
	["picole"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "picolebkn", flag = 49, hand = 28422 },
	["pose1"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose1", andar = false, loop = true },
	["pose2"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose10", andar = false, loop = true },
	["pose3"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose2", andar = false, loop = true },
	["pose4"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose3", andar = false, loop = true },
	["pose5"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose4", andar = false, loop = true },
	["pose6"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose5", andar = false, loop = true },
	["pose7"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose6", andar = false, loop = true },
	["pose8"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose7", andar = false, loop = true },
	["pose9"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose8", andar = false, loop = true },
	["pose10"] = { dict = "penguin_mppos@pose_model", anim = "penguin_mppos_pose9", andar = false, loop = true },
	["pose11"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_pose1", andar = false, loop = true },
	["pose12"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_pose2", andar = false, loop = true },
	["pose13"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_pose3", andar = false, loop = true },
	["pose14"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_pose4", andar = false, loop = true },
	["pose15"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_pose5", andar = false, loop = true },
	["pose16"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_pose6", andar = false, loop = true },
	["pose17"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_pose7", andar = false, loop = true },
	["pose18"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_pose8", andar = false, loop = true },
	["pose19"] = { dict = "penguin_mppos@custom@v5", anim = "penguin_mppos_pose1_v5", andar = false, loop = true },
	["pose20"] = { dict = "penguin_mppos@custom@v5", anim = "penguin_mppos_pose10_v5", andar = false, loop = true },
	["pose21"] = { dict = "penguin_mppos@custom@v5", anim = "penguin_mppos_pose2_v5", andar = false, loop = true },
	["pose22"] = { dict = "penguin_mppos@custom@v5", anim = "penguin_mppos_pose3_v5", andar = false, loop = true },
	["pose23"] = { dict = "penguin_mppos@custom@v5", anim = "penguin_mppos_pose4_v5", andar = false, loop = true },
	["pose24"] = { dict = "penguin_mppos@custom@v5", anim = "penguin_mppos_pose6_v5", andar = false, loop = true },
	["pose25"] = { dict = "penguin_mppos@custom@v5", anim = "penguin_mppos_pose7_v5", andar = false, loop = true },
	["pose26"] = { dict = "penguin_mppos@custom@v5", anim = "penguin_mppos_pose8_v5", andar = false, loop = true },
	["pose27"] = { dict = "penguin_mppos@custom@v5", anim = "penguin_mppos_pose9_v5", andar = false, loop = true },
	["pose28"] = { dict = "penguin@custom@v1", anim = "penguin_2_fingers_up", andar = false, loop = true },
	["pose29"] = { dict = "penguin@custom@v1", anim = "penguin_carry_m_box", andar = true, loop = true },
	["pose30"] = { dict = "penguin@custom@v1", anim = "penguin_hold_the_cheek", andar = true, loop = true },
	["pose31"] = { dict = "penguin@custom@v1", anim = "penguin_pok_cheek", andar = true, loop = true },
	["pose32"] = { dict = "penguin@custom@v1", anim = "penguin_pose", andar = true, loop = true },
	["pose33"] = { dict = "penguin@custom@v1", anim = "penguin_pose10", andar = true, loop = true },
	["pose34"] = { dict = "penguin@custom@v1", anim = "penguin_pose2", andar = true, loop = true },
	["pose35"] = { dict = "penguin@custom@v1", anim = "penguin_pose3", andar = true, loop = true },
	["pose36"] = { dict = "penguin@custom@v1", anim = "penguin_pose4", andar = true, loop = true },
	["pose37"] = { dict = "penguin@custom@v1", anim = "penguin_pose5", andar = true, loop = true },
	["pose38"] = { dict = "penguin@custom@v1", anim = "penguin_pose6", andar = true, loop = true },
	["pose39"] = { dict = "penguin@custom@v1", anim = "penguin_pose7", andar = true, loop = true },
	["pose40"] = { dict = "penguin@custom@v1", anim = "penguin_pose8", andar = true, loop = true },
	["pose41"] = { dict = "penguin@custom@v1", anim = "penguin_pose9", andar = true, loop = true },
	["pose42"] = { dict = "penguin@custom@v1", anim = "penguin_standpickpocket", andar = true, loop = true },
	["pose43"] = { dict = "penguin@custom@v1", anim = "penguinhead", andar = true, loop = true },
	["pose44"] = { dict = "penguin@custom@v1", anim = "penguinlove", andar = true, loop = true },
	["dab"] = { dict = "penguin@custom@v1", anim = "penguin_dab", andar = false, loop = true },
	["dab2"] = { dict = "penguin@custom@v1", anim = "penguin_dab1", andar = false, loop = true },
	["posef1"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_duo1_f", andar = false, loop = true },
	["posem1"] = { dict = "penguin_mppos@custom@v4", anim = "penguin_mppos_v4_duo1_m", andar = false, loop = true },
	["posef2"] = { dict = "penguin@custom@v1", anim = "penguin_carry_f", andar = false, loop = true },
	["posem2"] = { dict = "penguin@custom@v1", anim = "penguin_carry_m", andar = false, loop = true },
	["unhas"] = { dict = "anim@amb@clubhouse@bar@drink@idle_a", anim = "idle_a_bartender", andar = true, loop = true },
	["cruzar7"] = { dict = "move_m@hiking", anim = "idle", andar = true, loop = true },
	["cruzar8"] = { dict = "anim@amb@casino@valet_scenario@pose_d@", anim = "base_a_m_y_vinewood_01", andar = true, loop = true },
	["cruzar9"] = { dict = "anim@amb@casino@shop@ped_female@01a@base", anim = "base", andar = true, loop = true },
	["cruzar10"] = { dict = "anim@amb@casino@valet_scenario@pose_c@", anim = "shuffle_feet_a_m_y_vinewood_01", andar = true, loop = true },
	["cruzar11"] = { dict = "anim@amb@casino@hangout@ped_male@stand@03a@idles_convo", anim = "idle_a", andar = true, loop = true },
	["tchau"] = { dict = "anim@mp_player_intupperwave", anim = "idle_a", andar = true, loop = true },
	["lanca"] = { dict = "amb@incar@male@smoking@enter", anim = "enter", prop = "mah_lanca", flag = 49, mao = 28422 },
	["lancab"] = { dict = "amb@incar@male@smoking@enter", anim = "enter", prop = "mah_lanca_02", flag = 49, mao = 28422 },
	["foto"] = { dict = "amb@lo_res_idles@" , anim ="world_human_lean_male_hands_together_lo_res_base" , andar = false , loop = true },
	["foto1"] = { dict = "amb@code_human_cross_road@female@base" , anim ="base" , andar = false , loop = true },
	["foto2"] = { dict = "amb@code_human_in_car_mp_actions@tit_squeeze@bodhi@rps@base" , anim ="idle_a" , andar = false , loop = true },
	["foto3"] = { dict = "amb@world_human_hang_out_street@female_arm_side@enter" , anim ="enter" , andar = false , loop = true },
	["foto4"] = { dict = "amb@world_human_hang_out_street@female_arm_side@idle_a" , anim ="idle_b" , andar = false , loop = true },
	["foto5"] = { dict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a" , anim ="idle_b" , andar = false , loop = true },
	["foto6"] = { dict = "friends@" , anim ="pickupwait" , andar = false , loop = true },
	["foto7"] = { dict = "mini@hookers_sp" , anim ="idle_reject_loop_a" , andar = false , loop = true },
	["foto8"] = { dict = "misscarsteal2" , anim ="sweep_high" , andar = false , loop = true },
	["foto9"] = { dict = "missheist_agency3aig_23" , anim ="urinal_base" , andar = false , loop = true },
	["foto10"] = { dict = "misstrevor2ron_basic_moves" , anim ="idle" , andar = false , loop = true },
	["foto11"] = { dict = "oddjobs@basejump@" , anim ="ped_a_loop" , andar = false , loop = true },
	["foto12"] = { dict = "rcmjosh1" , anim ="idle" , andar = false , loop = true },
	["foto13"] = { dict = "switch@franklin@plays_w_dog" , anim ="001916_01_fras_v2_9_plays_w_dog_idle" , andar = false , loop = true },
	["foto14"] = { dict = "timetable@amanda@ig_9" , anim ="ig_9_base_amanda" , andar = false , loop = true },
	["foto15"] = { dict = "misscommon@response" , anim ="bring_it_on" , andar = false , loop = true },
	["foto16"] = { dict = "cover@first_person@move@base@core" , anim ="low_idle_l_facecover" , andar = false , loop = true },
	["foto17"] = { dict = "cover@weapon@core" , anim ="idle_turn_stop" , andar = false , loop = true },
	["foto18"] = { dict = "anim@amb@casino@hangout@ped_female@stand@02b@base" , anim ="base" , andar = false , loop = true },
	["foto19"] = { dict = "anim@amb@casino@hangout@ped_male@stand@01a@base" , anim ="base" , andar = false , loop = true },
	["foto20"] = { dict = "anim@amb@casino@out_of_money@ped_male@01b@base" , anim ="base" , andar = false , loop = true },
	["foto21"] = { dict = "anim@amb@casino@shop@ped_female@01a@base" , anim ="base" , andar = false , loop = true },
	["foto22"] = { dict = "anim@mp_corona_idles@female_c@base" , anim ="base" , andar = false , loop = true },
	["foto23"] = { dict = "anim@random@shop_clothes@watches" , anim ="base" , andar = false , loop = true },
	["foto24"] = { dict = "iaa_int-11" , anim ="csb_avon_dual-11" , andar = false , loop = true },
	["foto25"] = { dict = "mini@strip_club@lap_dance@ld_girl_a_approach" , anim ="ld_girl_a_approach_f" , andar = false , loop = true },
	["foto26"] = { dict = "amb@code_human_in_car_mp_actions@rock@bodhi@rps@base" , anim ="idle_a" , andar = false , loop = true },
	["foto27"] = { dict = "mini@hookers_spcrackhead" , anim ="idle_reject_loop_c" , andar = false , loop = true },
	["foto28"] = { dict = "anim@mp_player_intupperfinger" , anim ="idle_a" , andar = false , loop = true },
	["foto29"] = { dict = "switch@franklin@lamar_tagging_wall" , anim ="lamar_tagging_wall_loop_franklin" , andar = false , loop = true },
	["foto30"] = { dict = "mp_move@prostitute@m@cokehead" , anim ="idle" , andar = false , loop = true },
	["foto31"] = { dict = "anim@amb@casino@valet_scenario@pose_c@" , anim ="base_a_m_y_vinewood_01" , andar = false , loop = true },
	["foto32"] = { dict = "anim@amb@casino@valet_scenario@pose_d@" , anim ="look_ahead_l_a_m_y_vinewood_01" , andar = false , loop = true },
	["foto33"] = { dict = "anim@special_peds@casino@beth@wheel@" , anim ="action10_beth" , andar = false , loop = true },
	["foto34"] = { dict = "anim@special_peds@casino@beth@wheel@" , anim ="action2_beth" , andar = false , loop = true },
	["foto35"] = { dict = "anim@mp_player_intcelebrationfemale@v_sign" , anim ="v_sign" , andar = false , loop = true },
	["foto36"] = { dict = "mini@strip_club@idles@stripper" , anim ="stripper_idle_03" , andar = false , loop = true },
	["foto37"] = { dict = "mini@strip_club@idles@stripper" , anim ="stripper_idle_04" , andar = false , loop = true },
	["foto38"] = { dict = "anim_heist@arcade@fortune@female@" , anim ="reaction_pondering" , andar = false , loop = true },
	["foto39"] = { dict = "anim@mp_player_intcelebrationfemale@peace" , anim ="peace" , andar = false , loop = true },
	["foto40"] = { dict = "missfbi3_party_d" , anim ="stand_talk_loop_b_female" , andar = false , loop = true },
	["foto41"] = { dict = "armenian_1_int-44" , anim ="a_m_y_musclbeac_01^1_dual-44" , andar = false , loop = true },
	["foto42"] = { dict = "mp_clothing@female@trousers" , anim ="try_trousers_positive_a" , andar = false , loop = true },
	["foto43"] = { dict = "silj_ext-19" , anim ="mp_m_freemode_01^3_dual-19" , andar = false , loop = true },
	["foto44"] = { dict = "sdrm_mcs_2-0" , anim ="ig_bestmen^1-0" , andar = false , loop = true },
	["foto45"] = { dict = "anim_heist@arcade_combined@" , anim ="ped_female@_stand@_02a@_idles_convo_idle_c" , andar = false , loop = true },
	["foto46"] = { dict = "anim@arena@celeb@flat@solo@no_props@" , anim ="thumbs_down_a_player_a" , andar = false , loop = true },
	["foto47"] = { dict = "guard_reactions" , anim ="1hand_aiming_cycle" , andar = false , loop = true },
	["foto48"] = { dict = "anim@move_f@waitress" , anim ="idle" , andar = false , loop = true },
	["foto49"] = { dict = "anim_heist@arcade_combined@" , anim ="ped_female@_stand_withdrink@_01b@_base_base" , andar = false , loop = true },
	["foto50"] = { dict = "amb@lo_res_idles@" , anim ="world_human_security_shine_torch_lo_res_base" , andar = false , loop = true },
	["foto51"] = { dict = "rcmjosh2" , anim ="stand_lean_back_beckon_a" , andar = false , loop = true },
	["foto52"] = { dict = "rcmjosh2" , anim ="stand_lean_back_beckon_b" , andar = false , loop = true },
	["foto53"] = { dict = "pro_mcs_7_concat-1" , anim ="cs_priest_dual-1" , andar = false , loop = true },
	["foto54"] = { dict = "clothingshirt" , anim ="try_shirt_base" , andar = false , loop = true },
	["foto55"] = { dict = "special_ped@pamela@trevor_1@trevor_1a" , anim ="pamela_convo_trevor_im_trying_to_get_noticed_0" , andar = false , loop = true },
	["foto56"] = { dict = "special_ped@impotent_rage@intro" , anim ="idle_intro" , andar = false , loop = true },
	["foto57"] = { dict = "random@escape_paparazzi@standing@" , anim ="idle" , andar = false , loop = true },
	["foto58"] = { dict = "pro_mcs_7_concat-8" , anim ="player_two_dual-8" , andar = false , loop = true },
	["foto59"] = { dict = "anim@heists@ornate_bank@thermal_charge" , anim ="cover_eyes_loop" , andar = false , loop = true },
	["foto60"] = { dict = "low_fun_int-7" , anim ="cs_lamardavis_dual-7" , andar = false , loop = true },
	["foto61"] = { dict = "tale_intro-12" , anim ="a_f_y_genhot_01^2_dual-12" , andar = false , loop = true },
	["foto62"] = { dict = "amb@code_human_police_investigate@base" , anim ="base" , andar = false , loop = true },
	["foto63"] = { dict = "anim@mp_player_intincarpeacebodhi@ds@" , anim ="enter" , andar = false , loop = true },
	["foto64"] = { dict = "anim@mp_corona_idles@female_c@idle_a" , anim ="idle_a" , andar = false , loop = true },
	["foto65"] = { dict = "anim@miss@low@fin@vagos@" , anim ="idle_ped07" , andar = false , loop = true },
	["foto66"] = { dict = "oddjobs@assassinate@multi@" , anim ="idle_a_pros" , andar = false , loop = true },
	["foto67"] = { dict = "timetable@jimmy@ig_5@base" , anim ="base" , andar = false , loop = true },
	["foto68"] = { dict = "rcmnigel1bnmt_1b" , anim ="base_tyler" , andar = false , loop = true },
	["foto69"] = { dict = "mp_fm_intro_cut" , anim ="world_human_standing_male_01_idle_03" , andar = false , loop = true },
	["foto70"] = { dict = "mic_4_int-0" , anim ="a_f_y_bevhills_04-0" , andar = false , loop = true },
	["foto71"] = { dict = "mic_4_int-0" , anim ="cs_milton_dual-0" , andar = false , loop = true },
	["foto72"] = { dict = "cellphone@self@franklin@" , anim ="west_coast" , andar = false , loop = true },
	["foto73"] = { dict = "anim@random@shop_clothes@watches" , anim ="idle_d" , andar = false , loop = true },
	["foto74"] = { dict = "amb@world_human_muscle_flex@arms_in_front@idle_a" , anim ="idle_b" , andar = false , loop = true },
	["foto75"] = { dict = "amb@world_human_prostitute@crackhooker@idle_a" , anim ="idle_c" , andar = false , loop = true },
	["foto76"] = { dict = "amb@world_human_prostitute@hooker@base" , anim ="base" , andar = false , loop = true },
	["foto77"] = { dict = "anim@mp_player_intupperfinger" , anim ="idle_a" , andar = false , loop = true },
	["foto78"] = { dict = "anim@mp_player_intcelebrationmale@blow_kiss" , anim ="blow_kiss" , andar = false , loop = true },
	["foto79"] = { dict = "anim@mp_player_intcelebrationmale@knuckle_crunch" , anim ="knuckle_crunch" , andar = false , loop = true },
	["foto80"] = { dict = "anim@mp_player_intupperthumbs_up" , anim ="idle_a_fp" , andar = false , loop = true },
	["foto81"] = { dict = "switch@michael@prostitute" , anim ="exit_hooker" , andar = false , loop = true },
	["foto82"] = { dict = "mp_player_int_upperbro_love" , anim ="mp_player_int_bro_love_fp" , andar = false , loop = true },
	["foto83"] = { dict = "hs3_arc_int-9" , anim ="csb_georginacheng_dual-9" , andar = false , loop = true },
	["foto84"] = { dict = "armenian_1_int-0" , anim ="a_f_y_beach_01_dual-0" , andar = false , loop = true },
	["foto85"] = { dict = "armenian_1_int-0" , anim ="a_f_y_hipster_02^2-0" , andar = false , loop = true },
	["foto86"] = { dict = "armenian_1_int-0" , anim ="a_f_y_tourist_01^2-0" , andar = false , loop = true },
	["foto87"] = { dict = "armenian_1_int-0" , anim ="a_m_y_beach_03-0" , andar = false , loop = true },
	["foto88"] = { dict = "special_ped@pamela@base" , anim ="base" , andar = false , loop = true },
	["foto89"] = { dict = "mp_fm_intro_cut" , anim ="world_human_standing_male_01_idle_01" , andar = false , loop = true },
	["foto90"] = { dict = "amb@world_human_leaning@female@smoke@base" , anim ="base" , andar = false , loop = true },
	["foto91"] = { dict = "amb@world_human_leaning@female@wall@back@hand_up@base" , anim ="base" , andar = false , loop = true },
	["foto92"] = { dict = "amb@code_human_cross_road@female@base" , anim = "base" , andar = false , loop = true },
	["foto93"] = { dict = "anim@heists@heist_corona@single_team" , anim = "single_team_intro_boss" , andar = false , loop = true },
	["foto94"] = { dict = "amb@incar@male@smoking@idle_a" , anim = "idle_b" , andar = false , loop = true },
	["foto95"] = { anim = "idle_a" , dict  = "anim@amb@casino@hangout@ped_male@stand@02b@idles" , andar = false , loop = true },
	["foto96"] = { anim = "rub_neck_a_m_y_vinewood_01" , dict  = "anim@amb@casino@valet_scenario@pose_c@" , andar = false , loop = true },
	["foto97"] = { dict = "anim@mp_player_intuppershush" , anim = "idle_a_fp" , andar = false , loop = true },
	["foto98"] = { anim = "_car_a_flirt_girl" , dict  = "random@street_race" , andar = false , loop = true },
	["foto99"] = { dict = "misshair_shop@barbers" , anim = "keeper_base" , andar = false , loop = true },
	["foto100"] = {  dict = "cellphone@self@franklin@" , anim = "chest_bump" , andar = false , loop = true },
	["foto101"] = {  dict = "amb@world_human_leaning@male@wall@back@foot_up@aggro_react" , anim = "aggro_react_forward_enter", andar = false , loop = true },
	["foto102"] = {  dict = "martin_1_int-0" , anim = "cs_patricia_dual-0" , andar = false , loop = true },
	["foto103"] = {  dict = "mini@strip_club@lap_dance_2g@ld_2g_decline" , anim = "ld_2g_decline_h_s2" , andar = false , loop = true },
	["foto104"] = {  anim = "stripper_idle_03" , dict  = "mini@strip_club@idles@stripper" , andar = false , loop = true },
	["foto105"] = {  dict = "amb@world_human_binoculars@male@base" , anim ="base" , andar = false , loop = true },
	["foto106"] = {  dict = "amb@world_human_tourist_mobile@male@base" , anim ="base" , andar = false , loop = true },
	["foto107"] = {  dict = "anim@amb@board_room@whiteboard@" , anim ="read_03_amy_skater_01" , andar = false , loop = true },
	["foto108"] = {  dict = "anim@heists@team_respawn@variations@variation_b_rot" , anim ="respawn_b_ped_c" , andar = false , loop = true },
	["foto109"] = {  anim = "idle_d" , dict  = "anim@amb@casino@hangout@ped_female@stand@01a@idles" , andar = false , loop = true },
	["foto110"] = {  dict = "amb@world_human_stand_guard@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	["foto111"] = {  dict = "amb@world_human_tourist_mobile@male@base" , anim = "base" , andar = false , loop = true },
	["foto112"] = {  dict = "switch@michael@pharmacy" , anim = "mics1_ig_11_loop" , andar = false , loop = true },
	["foto113"] = {  dict = "weapons@first_person@aim_idle@p_m_one@unarmed@fidgets@c" , anim = "fidget_low_loop" , andar = false , loop = true },
	["foto114"] = {  dict = "armenian_1_int-0" , anim = "player_one_dual-0" , andar = false , loop = true },
	["foto115"] = {  dict = "amb@world_human_bum_wash@male@low@idle_a" , anim = "idle_a" , andar = false , loop = true },
	["foto116"] = {  dict = "anim@amb@casino@hangout@ped_male@stand_withdrink@01b@base" , anim = "base" , andar = false , loop = true },
	["foto117"] = {  dict = "anim@move_m@trash_rc" , anim = "aim_high_loop" , andar = false , loop = true },
	["foto118"] = {  dict = "martin_1_int-10" , anim = "cs_patricia_dual-10" , andar = false , loop = true },
	["foto119"] = {  dict = "club_open-30" , anim = "ig_djsolmanager_dual-30" , andar = false , loop = true },
	["foto120"] = {  dict= "anim_heist@arcade_combined@" , anim = "ped_female@_stand@_02a@_idles_convo_idle_d" , andar = false , loop = true },
	["foto121"] = {  dict= "amb@code_human_police_investigate@base" , anim = "base" , andar = false , loop = true },
	["foto122"] = {  dict= "amb@world_human_golf_player@male@base" , anim = "base" , andar = false , loop = true },
	["foto123"] = {  dict= "rcmnigel1a" , anim = "base" , andar = false , loop = true },
	["foto124"] = {  dict= "timetable@ron@ig_1" , anim = "ig_1_base" , andar = false , loop = true },
	["foto125"] = {  dict= "anim@amb@code_human_in_car_idles@arm@generic@ds@idle_j" , anim = "idle_lowdoor" , andar = false , loop = true },
	["foto126"] = {  dict= "club_open-0" , anim = "cs_lazlow_2_dual-0" , andar = false , loop = true },
	["foto127"] = {  dict= "armenian_1_int-33" , anim = "a_m_y_runner_01-33" , andar = false , loop = true },
	["foto128"] = {  dict= "armenian_1_int-33" , anim = "ig_lamardavis_dual-33" , andar = false , loop = true },
	["foto129"] = {  dict= "armenian_1_int-3" , anim = "a_f_y_fitness_02^5-3" , andar = false , loop = true },

	["casalm"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_trevor" , andar = false , loop = true },
	["casalf"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_patricia" , andar = false , loop = true },
	["casalm1"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_trevor" , andar = false , loop = true },
	["casalf1"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_patricia" , andar = false , loop = true },
	["casalf2"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_patricia" , andar = false , loop = true },
	["casalm2"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_trevor" , andar = false , loop = true },
	["casalf3"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_patricia" , andar = false , loop = true },
	["casalm3"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_trevor" , andar = false , loop = true },
	["casalf4"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_therearejustsomemoments_patricia" , andar = false , loop = true },
	["casalm4"] = { dict = "timetable@trevor@ig_1" , anim = "ig_1_therearejustsomemoments_trevor" , andar = false , loop = true },

	["abracocintura"] = { dict = "misscarsteal2chad_goodbye" , anim = "chad_armsaround_chad" , andar = false , loop = true },
	["abracocintura2"] = { dict = "misscarsteal2chad_goodbye" , anim = "chad_armsaround_chad" , andar = true , loop = true },
	["abracoombro"] = { dict = "misscarsteal2chad_goodbye" , anim = "chad_armsaround_girl" , andar = false , loop = true },
	["abracoombro2"] = { dict = "misscarsteal2chad_goodbye" , anim = "chad_armsaround_girl" , andar = true , loop = true },
	["cayo1"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_f02" , andar = false , loop = true },
	["cayo2"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_m01" , andar = false , loop = true },
	["cayo3"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_m02" , andar = false , loop = true },
	["cayo4"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_m03" , andar = false , loop = true },
	["cayo5"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_f01" , andar = false , loop = true },
	["cayo6"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_f02" , andar = false , loop = true },
	["cayo7"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_f03" , andar = false , loop = true },
	["cayo8"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_m01" , andar = false , loop = true },
	["cayo9"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_m02" , andar = false , loop = true },
	["cayo10"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_m03" , andar = false , loop = true },
	["cayo11"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_f01" , andar = false , loop = true },
	["cayo12"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_f02" , andar = false , loop = true },
	["cayo13"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_f03" , andar = false , loop = true },
	["cayo14"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_m01" , andar = false , loop = true },
	["cayo15"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_m02" , andar = false , loop = true },
	["cayo16"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_m03" , andar = false , loop = true },
	["cayo17"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_f01" , andar = false , loop = true },
	["cayo18"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_f02" , andar = false , loop = true },
	["cayo19"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_f03" , andar = false , loop = true },
	["cayo20"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_m01" , andar = false , loop = true },
	["cayo21"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_m02" , andar = false , loop = true },
	["cayo22"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_m03" , andar = false , loop = true },
	["cayo23"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_e_f02" , andar = false , loop = true },
	["cayo24"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_f_f02" , andar = false , loop = true },
	["cayo25"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_f01" , andar = false , loop = true },
	["cayo26"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_f02" , andar = false , loop = true },
	["cayo27"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_f03" , andar = false , loop = true },
	["cayo28"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_m01" , andar = false , loop = true },
	["cayo29"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_m02" , andar = false , loop = true },
	["cayo30"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_m03" , andar = false , loop = true },
	["cayo31"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_f01" , andar = false , loop = true },
	["cayo32"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_f02" , andar = false , loop = true },
	["cayo33"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_f03" , andar = false , loop = true },
	["cayo34"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_m01" , andar = false , loop = true },
	["cayo35"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_m02" , andar = false , loop = true },
	["cayo36"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_m03" , andar = false , loop = true },
	["cayo37"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_f01" , andar = false , loop = true },
	["cayo38"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_f02" , andar = false , loop = true },
	["cayo39"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_f03" , andar = false , loop = true },
	["cayo40"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_m01" , andar = false , loop = true },
	["cayo41"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_m02" , andar = false , loop = true },
	["cayo42"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_m03" , andar = false , loop = true },
	["cayo43"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_si_f01" , andar = false , loop = true },
	["cayo44"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_ti_f01" , andar = false , loop = true },
	["cayo45"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_ti_f02" , andar = false , loop = true },
	["cayo46"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_ti_f03" , andar = false , loop = true },
	["cayo47"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_f01" , andar = false , loop = true },

	["punt"] = { dict = "anim@mp_player_intselfiewank", anim = "enter" , andar = true , loop = false },
	["creu"] = { dict = "anim@mp_player_intupperair_shagging", anim = "idle_a_fp" , andar = true , loop = false },
	["dancei"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_left_up" , andar = false , loop = true },    
	["dancei2"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_f@" , anim = "ped_a_dance_idle" , andar = false , loop = true },    
	["dancei3"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_f@" , anim = "ped_b_dance_idle" , andar = false , loop = true },    
	["dancei4"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_h@" , anim = "ped_a_dance_idle" , andar = false , loop = true },    
	["dancei5"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_h@" , anim = "ped_b_dance_idle" , andar = false , loop = true },    
	["dancei6"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_j@" , anim = "ped_a_dance_idle" , andar = false , loop = true },    
	["dancei7"] = { dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_m@" , anim = "ped_a_dance_idle" , andar = false , loop = true },    
	["dancei8"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_f02" , andar = false , loop = true },    
	["dancei9"] = { dict = "anim@amb@nightclub_island@dancers@club@" , anim = "mi_idle_b_f02" , andar = false , loop = true },    
	["dancei10"] = { dict = "anim@mp_player_intcelebrationfemale@crowd_invitation" , anim = "crowd_invitation" , andar = false , loop = true },    
	["dancei11"] = { dict = "anim@mp_player_intcelebrationfemale@driver" , anim = "driver" , andar = false , loop = true },    
	["dancei12"] = { dict = "anim@mp_player_intcelebrationfemale@shooting" , anim = "shooting" , andar = false , loop = true },    
	["dancei13"] = { dict = "anim@mp_player_intcelebrationmale@shooting" , anim = "shooting" , andar = false , loop = true },    
	["dancei14"] = { dict = "anim@mp_player_intcelebrationmale@suck_it" , anim = "suck_it" , andar = false , loop = true },    
	["dancei15"] = { dict = "anim@mp_player_intuppercrowd_invitation" , anim = "idle_a" , andar = false , loop = true },    
	["dancei16"] = { dict = "anim@mp_player_intuppershooting" , anim = "idle_a" , andar = false , loop = true },    
	["dancei17"] = { dict = "anim@mp_player_intuppersuck_it" , anim = "idle_a" , andar = false , loop = true },

	["sentar2"] = { dict = "amb@world_human_picnic@male@base" , anim = "base" , andar = false , loop = true },
	["sentar3"] = { dict = "anim@heists@fleeca_bank@ig_7_jetski_owner" , anim = "owner_idle" , andar = false , loop = true },
	["sentar4"] = { dict = "amb@world_human_stupor@male@base" , anim = "base" , andar = false , loop = true },
	["sentar5"] = { dict = "amb@world_human_picnic@female@base" , anim = "base" , andar = false , loop = true },
	["sentar6"] = { dict = "anim@amb@nightclub@lazlow@lo_alone@" , anim = "lowalone_base_laz" , andar = false , loop = true },
	["sentar7"] = { dict = "anim@amb@business@bgen@bgen_no_work@" , anim = "sit_phone_phoneputdown_idle_nowork" , andar = false , loop = true },
	["sentar8"] = { dict = "rcm_barry3" , anim = "barry_3_sit_loop" , andar = false , loop = true },
	["sentar9"] = { dict = "amb@world_human_picnic@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	["sentar10"] = { dict = "amb@world_human_picnic@female@idle_a" , anim = "idle_a" , andar = false , loop = true },
	["sentar11"] = { dict = "timetable@jimmy@mics3_ig_15@" , anim = "idle_a_jimmy" , andar = false , loop = true },
	["sentar12"] = { dict = "timetable@jimmy@mics3_ig_15@" , anim = "mics3_15_base_jimmy" , andar = false , loop = true },
	["sentar13"] = { dict = "amb@world_human_stupor@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	["sentar14"] = { dict = "timetable@tracy@ig_14@" , anim = "ig_14_base_tracy" , andar = false , loop = true },
	["sentar15"] = { dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_loop_ped_b" , andar = false , loop = true },
	["sentar16"] = { dict = "anim@heists@ornate_bank@hostages@ped_e@" , anim = "flinch_loop" , andar = false , loop = true },
	["sentar17"] = { dict = "timetable@ron@ig_5_p3" , anim = "ig_5_p3_base" , andar = false , loop = true },
	["sentar18"] = { dict = "timetable@reunited@ig_10" , anim = "base_amanda" , andar = false , loop = true },
	["sentar19"] = { dict = "timetable@ron@ig_3_couch" , anim = "base" , andar = false , loop = true },
	["sentar20"] = { dict = "timetable@jimmy@mics3_ig_15@" , anim = "mics3_15_base_tracy" , andar = false , loop = true },
	["sentar21"] = { dict = "timetable@maid@couch@" , anim = "base" , andar = false , loop = true },
	["sentar22"] = { dict = "timetable@ron@ron_ig_2_alt1" , anim = "ig_2_alt1_base" , andar = false , loop = true },
	["sentar23"] = { dict = "timetable@reunited@ig_10" , anim ="shouldntyouguys_jimmy" , andar = false , loop = true },
	["sentar24"] = { dict = "timetable@tracy@ig_2@base" , anim ="base" , andar = false , loop = true },
	["sentar25"] = { dict = "anim@amb@office@boss@female@" , anim ="base" , andar = false , loop = true },
	["sentar26"] = { dict = "anim@amb@casino@out_of_money@ped_female@01a@base" , anim ="base" , andar = false , loop = true },
	["sentar27"] = { dict = "anim@amb@casino@out_of_money@ped_female@01b@base" , anim ="base" , andar = false , loop = true },
	["sentar28"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01a@base" , anim ="base" , andar = false , loop = true },
	["sentar29"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@01b@base" , anim ="base" , andar = false , loop = true },
	["sentar30"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02a@base" , anim ="base" , andar = false , loop = true },
	["sentar31"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02b@base" , anim ="base" , andar = false , loop = true },
	["sentar32"] = { dict = "anim_casino_a@amb@casino@games@slots@ped_female@regular@02a@base" , anim ="base" , andar = false , loop = true },
	["sentar33"] = { dict = "anim_casino_b@amb@casino@games@blackjack@ped_male@engaged@01a@base" , anim ="base" , andar = false , loop = true },
	["sentar34"] = { dict = "misslester1aig_3main" , anim ="air_guitar_01_a" , andar = false , loop = true },
	["sentar35"] = { dict = "missheistdocks2aleadinoutlsdh_2a_int" , anim ="sitting_loop_wade" , andar = false , loop = true },
	["sentar36"] = { dict = "switch@franklin@stripclub2" , anim ="ig_16_base" , andar = false , loop = true },
	["sentar37"] = { dict = "switch@michael@restaurant" , anim ="001510_02_gc_mics3_ig_1_base_amanda" , andar = false , loop = true },
	["sentar38"] = { dict = "switch@michael@ronex_ig_5_p2" , anim ="base_michael" , andar = false , loop = true },
	["sentar39"] = { dict = "timetable@amanda@facemask@base" , anim ="base" , andar = false , loop = true },
	["sentar40"] = { dict = "timetable@reunited@ig_7" , anim ="amandabase_amanda" , andar = false , loop = true },
	["sentar41"] = { dict = "timetable@tracy@ig_2@base" , anim ="base" , andar = false , loop = true },
	["sentar42"] = { dict = "mini@strip_club@backroom@" , anim ="leadin_loop_idle_c_stripper_c" , andar = false , loop = true },
	["sentar43"] = { dict = "timetable@trevor@smoking_meth@base" , anim ="base" , andar = false , loop = true },
	["sentar44"] = { dict = "switch@michael@sitting_on_car_premiere" , anim ="sitting_on_car_premiere_loop_player" , andar = false , loop = true },
	["sentar45"] = { dict = "mp_am_stripper" , anim ="lap_dance_player" , andar = false , loop = true },
	["sentar46"] = { dict = "switch@michael@opens_door_for_ama" , anim ="001895_02_mics3_17_opens_door_for_ama_idle_ama" , andar = false , loop = true },
	["sentar47"] = { dict = "switch@michael@lounge_chairs" , anim ="001523_01_mics3_9_lounge_chairs_idle_mic" , andar = false , loop = true },
	["sentar48"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01a@base_big_screen" , anim ="base_big_screen" , andar = false , loop = true },
	["sentar49"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01b@base" , anim ="base" , andar = false , loop = true },
	["sentar50"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01b@base_big_screen" , anim ="base_big_screen" , andar = false , loop = true },
	["sentar51"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@regular@01a@base" , anim ="base" , andar = false , loop = true },
	["sentar52"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@regular@01b@base_big_screen" , anim ="base_big_screen" , andar = false , loop = true },
	["sentar53"] = { dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02a@trans" , anim ="base_to_big_screen" , andar = false , loop = true },
	["sentar54"] = { dict = "switch@michael@parkbench_smoke_ranger" , anim ="parkbench_smoke_ranger_loop" , andar = false , loop = true },
	["sentar55"] = { dict = "switch@michael@lounge_chairs" , anim ="001523_01_mics3_9_lounge_chairs_idle_mic" , andar = false , loop = true },
	["sentar56"] = { dict = "anim@amb@business@cfm@cfm_machine_no_work@" , anim ="smokers_cough_v1_operator" , andar = false , loop = true },
	["sentar57"] = { dict = "rcmnigel1a_band_groupies" , anim ="bump_f1" , andar = false , loop = true },
	["sentar58"] = { dict = "anim@amb@nightclub@smoking@" , anim = "base" , andar = false , loop = true },
	["sentar59"] = { dict = "amb@lo_res_idles@" , anim = "world_human_picnic_female_lo_res_base" , andar = false , loop = true },
	["sentar60"] = { dict = "missheistdocks2aleadinoutlsdh_2a_int" , anim ="massage_loop_2_trevor" , andar = false , loop = true },
	["sentar61"] = { dict = "anim_casino_b@amb@casino@games@blackjack@ped_female@no_heels@regular@02a@reacts@v01" , anim ="reaction_impartial_var03" , andar = false , loop = true },
	["sentar62"] = { dict = "anim@amb@clubhouse@boss@female@" , anim ="base" , andar = false , loop = true },
	["sentar63"] = { dict = "timetable@denice@ig_4" , anim = "base" , andar = false , loop = true },
	["sentar64"] = { anim = "snort_coke_a_female" , dict  = "missfbi3_party" , andar = false , loop = true },
	["sentar65"] = { anim = "loop_amanda" , dict  = "switch@michael@cafe" , andar = false , loop = true },
	["sentar66"] = { dict = "safe@michael@ig_3" , anim ="base_michael" , andar = false , loop = true },
	["sentar67"] = { dict = "rcmnigel1a_band_groupies" , anim ="base_m1" , andar = false , loop = true },
	["sentar68"] = { dict = "anim@heists@fleeca_bank@hostages@intro" , anim ="intro_loop_ped_a" , andar = false , loop = true },
	["sentar69"] = { dict = "switch@michael@ronex_ig_5_p2" , anim ="base_michael" , andar = false , loop = true },
	["sentar70"] = { dict = "timetable@reunited@ig_10" , anim = "shouldntyouguys_amanda" , andar = false , loop = true },
	["sentar71"] = { dict = "bs_1_int-9" , anim = "player_one_dual-9" , andar = false , loop = true },
	["sentar72"] = { dict = "anim@amb@office@boss@female@" , anim = "base" , andar = false , loop = true },
	["sentar73"] = { dict = "rcmnigel1a_band_groupies" , anim = "bump_f1" , andar = false , loop = true },
	["sentar74"] = { dict= "missheistdocks2aleadinoutlsdh_2a_int" , anim = "sitting_loop_wade" , andar = false , loop = true },
	["sentar75"] = { dict= "anim@amb@business@cfid@cfid_desk_no_work_bgen_chair_no_work@" , anim = "lookaround_phoneless_lazyworker" , andar = false , loop = true },
	["sentar76"] = { dict= "switch@michael@restaurant" , anim = "001510_02_gc_mics3_ig_1_base_amanda" , andar = false , loop = true },
	["sentar77"] = { dict= "timetable@reunited@ig_7" , anim = "amandabase_amanda" , andar = false , loop = true },
	["sentar78"] = { dict= "mini@strip_club@backroom@" , anim = "leadin_loop_idle_c_stripper_c" , andar = false , loop = true },
	["sentar79"] = { dict= "switch@michael@lounge_chairs" , anim = "001523_01_mics3_9_lounge_chairs_idle_mic" , andar = false , loop = true },
	["sentar80"] = { dict= "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01b@base_big_screen" , anim = "base_big_screen" , andar = false , loop = true },
	["sentar81"] = { dict= "anim_casino_a@amb@casino@games@insidetrack@ped_female@regular@01a@base" , anim = "base" , andar = false , loop = true },
	["sentar82"] = { dict= "missheistdocks2aleadinoutlsdh_2a_int" , anim = "massage_loop_2_trevor" , andar = false , loop = true },
	["sentar83"] = { dict= "timetable@amanda@ig_7" , anim = "base" , andar = false , loop = true },
	["sentar84"] = { dict= "hs3_pln_int-0" , anim = "csb_huang_dual-0" , andar = false , loop = true },
	["sentar85"] = { dict = "timetable@tracy@ig_14@" , anim ="ig_14_iwishall_a_tracy" , andar = false , loop = true },
	["sentar86"] = { dict = "mp_safehouselost_table@" , anim ="lost_table_idle_a" , andar = false , loop = true },
	["sentar87"] = { dict = "timetable@ron@ron_ig_2_alt1" , anim ="ig_2_alt1_base" , andar = false , loop = true },
	["sentar88"] = { dict = "anim@amb@office@boss@female@" , anim ="base" , andar = false , loop = true },
	["sentar89"] = { dict = "rcmnigel1aig_1" , anim ="you_know_girl" , andar = false , loop = true },
	["sentar90"] = { dict = "anim@amb@clubhouse@boardroom@boss@female@base_r@" , anim ="base" , andar = false , loop = true },
	["sentar91"] = { dict = "anim@amb@facility@briefing_room@seating@female@var_b@" , anim ="base" , andar = false , loop = true },
	["sentar92"] = { dict = "switch@michael@ronex_ig_5_p2" , anim ="base_michael" , andar = false , loop = true },
	["sentar93"] = { dict = "switch@franklin@stripclub3" , anim ="ig_17_base" , andar = false , loop = true },
	["sentar94"] = { dict = "safe@franklin@ig_14" , anim ="base" , andar = false , loop = true },
	["sentar95"] = { dict = "rcmnigel1bnmt_1b" , anim ="base_girl" , andar = false , loop = true },
	["sentar96"] = { dict = "anim@amb@business@cfm@cfm_machine_no_work@" , anim ="hanging_out_operator" , andar = false , loop = true },
	["sentar97"] = { dict = "timetable@reunited@ig_10" , anim ="shouldntyouguys_tracy" , andar = false , loop = true },
	["sentar98"] = { dict = "missfbi3_party" , anim ="snort_coke_b_male5" , andar = false , loop = true },
	["sentar99"] = { dict = "missheistpaletoscoresetupleadin" , anim ="rbhs_mcs_1_leadin" , andar = false , loop = true },
	["sentar100"] = { dict = "misslester1aig_3exit" , anim ="air_guitar_01_exitloop_d" , andar = false , loop = true },
	["sentar101"] = { dict = "misslester1aig_3main" , anim ="air_guitar_01_b" , andar = false , loop = true },
	["sentar102"] = { dict = "misslester1aig_5intro" , anim ="boardroom_intro_f_c" , andar = false , loop = true },
	["sentar103"] = { dict = "misslester1b_crowd@m_" , anim ="001082_01_m_a" , andar = false , loop = true },
	["sentar104"] = { dict = "mp_am_stripper" , anim ="lap_dance_player" , andar = false , loop = true },
	["sentar105"] = { dict = "safe@franklin@ig_14" , anim ="base" , andar = false , loop = true },
	["sentar106"] = { dict = "switch@trevor@mocks_lapdance" , anim ="001443_01_trvs_28_idle_man" , andar = false , loop = true },
	["sentar107"] = { dict = "switch@trevor@rude_at_cafe" , anim ="001218_03_trvs_23_rude_at_cafe_idle_female" , andar = false , loop = true },
	["sentar108"] = { dict = "amb@world_human_seat_steps@female@hands_by_sides@base" , anim ="base" , andar = false , loop = true },
	["sentar109"] = { dict = "amb@world_human_seat_wall@female@hands_by_sides@base" , anim ="base" , andar = false , loop = true },
	["sentar110"] = { dict = "timetable@trevor@trv_ig_2" , anim ="base_trevor" , andar = false , loop = true },
	["sentar111"] = { dict = "missdrfriedlanderdrf_idles" , anim ="drf_idle_drf" , andar = false , loop = true },
	["sentar112"] = { dict = "anim@amb@clubhouse@boss@female@" , anim ="base" , andar = false , loop = true },
	["sentar113"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_b@base_r@" , anim ="base" , andar = false , loop = true },
	["sentar114"] = { dict = "anim@amb@office@seating@female@var_b@base@" , anim ="base" , andar = false , loop = true },
	["sentar115"] = { dict = "anim@amb@office@seating@female@var_c@base@" , anim ="base" , andar = false , loop = true },
	["sentar116"] = { dict = "amb@world_human_seat_steps@male@elbows_on_knees@base" , anim ="base" , andar = false , loop = true },
	["sentar117"] = { dict = "anim@amb@facility@briefing_room@seating@male@var_a@" , anim ="base" , andar = false , loop = true },
	["sentar118"] = { dict = "anim@amb@clubhouse@boardroom@boss@female@base_r@" , anim ="base" , andar = false , loop = true },
	["sentar119"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_r@" , anim ="base" , andar = false , loop = true },
	["sentar120"] = { dict = "iaaj_ext-27" , anim ="csb_mp_agent14_dual-27" , andar = false , loop = true },
	["sentar121"] = { dict = "anim@amb@facility@briefing_room@seating@male@var_b@" , anim ="base" , andar = false , loop = true },
	["sentar122"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_l@" , anim ="base" , andar = false , loop = true },
	["sentar123"] = { dict = "missfam2_bikehire@" , anim ="base" , andar = false , loop = true },
	["sentar124"] = { dict = "missarmenian2" , anim ="car_react_gang_ps" , andar = false , loop = true },
	["sentar125"] = { dict = "anim@amb@office@boardroom@boss@male@" , anim ="base" , andar = false , loop = true },
	["sentar126"] = { dict = "anim@amb@office@seating@female@var_a@base@" , anim ="base" , andar = false , loop = true },
	["sentar127"] = { dict = "anim@amb@office@seating@male@var_b@base@" , anim ="base" , andar = false , loop = true },
	["sentar128"] = { dict = "anim@amb@office@seating@male@var_e@base@" , anim ="base" , andar = false , loop = true },
	["sentar129"] = { dict = "anim@amb@office@boardroom@crew@male@var_b@base_r@" , anim ="base" , andar = false , loop = true },
	["sentar130"] = { dict = "sub_int-38" , anim ="mp_m_freemode_01^1_dual-38" , andar = false , loop = true },
	["sentar131"] = { dict = "sil_int-28" , anim ="mp_m_freemode_01_dual-28" , andar = false , loop = true },
	["sentar132"] = { dict = "drf_mic_1_cs_1-15" , anim ="cs_drfriedlander_dual-15" , andar = false , loop = true },
	["sentar133"] = { dict = "drf_mic_1_cs_1-24" , anim ="cs_drfriedlander_dual-24" , andar = false , loop = true },
	["sentar134"] = { dict = "drf_mic_1_cs_1-30" , anim ="cs_drfriedlander_dual-30" , andar = false , loop = true },
	["sentar135"] = { dict = "amb@lo_res_idles@" , anim = "prop_human_deckchair_female_lo_res_base" , andar = false , loop = true },
	["sentar136"] = { dict = "anim@amb@office@boardroom@boss@male@" , anim = "base" , andar = false , loop = true },
	["sentar137"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base@" , anim = "base" , andar = false , loop = true },
	["sentar138"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_l@" , anim = "base" , andar = false , loop = true },
	["sentar139"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_r@" , anim = "base" , andar = false , loop = true },
	["sentar140"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_b@base@" , anim = "base" , andar = false , loop = true },
	["sentar141"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_b@base_r@" , anim = "base" , andar = false , loop = true },
	["sentar142"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_c@base@" , anim = "base" , andar = false , loop = true },
	["sentar143"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_c@base_l@" , anim = "base" , andar = false , loop = true },
	["sentar144"] = { dict = "anim@amb@clubhouse@boardroom@crew@female@var_c@base_r@" , anim = "base" , andar = false , loop = true },
	["sentar145"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base@" , anim = "base" , andar = false , loop = true },
	["sentar146"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base_l@" , anim = "base" , andar = false , loop = true },
	["sentar147"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base_r@" , anim = "base" , andar = false , loop = true },
	["sentar148"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_b@base@" , anim = "base" , andar = false , loop = true },
	["sentar149"] = { dict = "anim@amb@clubhouse@boardroom@crew@male@var_c@base@" , anim = "base" , andar = false , loop = true },
	["sentar150"] = { dict = "amb@incar@male@smoking_van@enter" , anim = "enter" , andar = false , loop = true },
	["sentar151"] = { dict = "anim@amb@yacht@jacuzzi@seated@female@variation_05@" , anim = "idle_a" , andar = false , loop = true },
	["sentar152"] = { dict = "family_4_mcs_2-2" , anim = "csb_hugh_dual-2" , andar = false , loop = true },
	["sentar153"] = { dict = "anim@amb@office@boardroom@crew@female@var_a@base_r@" , anim = "base" , andar = false , loop = true },
	["sentar154"] = { dict = "arm_1_mcs_2_concat-0" , anim = "cs_denise_dual-0" , andar = false , loop = true },
	["sentar155"] = { dict= "anim@amb@facility@briefing_room@seating@male@var_a@" , anim = "base" , andar = false , loop = true },
	["sentar156"] = { dict= "anim@amb@office@seating@female@var_b@base@" , anim = "base" , andar = false , loop = true },
	["sentar157"] = { dict= "anim@amb@office@seating@female@var_c@base@" , anim = "base" , andar = false , loop = true },
	["sentar158"] = { dict= "anim@amb@clubhouse@boardroom@crew@female@var_a@base_r@" , anim = "base" , andar = false , loop = true },
	["sentar159"] = { dict= "missheist_jewelleadinout" , anim = "jh_int_outro_loop_d" , andar = false , loop = true },
	["sentar160"] = { dict= "drf_mic_1_cs_1-15" , anim = "cs_drfriedlander_dual-15" , andar = false , loop = true },
	["sentar161"] = { dict= "sol_3_int-9" , anim = "cs_molly_dual-9" , andar = false , loop = true },
	["sentar162"] = { dict= "sil_int-29" , anim = "mp_m_freemode_01^3_dual-29" , andar = false , loop = true },

	["encostar2"] = { dict = "bs_2a_mcs_10-0" , anim = "hc_gunman_dual-0" , andar = false , loop = true },
	["encostar3"] = { dict = "misscarstealfinalecar_5_ig_1" , anim = "waitloop_lamar" , andar = false , loop = true },
	["encostar4"] = { dict = "anim@amb@casino@out_of_money@ped_female@02b@base" , anim = "base" , andar = false , loop = true },
	["encostar5"] = { dict = "anim@amb@casino@hangout@ped_male@stand@03b@base" , anim = "base" , andar = true , loop = true },
	["encostar6"] = { dict = "anim@amb@casino@hangout@ped_female@stand@02b@base" , anim = "base" , andar = false , loop = true },
	["encostar7"] = { dict = "anim@amb@casino@hangout@ped_female@stand@02a@base" , anim = "base" , andar = false , loop = true },
	["encostar8"] = { dict = "anim@amb@casino@hangout@ped_female@stand@01b@base" , anim = "base" , andar = false , loop = true },
	["encostar9"] = { dict = "anim@amb@clubhouse@bar@bartender@" , anim = "base_bartender" , andar = false , loop = true },
	["encostar10"] = { dict = "missclothing" , anim = "idle_a" , andar = false , loop = true },
	["encostar11"] = { dict = "misscarstealfinale" , anim = "packer_idle_1_trevor" , andar = false , loop = true },
	["encostar12"] = { dict = "missarmenian1leadinoutarm_1_ig_14_leadinout" , anim = "leadin_loop" , andar = false , loop = true },
	["encostar13"] = { dict = "rcmjosh2" , anim ="josh_2_intp1_base" , andar = false , loop = true },
	["encostar14"] = { dict = "rcmjosh2" , anim ="josh_wait_loop" , andar = false , loop = true },
	["encostar15"] = { dict = "anim@amb@yacht@bow@male@variation_01@" , anim ="base" , andar = false , loop = true },
	["encostar16"] = { dict = "anim@heists@prison_heist" , anim ="ped_b_loop_a" , andar = false , loop = true },
	["encostar17"] = { dict = "anim@heists@prison_heiststation@cop_reactions" , anim ="drunk_idle" , andar = false , loop = true },
	["encostar18"] = { dict = "missarmenian1leadinoutarm_1_ig_14_leadinout" , anim ="leadin_loop" , andar = false , loop = true },
	["encostar19"] = { dict = "misscarsteal1car_1_ext_leadin" , anim ="base_driver1" , andar = false , loop = true },
	["encostar20"] = { dict = "missclothing" , anim ="idle_b" , andar = false , loop = true },
	["encostar21"] = { dict = "missfbi1ig_8" , anim ="outro1_pedb" , andar = false , loop = true },
	["encostar22"] = { dict = "missfbi1leadinout" , anim ="fbi_1_int_leadin_exit_loop_daven" , andar = false , loop = true },
	["encostar23"] = { dict = "misshair_shop@hair_dressers" , anim ="assistant_base" , andar = false , loop = true },
	["encostar24"] = { dict = "missheist_agency2aig_4" , anim ="look_plan_base_worker2" , andar = false , loop = true },
	["encostar26"] = { dict = "missheistdockssetup1ig_12@base" , anim ="talk_gantry_idle_base_worker4" , andar = false , loop = true },
	["encostar25"] = { dict = "missstrip_club_lean" , anim ="player_lean_rail_loop" , andar = false , loop = true },
	["encostar26"] = { dict = "mini@strip_club@leaning@base" , anim ="base" , andar = false , loop = true },
	["encostar27"] = { dict = "missheist_jewelleadinout" , anim ="jh_int_outro_loop_c" , andar = false , loop = true },
	["encostar28"] = { dict = "anim@amb@business@bgen@bgen_no_work@" , anim ="stand_phone_phoneputdown_fallasleep_nowork" , andar = false , loop = true },
	["encostar29"] = { dict = "anim@amb@business@bgen@bgen_no_work@" , anim ="stand_phone_phoneputdown_idle_nowork" , andar = false , loop = true },
	["encostar30"] = { dict = "anim@amb@business@bgen@bgen_no_work@" , anim ="stand_phone_phoneputdown_stretching_nowork" , andar = false , loop = true },
	["encostar31"] = { dict = "anim@amb@clubhouse@bar@bartender@" , anim ="greeting_c_bartender" , andar = false , loop = true },
	["encostar32"] = { dict = "anim@amb@clubhouse@bar@drink@base" , anim ="idle_a" , andar = false , loop = true },
	["encostar33"] = { dict = "misscarsteal4leadinout" , anim ="ig_1_base" , andar = false , loop = true },
	["encostar34"] = { dict = "missclothing" , anim ="base" , andar = false , loop = true },
	["encostar35"] = { dict = "missheistdockssetup1ig_5@base" , anim ="workers_talking_base_dockworker2" , andar = false , loop = true },
	["encostar36"] = { dict = "switch@michael@sitting_on_car_bonnet" , anim ="sitting_on_car_bonnet_loop" , andar = false , loop = true },
	["encostar37"] = { dict = "amb@world_human_leaning@male@wall@back@foot_up@react_shock" , anim ="front" , andar = false , loop = true },
	["encostar38"] = { dict = "anim@amb@world_human_valet@informal@idle_a@" , anim ="idle_a_a_m_y_vinewood_01" , andar = false , loop = true },
	["encostar39"] = { dict = "anim@amb@nightclub@dancers@club_ambientpeds@low-med_intensity" , anim ="li-mi_amb_club_06_base_female^1" , andar = false , loop = true },
	["encostar40"] = { dict = "ah_1_int-4" , anim ="cs_davenorton_dual-4" , andar = false , loop = true },
	["encostar41"] = { dict = "silj_int-8" , anim ="csb_mp_agent14_dual-8" , andar = false , loop = true },
	["encostar42"] = { dict = "anim@veh@btype@side_ds@base" , anim ="sit" , andar = false , loop = true },
	["encostar43"] = { dict = "anim@veh@btype@side_ps@base" , anim ="sit" , andar = false , loop = true },
	["encostar44"] = { dict = "timetable@michael@talk_phonebase" , anim = "talk_phone_base" , andar = false , loop = true },
	["encostar45"] = { dict = "anim@amb@clubhouse@bar@bartender@" , anim = "base_bartender" , andar = false , loop = true },
	["encostar46"] = { dict = "anim@amb@yacht@jacuzzi@standing@female@variation_02@" , anim = "base_b" , andar = false , loop = true },
	["encostar47"] = { anim = "assistant_idle_a" , dict  = "misshair_shop@hair_dressers" , andar = false , loop = true },
	["encostar48"] = { anim = "assistant_base" , dict  = "misshair_shop@hair_dressers" , andar = false , loop = true },
	["encostar49"] = { dict = "rcmjosh2" , anim = "josh_2_intp1_base" , andar = false , loop = true },
	["encostar50"] = { dict = "anim@arena@prize_wheel@male" , anim = "base" , andar = false , loop = true },
	["encostar51"] = { dict = "hs3_arc_int-15" , anim = "csb_wendy_dual-15" , andar = false , loop = true },
	["encostar52"] = { dict = "anim@amb@yacht@rail@seated@female@variant_02@" , anim = "base" , andar = false , loop = true },
	["encostar53"] = { dict = "anim@amb@yacht@rail@seated@male@variant_01@" , anim = "base" , andar = false , loop = true },
	["encostar54"] = { dict= "misscarsteal4leadinout" , anim = "ig_1_base" , andar = false , loop = true },
	["encostar55"] = { dict= "missclothing" , anim = "base" , andar = false , loop = true },
	["encostar56"] = { dict= "missheistdockssetup1ig_5@base" , anim = "workers_talking_base_dockworker2" , andar = false , loop = true },
	["encostar57"] = { dict= "fra_0_int-9" , anim = "player_one_dual-9" , andar = false , loop = true },
	["encostar58"] = { dict= "fra_0_int-9" , anim = "player_one_dual-9" , andar = false , loop = true },
	["encostar59"] = { dict= "missheistdocks2aleadinoutlsdh_2a_int" , anim = "massage_loop_floyd" , andar = false , loop = true },
	["encostar60"] = { dict = "amb@lo_res_idles@" , anim = "world_human_lean_female_holding_elbow_lo_res_base" , andar = false , loop = true },
	["encostar61"] = { dict = "anim@amb@yacht@jacuzzi@standing@female@variation_01@" , anim ="base" , andar = false , loop = true },
	["encostar62"] = { dict = "anim@amb@yacht@jacuzzi@standing@female@variation_02@" , anim ="base" , andar = false , loop = true },
	["encostar63"] = { dict = "anim@amb@yacht@jacuzzi@standing@male@variation_01@" , anim ="base" , andar = false , loop = true },
	["encostar64"] = { dict = "anim@amb@yacht@jacuzzi@standing@male@variation_02@" , anim ="base" , andar = false , loop = true },
	["encostar65"] = { dict = "switch@michael@pier" , anim ="pier_lean_toss_cigarette" , andar = false , loop = true },
	["encostar66"] = { dict = "missheistdockssetup1ig_10@idle_d" , anim ="talk_pipe_d_worker2" , andar = false , loop = true },
	["encostar67"] = { dict = "missheistdockssetup1ig_10@idle_a" , anim ="talk_pipe_a_worker2" , andar = false , loop = true },
	["encostar68"] = { dict = "amb@code_human_in_car_mp_actions@finger@std@rps@base" , anim ="idle_a" , andar = false , loop = true },
	["encostar69"] = { dict = "anim@amb@nightclub@dancers@club_ambientpeds@low-med_intensity" , anim ="li-mi_amb_club_10_v1_male^3" , andar = false , loop = true },
	["encostar70"] = { dict = "anim@amb@business@meth@meth_monitoring_no_work@" , anim ="turnaround_idle_v1_lazycook" , andar = false , loop = true },
	["encostar71"] = { dict = "sub_int-42" , anim ="a_m_y_busicas_01_dual-42" , andar = false , loop = true },
	["encostar72"] = { dict = "rcmnigel1a_band_groupies" , anim ="base_m2" , andar = false , loop = true },

	["aqc"] = { dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_a" , andar = false , loop = false },
	["aqc2"] = { dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_d" , andar = false , loop = false },
	["inspec"] = { dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_b" , andar = false , loop = true },
	["inspec2"] = { dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_c" , andar = false , loop = false },
	["inspec3"] = { dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_d" , andar = false , loop = false },
	["inspec4"] = { dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_e" , andar = false , loop = false },
	["inspec5"] = { dict = "mp_deathmatch_intros@1hmale" , anim = "intro_male_1h_a_michael" , andar = false , loop = false },
	["inspec6"] = { dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_a" , andar = false , loop = false },
	["inspec7"] = { dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_b" , andar = false , loop = false },
	["inspec8"] = { dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_c" , andar = false , loop = false },
	["inspec9"] = { dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_d" , andar = false , loop = false },
	["inspec10"] = { dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_e" , andar = false , loop = false },
	["inspec11"] = { dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_a" , andar = false , loop = false },
	["inspec12"] = { dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_b" , andar = false , loop = false },
	["inspec13"] = { dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_c" , andar = false , loop = false },
	["inspec14"] = { dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_d" , andar = false , loop = false },
	["inspec15"] = { dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_e" , andar = false , loop = false },
	["inspec16"] = { dict = "anim@deathmatch_intros@1hmale" , anim = "intro_male_1h_d_michael" , andar = true , loop = false },
	["swat"] = { dict = "swat" , anim = "come" , andar = true , loop = false },
	["swat2"] = { dict = "swat" , anim = "freeze" , andar = true , loop = false },
	["swat3"] = { dict = "swat" , anim = "go_fwd" , andar = true , loop = false },
	["swat4"] = { dict = "swat" , anim = "rally_point" , andar = true , loop = false },
	["swat5"] = { dict = "swat" , anim = "understood" , andar = true , loop = false },
	["swat6"] = { dict = "swat" , anim = "you_back" , andar = true , loop = false },
	["swat7"] = { dict = "swat" , anim = "you_fwd" , andar = true , loop = false },
	["swat8"] = { dict = "swat" , anim = "you_left" , andar = true , loop = false },
	["swat9"] = { dict = "swat" , anim = "you_right" , andar = true , loop = false },
-- FIM

-- RAVENAY
	["mamadeira1"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "mamadeira_ravenay", flag = 49, mao = 28422, altura = -0.020, pos1 = -0.02, pos2 = 0.0, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["mamadeira2"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "mamadeira_rlaranja", flag = 49, mao = 28422, altura = -0.05, pos1 = -0.02, pos2 = 0.0, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["cpxshieldpm"] = { dict = "mp_player_int_upperbro_love", anim = "mp_player_int_bro_love_fp", prop = "prop_riot_shield", flag = 49, mao = 36029 },
--


	["chuva"] = { dict = "amb@world_human_drinking@coffee@male@base", anim = "base", prop = "p_amb_brolly_01", flag = 50, mao = 28422 },
	["chuva2"] = { dict = "amb@world_human_drinking@coffee@male@base", anim = "base", prop = "p_amb_brolly_01_s", flag = 50, mao = 28422 },
	["comer"] = { dict = "amb@code_human_wander_eating_donut@male@idle_a", anim = "idle_c", prop = "prop_cs_burger_01", flag = 49, mao = 28422 },
	["comer2"] = { dict = "amb@code_human_wander_eating_donut@male@idle_a", anim = "idle_c", prop = "prop_cs_hotdog_01", flag = 49, mao = 28422 },
	["comer3"] = { dict = "amb@code_human_wander_eating_donut@male@idle_a", anim = "idle_c", prop = "prop_amb_donut", flag = 49, mao = 28422 },
	["comer4"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_choc_ego", flag = 49, mao = 60309 },
	["comer5"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_sandwich_01", flag = 49, mao = 18905, altura = 0.13, pos1 = 0.05, pos2 = 0.02, pos3 = -50.0, pos4 = 16.0, pos5 = 60.0 },
	["comer6"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_taco_01", flag = 49, mao = 18905, altura = 0.16, pos1 = 0.06, pos2 = 0.02, pos3 = -50.0, pos4 = 220.0, pos5 = 60.0 },
	["comer7"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_food_bs_chips", flag = 49, mao = 18905, altura = 0.10, pos1 = 0.0, pos2 = 0.08, pos3 = 150.0, pos4 = 320.0, pos5 = 160.0 },
	["beber"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "p_cs_bottle_01", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber2"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_energy_drink", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber3"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_amb_beer_bottle", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber4"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "p_whiskey_notop", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber5"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_beer_logopen", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.10, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber6"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_beer_blr", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.10, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber7"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_ld_flow_bottle", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber8"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "prop_plastic_cup_02", flag = 49, mao = 28422 },
	["beber9"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "prop_food_bs_juice03", flag = 49, mao = 28422, altura = 0.0, pos1 = -0.01, pos2 = -0.15, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber10"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "ng_proc_sodacan_01b", flag = 49, mao = 28422, altura = 0.0, pos1 = -0.01, pos2 = -0.08, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["digitar"] = { dict = "anim@heists@prison_heistig1_p1_guard_checks_bus", anim = "loop", andar = false, loop = true },
	["continencia"] = { dict = "mp_player_int_uppersalute", anim = "mp_player_int_salute", andar = true, loop = true },
	["atm"] = { dict = "amb@prop_human_atm@male@idle_a", anim = "idle_a", andar = false, loop = false },
	["no"] = { dict = "mp_player_int_upper_nod", anim = "mp_player_int_nod_no", andar = true, loop = true },
	["palmas"] = { dict = "anim@mp_player_intcelebrationfemale@slow_clap", anim = "slow_clap", andar = true, loop = false },
	["palmas2"] = { dict = "amb@world_human_cheering@male_b", anim = "base", andar = true, loop = true },
	["palmas3"] = { dict = "amb@world_human_cheering@male_d", anim = "base", andar = true, loop = true },
	["palmas4"] = { dict = "amb@world_human_cheering@male_e", anim = "base", andar = true, loop = true },
	["postura"] = { dict = "anim@heists@prison_heiststation@cop_reactions", anim = "cop_a_idle", andar = true, loop = true },
	["postura2"] = { dict = "amb@world_human_cop_idles@female@base", anim = "base", andar = true, loop = true },
	["varrer"] = { dict = "amb@world_human_janitor@male@idle_a", anim = "idle_a", prop = "prop_tool_broom", flag = 49, mao = 28422 },
	["musica"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_el_guitar_01", flag = 49, mao = 60309 },
	["musica2"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_el_guitar_02", flag = 49, mao = 60309 },
	["musica3"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_el_guitar_03", flag = 49, mao = 60309 },
	["musica4"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_acc_guitar_01", flag = 49, mao = 60309 },
	["musica5"] = { dict = "switch@trevor@guitar_beatdown", anim = "001370_02_trvs_8_guitar_beatdown_idle_busker", prop = "prop_acc_guitar_01", flag = 49, mao = 24818, altura = -0.05, pos1 = 0.31, pos2 = 0.1, pos3 = 0.0, pos4 = 20.0, pos5 = 150.0 },
	-- ["cameratv"] = { dict = "missfinale_c2mcs_1", anim = "fin_c2_mcs_1_camman", prop = "prop_v_cam_01", flag = 49, mao = 28422 },
	["prancheta"] = { dict = "amb@world_human_clipboard@male@base", anim = "base", prop = "p_amb_clipboard_01", flag = 50, mao = 60309 },
	["mapa"] = { dict = "amb@world_human_clipboard@male@base", anim = "base", prop = "prop_tourist_map_01", flag = 50, mao = 60309 },
	["anotar"] = { dict = "amb@medic@standing@timeofdeath@base", anim = "base", prop = "prop_notepad_01", flag = 49, mao = 60309 },
	["peace"] = { dict = "mp_player_int_upperpeace_sign", anim = "mp_player_int_peace_sign", andar = true, loop = true },
	["deitar"] = { dict = "anim@gangops@morgue@table@", anim = "body_search", andar = false, loop = true },
	["deitar2"] = { dict = "amb@world_human_sunbathe@female@front@idle_a", anim = "idle_a", andar = false, loop = true },
	["deitar3"] = { dict = "amb@world_human_sunbathe@male@back@idle_a", anim = "idle_a", andar = false, loop = true },
	["deitar4"] = { dict = "amb@world_human_sunbathe@male@front@idle_a", anim = "idle_a", andar = false, loop = true },
	["deitar5"] = { dict = "amb@world_human_sunbathe@female@back@idle_a", anim = "idle_a", andar = false, loop = true },
	["debrucar"] = { dict = "amb@prop_human_bum_shopping_cart@male@base", anim = "base", andar = false, loop = true },
	["debrucar2"] = { dict = "anim@amb@clubhouse@bar@drink@idle_a", anim = "idle_a_bartender", andar = true, loop = true },
	["dancar"] = { dict = "rcmnigel1bnmt_1b", anim = "dance_loop_tyler", andar = false, loop = true },
	["dancar2"] = { dict = "mp_safehouse", anim = "lap_dance_girl", andar = false, loop = true },
	["dancar3"] = { dict = "misschinese2_crystalmazemcs1_cs", anim = "dance_loop_tao", andar = false, loop = true },
	["dancar4"] = { dict = "mini@strip_club@private_dance@part1", anim = "priv_dance_p1", andar = false, loop = true },
	["dancar5"] = { dict = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2", andar = false, loop = true },
	["dancar6"] = { dict = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3", andar = false, loop = true },
	["dancar7"] = { dict = "special_ped@mountain_dancer@monologue_2@monologue_2a", anim = "mnt_dnc_angel", andar = false, loop = true },
	["dancar8"] = { dict = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", andar = false, loop = true },
	["dancar9"] = { dict = "missfbi3_sniping", anim = "dance_m_default", andar = false, loop = true },
	["dancar10"] = { dict = "anim@amb@nightclub@dancers@black_madonna_entourage@", anim = "hi_dance_facedj_09_v2_male^5", andar = false, loop = true },
	["dancar11"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^1", andar = false, loop = true },
	["dancar12"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^2", andar = false, loop = true },
	["dancar13"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^3", andar = false, loop = true },
	["dancar14"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^4", andar = false, loop = true },
	["dancar15"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^5", andar = false, loop = true },
	["dancar16"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^6", andar = false, loop = true },
	["dancar17"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^1", andar = false, loop = true },
	["dancar18"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^2", andar = false, loop = true },
	["dancar19"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^3", andar = false, loop = true },
	["dancar20"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^4", andar = false, loop = true },
	["dancar21"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^5", andar = false, loop = true },
	["dancar22"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^6", andar = false, loop = true },
	["dancar23"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^1", andar = false, loop = true },
	["dancar24"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^2", andar = false, loop = true },
	["dancar25"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^3", andar = false, loop = true },
	["dancar26"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^4", andar = false, loop = true },
	["dancar27"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^5", andar = false, loop = true },
	["dancar28"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^6", andar = false, loop = true },
	["dancar29"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^1", andar = false, loop = true },
	["dancar30"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^2", andar = false, loop = true },
	["dancar31"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^3", andar = false, loop = true },
	["dancar32"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^4", andar = false, loop = true },
	["dancar33"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^5", andar = false, loop = true },
	["dancar34"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^6", andar = false, loop = true },
	["dancar35"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^1", andar = false, loop = true },
	["dancar36"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^2", andar = false, loop = true },
	["dancar37"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^3", andar = false, loop = true },
	["dancar38"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^4", andar = false, loop = true },
	["dancar39"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^5", andar = false, loop = true },
	["dancar40"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^6", andar = false, loop = true },
	["dancar41"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^1", andar = false, loop = true },
	["dancar42"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^2", andar = false, loop = true },
	["dancar43"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^3", andar = false, loop = true },
	["dancar44"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^4", andar = false, loop = true },
	["dancar45"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^5", andar = false, loop = true },
	["dancar46"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^6", andar = false, loop = true },
	["dancar47"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^1", andar = false, loop = true },
	["dancar48"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^2", andar = false, loop = true },
	["dancar49"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^3", andar = false, loop = true },
	["dancar50"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^4", andar = false, loop = true },
	["dancar51"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^5", andar = false, loop = true },
	["dancar52"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^6", andar = false, loop = true },
	["dancar53"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^1", andar = false, loop = true },
	["dancar54"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^2", andar = false, loop = true },
	["dancar55"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^3", andar = false, loop = true },
	["dancar56"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^4", andar = false, loop = true },
	["dancar57"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^5", andar = false, loop = true },
	["dancar58"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^6", andar = false, loop = true },
	["dancar59"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^1", andar = false, loop = true },
	["dancar60"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^2", andar = false, loop = true },
	["dancar61"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^3", andar = false, loop = true },
	["dancar62"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^4", andar = false, loop = true },
	["dancar63"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^5", andar = false, loop = true },
	["dancar64"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^6", andar = false, loop = true },
	["dancar65"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^1", andar = false, loop = true },
	["dancar66"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^2", andar = false, loop = true },
	["dancar67"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^3", andar = false, loop = true },
	["dancar68"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^4", andar = false, loop = true },
	["dancar69"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^5", andar = false, loop = true },
	["dancar70"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^6", andar = false, loop = true },
	["dancar71"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^1", andar = false, loop = true },
	["dancar72"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^2", andar = false, loop = true },
	["dancar73"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^3", andar = false, loop = true },
	["dancar74"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^4", andar = false, loop = true },
	["dancar75"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^5", andar = false, loop = true },
	["dancar76"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^6", andar = false, loop = true },
	["dancar77"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^1", andar = false, loop = true },
	["dancar78"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^2", andar = false, loop = true },
	["dancar79"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^3", andar = false, loop = true },
	["dancar80"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^4", andar = false, loop = true },
	["dancar81"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^5", andar = false, loop = true },
	["dancar82"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^6", andar = false, loop = true },
	["dancar83"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^1", andar = false, loop = true },
	["dancar84"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^2", andar = false, loop = true },
	["dancar85"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^3", andar = false, loop = true },
	["dancar86"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^4", andar = false, loop = true },
	["dancar87"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^5", andar = false, loop = true },
	["dancar88"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^6", andar = false, loop = true },
	["dancar89"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^1", andar = false, loop = true },
	["dancar90"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^2", andar = false, loop = true },
	["dancar91"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^3", andar = false, loop = true },
	["dancar92"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^4", andar = false, loop = true },
	["dancar93"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^5", andar = false, loop = true },
	["dancar94"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^6", andar = false, loop = true },
	["dancar95"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^1", andar = false, loop = true },
	["dancar96"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^2", andar = false, loop = true },
	["dancar97"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^3", andar = false, loop = true },
	["dancar98"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^4", andar = false, loop = true },
	["dancar99"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^5", andar = false, loop = true },
	["dancar100"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^6", andar = false, loop = true },
	["dancar101"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^1", andar = false, loop = true },
	["dancar102"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^2", andar = false, loop = true },
	["dancar103"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^3", andar = false, loop = true },
	["dancar104"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^4", andar = false, loop = true },
	["dancar105"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^5", andar = false, loop = true },
	["dancar106"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^6", andar = false, loop = true },
	["dancar107"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^1", andar = false, loop = true },
	["dancar108"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^2", andar = false, loop = true },
	["dancar109"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^3", andar = false, loop = true },
	["dancar110"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^4", andar = false, loop = true },
	["dancar111"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^5", andar = false, loop = true },
	["dancar112"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^6", andar = false, loop = true },
	["dancar113"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^1", andar = false, loop = true },
	["dancar114"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^2", andar = false, loop = true },
	["dancar115"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^3", andar = false, loop = true },
	["dancar116"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^4", andar = false, loop = true },
	["dancar117"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^5", andar = false, loop = true },
	["dancar118"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^6", andar = false, loop = true },
	["dancar119"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^1", andar = false, loop = true },
	["dancar120"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^2", andar = false, loop = true },
	["dancar121"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^3", andar = false, loop = true },
	["dancar122"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^4", andar = false, loop = true },
	["dancar123"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^5", andar = false, loop = true },
	["dancar124"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^6", andar = false, loop = true },
	["dancar125"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^1", andar = false, loop = true },
	["dancar126"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^2", andar = false, loop = true },
	["dancar127"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^3", andar = false, loop = true },
	["dancar128"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^4", andar = false, loop = true },
	["dancar129"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^5", andar = false, loop = true },
	["dancar130"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^6", andar = false, loop = true },
	["dancar131"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^1", andar = false, loop = true },
	["dancar132"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^2", andar = false, loop = true },
	["dancar133"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^3", andar = false, loop = true },
	["dancar134"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^4", andar = false, loop = true },
	["dancar135"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^5", andar = false, loop = true },
	["dancar136"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^6", andar = false, loop = true },
	["dancar137"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^1", andar = false, loop = true },
	["dancar138"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^2", andar = false, loop = true },
	["dancar139"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^3", andar = false, loop = true },
	["dancar140"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^4", andar = false, loop = true },
	["dancar141"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^5", andar = false, loop = true },
	["dancar142"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^6", andar = false, loop = true },
	["dancar143"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^1", andar = false, loop = true },
	["dancar144"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^2", andar = false, loop = true },
	["dancar145"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^3", andar = false, loop = true },
	["dancar146"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^4", andar = false, loop = true },
	["dancar147"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^5", andar = false, loop = true },
	["dancar148"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^6", andar = false, loop = true },
	["dancar149"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^1", andar = false, loop = true },
	["dancar150"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^2", andar = false, loop = true },
	["dancar151"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^3", andar = false, loop = true },
	["dancar152"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^4", andar = false, loop = true },
	["dancar153"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^5", andar = false, loop = true },
	["dancar154"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^6", andar = false, loop = true },
	["dancar155"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^1", andar = false, loop = true },
	["dancar156"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^2", andar = false, loop = true },
	["dancar157"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^3", andar = false, loop = true },
	["dancar158"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^4", andar = false, loop = true },
	["dancar159"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^5", andar = false, loop = true },
	["dancar160"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^6", andar = false, loop = true },
	["dancar161"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^1", andar = false, loop = true },
	["dancar162"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^2", andar = false, loop = true },
	["dancar163"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^3", andar = false, loop = true },
	["dancar164"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^4", andar = false, loop = true },
	["dancar165"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^5", andar = false, loop = true },
	["dancar166"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^6", andar = false, loop = true },
	["dancar167"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^1", andar = false, loop = true },
	["dancar168"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^2", andar = false, loop = true },
	["dancar169"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^3", andar = false, loop = true },
	["dancar170"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^4", andar = false, loop = true },
	["dancar171"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^5", andar = false, loop = true },
	["dancar172"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^6", andar = false, loop = true },
	["dancar173"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^1", andar = false, loop = true },
	["dancar174"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^2", andar = false, loop = true },
	["dancar175"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^3", andar = false, loop = true },
	["dancar176"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^4", andar = false, loop = true },
	["dancar177"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^5", andar = false, loop = true },
	["dancar178"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^6", andar = false, loop = true },
	["dancar179"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^1", andar = false, loop = true },
	["dancar180"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^2", andar = false, loop = true },
	["dancar181"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^3", andar = false, loop = true },
	["dancar182"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^4", andar = false, loop = true },
	["dancar183"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^5", andar = false, loop = true },
	["dancar184"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^6", andar = false, loop = true },
	["dancar185"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^1", andar = false, loop = true },
	["dancar186"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^2", andar = false, loop = true },
	["dancar187"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^3", andar = false, loop = true },
	["dancar188"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^4", andar = false, loop = true },
	["dancar189"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^5", andar = false, loop = true },
	["dancar190"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^6", andar = false, loop = true },
	["dancar191"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^1", andar = false, loop = true },
	["dancar192"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^2", andar = false, loop = true },
	["dancar193"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^3", andar = false, loop = true },
	["dancar194"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^4", andar = false, loop = true },
	["dancar195"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^5", andar = false, loop = true },
	["dancar196"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^6", andar = false, loop = true },
	["dancar197"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^1", andar = false, loop = true },
	["dancar198"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^2", andar = false, loop = true },
	["dancar199"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^3", andar = false, loop = true },
	["dancar200"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^4", andar = false, loop = true },
	["dancar201"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^5", andar = false, loop = true },
	["dancar202"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^6", andar = false, loop = true },
	["dancar203"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^1", andar = false, loop = true },
	["dancar204"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^2", andar = false, loop = true },
	["dancar205"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^3", andar = false, loop = true },
	["dancar206"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^4", andar = false, loop = true },
	["dancar207"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^5", andar = false, loop = true },
	["dancar208"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^6", andar = false, loop = true },
	["dancar209"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^1", andar = false, loop = true },
	["dancar210"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^2", andar = false, loop = true },
	["dancar211"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^3", andar = false, loop = true },
	["dancar212"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^4", andar = false, loop = true },
	["dancar213"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^5", andar = false, loop = true },
	["dancar214"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^6", andar = false, loop = true },
	["dancar215"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^1", andar = false, loop = true },
	["dancar216"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^2", andar = false, loop = true },
	["dancar217"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^3", andar = false, loop = true },
	["dancar218"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^4", andar = false, loop = true },
	["dancar219"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^5", andar = false, loop = true },
	["dancar220"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^6", andar = false, loop = true },
	["dancar221"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^1", andar = false, loop = true },
	["dancar222"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^2", andar = false, loop = true },
	["dancar223"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^3", andar = false, loop = true },
	["dancar224"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^4", andar = false, loop = true },
	["dancar225"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^5", andar = false, loop = true },
	["dancar226"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^6", andar = false, loop = true },
	["dancar227"] = { dict = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_buttwiggle_b_laz", andar = false, loop = true },
	["dancar228"] = { dict = "timetable@tracy@ig_5@idle_a", anim = "idle_a", andar = false, loop = true },
	["dancar229"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_down", andar = false, loop = true },
	["dancar230"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", andar = false, loop = true },
	["dancar231"] = { dict = "anim@mp_player_intupperfind_the_fish", anim = "idle_a", andar = true, loop = true },
	["dancar232"] = { dict = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_buttwiggle_b_laz", andar = false, loop = true },
	["dancar233"] = { dict = "move_clown@p_m_two_idles@", anim = "fidget_short_dance", andar = false, loop = true },
	["dancar234"] = { dict = "move_clown@p_m_zero_idles@", anim = "fidget_short_dance", andar = false, loop = true },
	["dancar235"] = { dict = "misschinese2_crystalmazemcs1_ig", anim = "dance_loop_tao", andar = false, loop = true },
	["dancar236"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center", andar = false, loop = true },
	["dancar237"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center_down", andar = false, loop = true },
	["dancar238"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center", andar = false, loop = true },
	["dancar239"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center_up", andar = false, loop = true },
	["dancar240"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center", andar = true, loop = true },
	["dancar241"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_up", andar = false, loop = true },
	["dancar242"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center", andar = false, loop = true },
	["dancar243"] = { dict = "anim@amb@nightclub@dancers@podium_dancers@", anim = "hi_dance_facedj_17_v2_male^5", andar = false, loop = true },
	["dancar244"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center", andar = false, loop = true },
	["dancar245"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center_down", andar = false, loop = true },
	["dancar246"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center", andar = false, loop = true },
	["dancar247"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center_up", andar = false, loop = true },
	["dancar248"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center", andar = false, loop = true },
	["dancar249"] = { dict = "anim@amb@nightclub@dancers@solomun_entourage@", anim = "mi_dance_facedj_17_v1_female^1", andar = false, loop = true },
	["dancar250"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", andar = false, loop = true },
	["dancar251"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center", andar = false, loop = true },
	["dancar252"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center", andar = false, loop = true },
	["dancar253"] = { dict = "mini@strip_club@private_dance@idle", anim = "priv_dance_idle", andar = false, loop = true },
	["dancar254"] = { dict = "mini@strip_club@lap_dance_2g@ld_2g_p1", anim = "ld_2g_p1_s2", andar = false, loop = true },
	["dancar255"] = { dict = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f", andar = false, loop = true },
	["dancar256"] = { dict = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "dancecrowd_li_11_hu_shimmy_laz", andar = false, loop = true },
	["dancar257"] = { dict = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "crowddance_hi_11_handup_laz", andar = false, loop = true },
	["dancar258"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_left_down", andar = false, loop = true },
	["dancar259"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_left_up", andar = false, loop = true },
	["dancar260"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_right", andar = false, loop = true },
	["dancar261"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_right_down", andar = false, loop = true },
	["dancar262"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_right_up", andar = false, loop = true },
	["dancar263"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_center", andar = false, loop = true },
	["dancar264"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_center_down", andar = false, loop = true },
	["dancar265"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_center_up", andar = false, loop = true },
	["dancar266"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_left", andar = false, loop = true },
	["dancar267"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_left_down", andar = false, loop = true },
	["dancar268"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_left_up", andar = false, loop = true },
	["dancar269"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_right", andar = false, loop = true },
	["dancar270"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_right_down", andar = false, loop = true },
	["dancar271"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left", andar = false, loop = true },
	["dancar272"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left_down", andar = false, loop = true },
	["dancar273"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left_up", andar = false, loop = true },
	["dancar274"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right", andar = false, loop = true },
	["dancar275"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right_down", andar = false, loop = true },
	["dancar276"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right_up", andar = false, loop = true },
	["dancar277"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center", andar = false, loop = true },
	["dancar278"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center_down", andar = false, loop = true },
	["dancar279"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center_up", andar = false, loop = true },
	["dancar280"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left", andar = false, loop = true },
	["dancar281"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left_down", andar = false, loop = true },
	["dancar282"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left_up", andar = false, loop = true },
	["dancar283"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right", andar = false, loop = true },
	["dancar284"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right_down", andar = false, loop = true },
	["dancar285"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right_up", andar = false, loop = true },
	["dancar286"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center", andar = false, loop = true },
	["dancar287"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center_down", andar = false, loop = true },
	["dancar288"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center_up", andar = false, loop = true },
	["dancar289"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_left", andar = false, loop = true },
	["dancar290"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_left_down", andar = false, loop = true },
	["dancar291"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_left_up", andar = false, loop = true },
	["dancar292"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_right", andar = false, loop = true },
	["dancar293"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_right_down", andar = false, loop = true },
	["dancar294"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_right_up", andar = false, loop = true },
	["dancar295"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_right_up", andar = false, loop = true },
	["dancar296"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center_down", andar = false, loop = true },
	["dancar297"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center_up", andar = false, loop = true },
	["dancar298"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_left", andar = false, loop = true },
	["dancar299"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_left_down", andar = false, loop = true },
	["dancar300"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_left_up", andar = false, loop = true },
	["dancar301"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_right", andar = false, loop = true },
	["dancar302"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_right_down", andar = false, loop = true },
	["dancar303"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_right_up", andar = false, loop = true },
	["dancar304"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center", andar = false, loop = true },
	["dancar305"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center_down", andar = false, loop = true },
	["dancar306"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center_up", andar = false, loop = true },
	["dancar307"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_left", andar = false, loop = true },
	["dancar308"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_left_down", andar = false, loop = true },
	["dancar309"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_left_up", andar = false, loop = true },
	["dancar310"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right", andar = false, loop = true },
	["dancar311"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right_down", andar = false, loop = true },
	["dancar312"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right_up", andar = false, loop = true },
	["dancar313"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center", andar = false, loop = true },
	["dancar314"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_down", andar = false, loop = true },
	["dancar315"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_up", andar = false, loop = true },
	["dancar316"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_left", andar = false, loop = true },
	["dancar317"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_left_down", andar = false, loop = true },
	["dancar318"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_left_up", andar = false, loop = true },
	["dancar319"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_right", andar = false, loop = true },
	["dancar320"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_right_down", andar = false, loop = true },
	["dancar321"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_right_up", andar = false, loop = true },
	["dancar322"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center", andar = false, loop = true },
	["dancar323"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center_down", andar = false, loop = true },
	["dancar324"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center_up", andar = false, loop = true },
	["dancar325"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_left", andar = false, loop = true },
	["dancar326"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_left_down", andar = false, loop = true },
	["dancar327"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_left_up", andar = false, loop = true },
	["dancar328"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_right", andar = false, loop = true },
	["dancar329"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_right_down", andar = false, loop = true },
	["dancar330"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_right_up", andar = false, loop = true },
	["dancar331"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_center", andar = false, loop = true },
	["dancar332"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_center_down", andar = false, loop = true },
	["dancar333"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_center_up", andar = false, loop = true },
	["dancar334"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_left", andar = false, loop = true },
	["dancar335"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_left_down", andar = false, loop = true },
	["dancar336"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_left_up", andar = false, loop = true },
	["dancar337"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_right", andar = false, loop = true },
	["dancar338"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_right_down", andar = false, loop = true },
	["dancar339"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_right_up", andar = false, loop = true },
	["dancar340"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_center", andar = false, loop = true },
	["dancar341"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_center_down", andar = false, loop = true },
	["dancar342"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_center_up", andar = false, loop = true },
	["dancar343"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_left", andar = false, loop = true },
	["dancar344"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_left_down", andar = false, loop = true },
	["dancar345"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_left_up", andar = false, loop = true },
	["dancar346"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_right", andar = false, loop = true },
	["dancar347"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_right_down", andar = false, loop = true },
	["dancar348"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_right_up", andar = false, loop = true },
	["dancar349"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_center", andar = false, loop = true },
	["dancar350"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_center_down", andar = false, loop = true },
	["dancar351"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_center_up", andar = false, loop = true },
	["dancar352"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_left", andar = false, loop = true },
	["dancar353"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_left_down", andar = false, loop = true },
	["dancar354"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_left_up", andar = false, loop = true },
	["dancar355"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_right", andar = false, loop = true },
	["dancar356"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_right_down", andar = false, loop = true },
	["dancar357"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_right_up", andar = false, loop = true },
	["dancar358"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_center_up", andar = false, loop = true },
	["dancar359"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center_down", andar = false, loop = true },
	["dancar360"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", andar = false, loop = true },
	["dancar361"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_left", andar = false, loop = true },
	["dancar362"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_left_down", andar = false, loop = true },
	["dancar363"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_left_up", andar = false, loop = true },
	["dancar364"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_right", andar = false, loop = true },
	["dancar365"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_right_down", andar = false, loop = true },
	["dancar366"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_right_up", andar = false, loop = true },
	["dancar367"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_left", andar = false, loop = true },
	["dancar368"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center_down", andar = false, loop = true },
	["dancar369"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center_up", andar = false, loop = true },
	["dancar370"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_left", andar = false, loop = true },
	["dancar371"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_left_down", andar = false, loop = true },
	["dancar372"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_left_up", andar = false, loop = true },
	["dancar373"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_right", andar = false, loop = true },
	["dancar374"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_right_down", andar = false, loop = true },
	["dancar375"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_right_up", andar = false, loop = true },
	["dancar376"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_center", andar = false, loop = true },
	["dancar377"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_center_down", andar = false, loop = true },
	["dancar378"] = { dict = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_06_base_laz", andar = false, loop = true },
	["dancar379"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", anim = "trans_dance_facedj_hi_to_li_07_v1_female^6", andar = false, loop = true },
	["dancar380"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@", anim = "trans_dance_facedj_hi_to_mi_11_v1_female^6", andar = false, loop = true },
	["dancar381"] = { dict = "anim@mp_player_intupperbanging_tunes", anim = "idle_a", andar = true, loop = true },
	["dancar382"] = { dict = "anim@mp_player_intcelebrationmale@cats_cradle", anim = "cats_cradle", andar = false, loop = true },
	["dancar383"] = { dict = "anim@mp_player_intcelebrationfemale@raise_the_roof", anim = "raise_the_roof", andar = false, loop = true },
	["dancar384"] = { dict = "anim@mp_player_intcelebrationfemale@uncle_disco", anim = "uncle_disco", andar = false, loop = true },
	["dancar385"] = { dict = "anim@amb@nightclub@dancers@tale_of_us_entourage@", anim = "mi_dance_prop_13_v2_male^4", andar = false, loop = true },
	["dancar386"] = { dict = "anim@amb@nightclub@dancers@dixon_entourage@", anim = "mi_dance_facedj_15_v1_male^4", andar = false, loop = true },
	["dancar387"] = { dict = "anim@amb@nightclub@dancers@crowddance_single_props@", anim = "hi_dance_prop_09_v1_male^6", andar = false, loop = true },
	["dancar388"] = { dict = "special_ped@mountain_dancer@monologue_1@monologue_1a", anim = "mtn_dnc_if_you_want_to_get_to_heaven", andar = false, loop = true },
	["dancar389"] = { dict = "special_ped@mountain_dancer@monologue_4@monologue_4a", anim = "mnt_dnc_verse", andar = false, loop = true },
	["dancar390"] = { dict = "mini@strip_club@idles@dj@idle_04", anim = "idle_04", andar = false, loop = true },
	["dancar391"] = { dict = "timetable@tracy@ig_5@idle_b", anim = "idle_e", andar = false, loop = true },
	["dancar392"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@low_intensity", anim = "li_dance_crowd_17_v1_male^6", andar = false, loop = true },
	["dancar393"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_med_intensity", anim = "trans_dance_facedj_mi_to_li_09_v1_male^6", andar = false, loop = true },
	["dancar394"] = { dict = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_med_intensity", anim = "trans_crowd_prop_mi_to_li_11_v1_male^6", andar = false, loop = true },
	["dancar395"] = { dict = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", anim = "hi_dance_prop_13_v1_male^6", andar = false, loop = true },
	["dancar396"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_low_intensity", anim = "trans_dance_facedj_li_to_hi_07_v1_male^6", andar = false, loop = true },
	["dancar397"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^6", andar = false, loop = true },
	["dancar398"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", anim = "trans_dance_facedj_hi_to_li_09_v1_male^6", andar = false, loop = true },
	["dancar399"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^6", andar = false, loop = true },
	
	["finger"] = { dict = "anim@mp_player_intselfiethe_bird", anim = "idle_a", andar = true, loop = false },
	["finger2"] = { dict = "anim@mp_player_intupperfinger", anim = "idle_a", andar = true, loop = false },
	["facepalm"] = { dict = "anim@mp_player_intupperface_palm", anim = "idle_a", andar = true, loop = false },
	["cruzar3"] = { dict = "missfbi_s4mop", anim = "guard_idle_a", andar = true, loop = true },
	["cruzar4"] = { dict = "oddjobs@assassinate@construction@", anim = "unarmed_fold_arms", andar = true, loop = false },
	["cruzar5"] = { dict = "rcmnigel1a_band_groupies", anim = "base_m2", andar = true, loop = true },
	["damn"] = { dict = "gestures@m@standing@casual", anim = "gesture_damn", andar = true, loop = false },
	["fail"] = { dict = "random@car_thief@agitated@idle_a", anim = "agitated_idle_a", andar = true, loop = false },
	["holster"] = { dict = "move_m@intimidation@cop@unarmed", anim = "idle", andar = true, loop = true },
	["guard"] = { dict = "rcmepsilonism8", anim = "base_carrier", andar = true, loop = true },
	["cheer"] = { dict = "amb@world_human_cheering@male_a", anim = "base", andar = true, loop = false },
	["bum"] = { dict = "amb@lo_res_idles@", anim = "world_human_bum_slumped_left_lo_res_base", andar = false, loop = true },
	["copcrowd"] = { dict = "amb@code_human_police_crowd_control@idle_a", anim = "idle_a", andar = false, loop = false },
	["copcrowd2"] = { dict = "amb@code_human_police_crowd_control@idle_b", anim = "idle_d", andar = false, loop = false },
	["shotbar"] = { dict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@drunk", anim = "drink", andar = false, loop = false },
	["drunkbaridle"] = { dict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@drunk", anim = "idle", andar = false, loop = false },
	["dj3"] = { dict = "anim@amb@nightclub@djs@dixon@", anim = "dixn_idle_cntr_b_dix", andar = false, loop = true },
	["dj4"] = { dict = "anim@amb@nightclub@djs@dixon@", anim = "dixn_idle_cntr_e_dix", andar = false, loop = true },
	["handshake"] = { dict = "mp_ped_interaction", anim = "handshake_guy_a", andar = false, loop = false },
	["handshake2"] = { dict = "mp_ped_interaction", anim = "handshake_guy_b", andar = false, loop = false },
	["bro"] = { dict = "mp_ped_interaction", anim = "hugs_guy_b", andar = false, loop = false },
	["baseball"] = { dict = "anim@arena@celeb@flat@paired@no_props@", anim = "baseball_a_player_a", andar = false, loop = false },
	["baseballthrow"] = { dict = "anim@arena@celeb@flat@paired@no_props@", anim = "baseball_a_player_b", andar = false, loop = false },
	["stickupscared"] = { dict = "missminuteman_1ig_2", anim = "handsup_base", andar = true, loop = true },
	["cop2"] = { dict = "amb@code_human_police_investigate@idle_a", anim = "idle_b", andar = true, loop = false },
	["me"] = { dict = "gestures@f@standing@casual", anim = "gesture_me_hard", andar = true, loop = false },
	["nosepick"] = { dict = "anim@mp_player_intcelebrationfemale@nose_pick", anim = "nose_pick", andar = false, loop = false },
	["noway"] = { dict = "gestures@m@standing@casual", anim = "gesture_no_way", andar = false, loop = false },
	["outofbreath"] = { dict = "re@construction", anim = "out_of_breath", andar = false, loop = false },
	["whistle"] = { dict = "taxi_hail", anim = "hail_taxi", andar = true, loop = false },
	["petting"] = { dict = "creatures@rottweiler@tricks@", anim = "petting_franklin", andar = false, loop = false },
	["slide"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_a_player_a", andar = false, loop = false },
	["slide2"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_b_player_a", andar = false, loop = false },
	["slide3"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_c_player_a", andar = false, loop = false },
	["slugger"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "slugger_a_player_a", andar = false, loop = false },
	["bow2"] = { dict = "anim@arena@celeb@podium@no_prop@", anim = "regal_a_1st", andar = false, loop = false },
	["golfswing"] = { dict = "rcmnigel1d", anim = "swing_a_mark", andar = false, loop = false },
	["twerk"] = { dict = "switch@trevor@mocks_lapdance", anim = "001443_01_trvs_28_idle_stripper", andar = false, loop = true },
	["superhero2"] = { dict = "rcmbarry", anim = "base", andar = false, loop = true },
	["karate"] = { dict = "anim@mp_player_intcelebrationfemale@karate_chops", anim = "karate_chops", andar = false, loop = false },
	["hiking"] = { dict = "move_m@hiking", anim = "idle", andar = true, loop = true },
	["jazzhands"] = { dict = "anim@mp_player_intcelebrationfemale@jazz_hands", anim = "jazz_hands", andar = false, loop = true },
	["trotar2"] = { dict = "amb@world_human_jog_standing@female@idle_a", anim = "idle_a", andar = false, loop = true },
	["jumpingjacks"] = { dict = "timetable@reunited@ig_2", anim = "jimmy_getknocked", andar = false, loop = true },
	["agachar"] = { dict = "amb@world_human_bum_wash@male@low@idle_a", anim = "idle_a", andar = false, loop = true },
	["bater"] = { dict = "timetable@jimmy@doorknock@", anim = "knockdoor_idle", andar = true, loop = true },
	["bater2"] = { dict = "missheistfbi3b_ig7", anim = "lift_fibagent_loop", andar = false, loop = true },
	["lean"] = { dict = "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", anim = "idle_a", andar = false, loop = true },
	["lean2"] = { dict = "amb@world_human_leaning@male@wall@back@foot_up@idle_a", anim = "idle_a", andar = false, loop = true },
	["leanflirt"] = { dict = "random@street_race", anim = "_car_a_flirt_girl", andar = false, loop = true },
	["leanbar2"] = { dict = "amb@prop_human_bum_shopping_cart@male@idle_a", anim = "idle_c", andar = false, loop = true },

	["dogdeitar"] = { dict = "creatures@rottweiler@amb@sleep_in_kennel@", anim = "sleep_in_kennel", andar = false, loop = true },
	["doglatir"] = { dict = "creatures@rottweiler@amb@world_dog_barking@idle_a", anim = "idle_a", andar = false, loop = true },
	["dogsentar"] = { dict = "creatures@rottweiler@amb@world_dog_sitting@base", anim = "base", andar = false, loop = true },
	["dogsentar2"] = { dict = "creatures@rottweiler@in_vehicle@4x4", anim = "lean_back", andar = false, loop = true },
	["dogcocar"] = { dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a", anim = "idle_a", andar = false, loop = true },
	["dogatencao1"] = { dict = "creatures@rottweiler@indication@", anim = "indicate_high", andar = false, loop = true },
	["dogatencao2"] = { dict = "creatures@rottweiler@indication@", anim = "indicate_ahead", andar = false, loop = true },
	["dogatencao3"] = { dict = "creatures@rottweiler@indication@", anim = "indicate_low", andar = false, loop = true },
	["dogpedir"] = { dict = "creatures@rottweiler@tricks@", anim = "beg_loop", andar = false, loop = true },
	["dogpedir2"] = { dict = "creatures@rottweiler@melee@", anim = "melee", andar = false, loop = false },
	["dogdarpata"] = { dict = "creatures@rottweiler@tricks@", anim = "paw_right_loop", andar = false, loop = true },
	["dogcarinho"] = { dict = "creatures@rottweiler@tricks@", anim = "petting_chop", andar = false, loop = false },
	["dogfingirmorto"] = { dict = "creatures@rottweiler@move", anim = "dead_left", andar = false, loop = true },
	["dogpoop"] = { dict = "creatures@rottweiler@move", anim = "dump_loop", andar = false, loop = false },
	["dogxixi"] = { dict = "creatures@rottweiler@move", anim = "pee_right_idle", andar = false, loop = false },
	["dogpegar"] = { dict = "creatures@rottweiler@move", anim = "fetch_pickup_facial", prop = 'w_am_baseball', flag = 49, mao = 46240, altura=0.100, pos1=0.005, pos2=0.05, pos3=80.0, pos4=0.0, pos5=110.0},
	["dogsecar"] = { dict = "creatures@rottweiler@amb@world_dog_barking@idle_a", anim = "idle_C", andar = false, loop = false },
	
	["catatencao"] = { dict = "creatures@cat@move", anim = "idle_dwn", andar = false, loop = true },
	["catlevantar"] = { dict = "creatures@cat@amb@peyote@enter", anim = "enter", andar = false, loop = false },
	["catdeitar"] = { dict = "creatures@cat@amb@world_cat_sleeping_ground@base", anim = "base", andar = false, loop = true },
	["catpular"] = { dict = "creatures@cat@amb@world_cat_sleeping_ground@exit", anim = "exit_panic", andar = false, loop = false },
	
	["alongar3"] = { dict = "rcmfanatic1maryann_stretchidle_b", anim = "idle_e", andar = false, loop = true },
	["argue"] = { dict = "misscarsteal4@actor", anim = "actor_berating_loop", andar = true, loop = true },
	["bird"] = { dict = "random@peyote@bird", anim = "wakeup", andar = true, loop = true },
	["blowkiss"] = { dict = "anim@mp_player_intcelebrationfemale@blow_kiss", anim = "blow_kiss", andar = true, loop = true },
	["bringiton"] = { dict = "misscommon@response", anim = "bring_it_on", andar = true, loop = false },
	["chill"] = { dict = "switch@trevor@scares_tramp", anim = "trev_scares_tramp_idle_tramp", andar = false, loop = true },
	["clapangry"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_a_player_a", andar = true, loop = true },
	["comeatmebro"] = { dict = "mini@triathlon", anim = "want_some_of_this", andar = true, loop = true },
	["crawl"] = { dict = "move_injured_ground", anim = "front_loop", andar = false, loop = true },
	["flip"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "cap_a_player_a", andar = false, loop = false },
	["flip2"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "flip_a_player_a", andar = false, loop = false },
	--["meditate"] = { dict = "rcmcollect_paperleadinout@", anim = "meditiate_idle", andar = false, loop = true },
	["peace2"] = { dict = "anim@mp_player_intupperpeace", anim = "idle_a", andar = true, loop = true },
	["prone"] = { dict = "missfbi3_sniping", anim = "prone_dave", andar = false, loop = true },
	["inspect"] = { dict = "random@train_tracks", anim = "idle_e", andar = false, loop = false },
	["sentar7"] = { dict = "anim@amb@business@bgen@bgen_no_work@", anim = "sit_phone_phoneputdown_idle_nowork", andar = false, loop = true },
	["sitchair"] = { dict = "timetable@ron@ig_5_p3", anim = "ig_5_p3_base", andar = false, loop = true },
	["sitchair2"] = { dict = "timetable@reunited@ig_10", anim = "base_amanda", andar = false, loop = true },
	["sitchair3"] = { dict = "timetable@ron@ig_3_couch", anim = "base", andar = false, loop = true },
	["sitchair4"] = { dict = "timetable@jimmy@mics3_ig_15@", anim = "mics3_15_base_tracy", andar = false, loop = true },
	["sitchair5"] = { dict = "timetable@maid@couch@", anim = "base", andar = false, loop = true },
	["superhero"] = { dict = "rcmbarry", anim = "base", andar = true, loop = true },
	["type"] = { dict = "anim@heists@prison_heiststation@cop_reactions", anim = "cop_b_idle", andar = true, loop = true },
	["yeah"] = { dict = "anim@mp_player_intupperair_shagging", anim = "idle_a", andar = true, loop = true },
	["sexo"] = { dict = "rcmpaparazzo_2", anim = "shag_loop_poppy", andar = false, loop = true },
	["sexo2"] = { dict = "rcmpaparazzo_2", anim = "shag_loop_a", andar = false, loop = true },
	["sexo3"] = { dict = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging", andar = false, loop = true },
	["sexo4"] = { dict = "oddjobs@towing", anim = "m_blow_job_loop", andar = false, loop = true, cars = true },
	["sexo5"] = { dict = "oddjobs@towing", anim = "f_blow_job_loop", andar = false, loop = true, cars = true },
	["sexo6"] = { dict = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female", andar = false, loop = true, cars = true },
	["sentar"] = { anim = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },
	["sentar2"] = { dict = "amb@world_human_picnic@male@base", anim = "base", andar = false, loop = true },
	["sentar3"] = { dict = "anim@heists@fleeca_bank@ig_7_jetski_owner", anim = "owner_idle", andar = false, loop = true },
	["sentar4"] = { dict = "amb@world_human_stupor@male@base", anim = "base", andar = false, loop = true },
	["sentar5"] = { dict = "amb@world_human_picnic@female@base", anim = "base", andar = false, loop = true },
	["sentar6"] = { dict = "anim@amb@nightclub@lazlow@lo_alone@", anim = "lowalone_base_laz", andar = false, loop = true },
	["beijar"] = { dict = "mp_ped_interaction", anim = "kisses_guy_a", andar = false, loop = false },
	["striper"] = { dict = "mini@strip_club@idles@stripper", anim = "stripper_idle_02", andar = false, loop = true },
	["escutar"] = { dict = "mini@safe_cracking", anim = "idle_base", andar = false, loop = true },
	["alongar"] = { dict = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e", andar = false, loop = true },
	["dj"] = { dict = "anim@mp_player_intupperdj", anim = "idle_a", andar = true, loop = true },
	["rock"] = { dict = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar", andar = false, loop = true },
	["rock2"] = { dict = "mp_player_introck", anim = "mp_player_int_rock", andar = false, loop = false },
	["abracar"] = { dict = "mp_ped_interaction", anim = "hugs_guy_a", andar = false, loop = false },
	["abracar2"] = { dict = "mp_ped_interaction", anim = "kisses_guy_b", andar = false, loop = false },
	["peitos"] = { dict = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b", andar = false, loop = false },
	["espernear"] = { dict = "missfam4leadinoutmcs2", anim = "tracy_loop", andar = false, loop = true },
	["arrumar"] = { dict = "anim@amb@business@coc@coc_packing_hi@", anim = "full_cycle_v1_pressoperator", andar = false, loop = true },
	["bebado"] = { dict = "missfam5_blackout", anim = "pass_out", andar = false, loop = false },
	["bebado2"] = { dict = "missheist_agency3astumble_getup", anim = "stumble_getup", andar = false, loop = false },
	["bebado3"] = { dict = "missfam5_blackout", anim = "vomit", andar = false, loop = false },
	["yoga"] = { dict = "missfam5_yoga", anim = "f_yogapose_a", andar = false, loop = true },
	["yoga2"] = { dict = "amb@world_human_yoga@male@base", anim = "base_a", andar = false, loop = true },
	["abdominal"] = { dict = "amb@world_human_sit_ups@male@base", anim = "base", andar = false, loop = true },
	["bixa"] = { anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" },
	["britadeira"] = { dict = "amb@world_human_const_drill@male@drill@base", anim = "base", prop = "prop_tool_jackham", flag = 15, mao = 28422 },
	["cerveja"] = { anim = "WORLD_HUMAN_PARTYING" },
	["churrasco"] = { anim = "PROP_HUMAN_BBQ" },
	["consertar"] = { anim = "WORLD_HUMAN_WELDING" },
	["bracos"] = { dict = "anim@heists@heist_corona@single_team", anim = "single_team_loop_boss", andar = true, loop = true },
	["postura3"] = { dict = "mini@strip_club@idles@bouncer@base", anim = "base", andar = true, loop = true },
	["dedos"] = { dict = "anim@mp_player_intupperfinger", anim = "idle_a_fp", andar = true, loop = true },
	["dormir"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_react_die_loop_ped_a", andar = false, loop = true },
	["dormir2"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_react_die_loop_ped_e", andar = false, loop = true },
	["dormir3"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_react_die_loop_ped_h", andar = false, loop = true },
	["encostar"] = { dict = "amb@lo_res_idles@", anim = "world_human_lean_male_foot_up_lo_res_base", andar = false, loop = true },
	["encostar2"] = { dict = "bs_2a_mcs_10-0", anim = "hc_gunman_dual-0", andar = false, loop = true },
	["estatua"] = { dict = "amb@world_human_statue@base", anim = "base", andar = false, loop = true },
	["flexao"] = { dict = "amb@world_human_push_ups@male@base", anim = "base", andar = false, loop = true },
	["fumar"] = { anim = "WORLD_HUMAN_SMOKING" },
	["fumar2"] = { anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" },
	["fumar3"] = { anim = "WORLD_HUMAN_AA_SMOKE" },
	["fumar4"] = { anim = "WORLD_HUMAN_SMOKING_POT" },
	["fumar5"] = { dict = "amb@world_human_aa_smoke@male@idle_a", anim = "idle_c", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	["fumar6"] = { dict = "amb@world_human_aa_smoke@male@idle_a", anim = "idle_b", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	["fumar7"] = { dict = "amb@world_human_smoking@female@idle_a", anim = "idle_b", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	["malhar"] = { dict = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base", prop = "prop_curl_bar_01", flag = 49, mao = 28422 },
	["malhar2"] = { dict = "amb@prop_human_muscle_chin_ups@male@base", anim = "base", andar = false, loop = true },
	["martelo"] = { dict = "amb@world_human_hammering@male@base", anim = "base", prop = "prop_tool_hammer", flag = 49, mao = 28422 },
	["pescar"] = { dict = "amb@world_human_stand_fishing@base", anim = "base", prop = "prop_fishing_rod_01", flag = 49, mao = 60309 },
	["pescar2"] = { dict = "amb@world_human_stand_fishing@idle_a", anim = "idle_c", prop = "prop_fishing_rod_01", flag = 49, mao = 60309 },
	["plantar"] = { dict = "amb@world_human_gardener_plant@female@base", anim = "base_female", andar = false, loop = true },
	["plantar2"] = { dict = "amb@world_human_gardener_plant@female@idle_a", anim = "idle_a_female", andar = false, loop = true },
	["procurar"] = { dict = "amb@world_human_bum_wash@male@high@base", anim = "base", andar = false, loop = true },
	["soprador"] = { dict = "amb@code_human_wander_gardener_leaf_blower@base", anim = "static", prop = "prop_leaf_blower_01", flag = 49, mao = 28422 },
	["soprador2"] = { dict = "amb@code_human_wander_gardener_leaf_blower@idle_a", anim = "idle_a", prop = "prop_leaf_blower_01", flag = 49, mao = 28422 },
	["soprador3"] = { dict = "amb@code_human_wander_gardener_leaf_blower@idle_a", anim = "idle_b", prop = "prop_leaf_blower_01", flag = 49, mao = 28422 },
	["tragar"] = { anim = "WORLD_HUMAN_DRUG_DEALER" },
	["trotar"] = { dict = "amb@world_human_jog_standing@male@fitidle_a", anim = "idle_a", andar = false, loop = true },
	["esquentar"] = { anim = "WORLD_HUMAN_STAND_FIRE" },
	["tablet"] = { dict = "amb@code_human_in_bus_passenger_idles@female@tablet@base", anim = "base", prop = "prop_cs_tablet", flag = 50, mao = 28422 },
	["selfie"] = { dict = "cellphone@self", anim = "selfie_in_from_text", prop = "prop_npc_phone_02", flag = 50, mao = 28422 },
	["selfie2"] = { dict = "cellphone@", anim = "cellphone_text_read_base_cover_low", prop = "prop_npc_phone_02", flag = 50, mao = 28422 },
	["mecanico"] = { dict = "amb@world_human_vehicle_mechanic@male@idle_a", anim = "idle_a", andar = false, loop = true },
	["mecanico2"] = { dict = "mini@repair", anim = "fixing_a_player", andar = false, loop = true },
	["mecanico3"] = { dict = "mini@repair", anim = "fixing_a_ped", andar = false, loop = true },
	["mecanico4"] = { dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", andar = false, loop = true },
	["mecanico5"] = { dict = "amb@prop_human_movie_bulb@base", anim = "base", andar = true, loop = true },
	["xiu"] = { dict = "anim@mp_player_intincarshushbodhi@ds@", anim = "idle_a_fp", andar = true, loop = true },
	["tapa"] = { dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_front_slap", andar = false, loop = false },
	["hotwired"] = { dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", andar = true, loop = true, cars = true },
	["pano2"] = { dict = "timetable@floyd@clean_kitchen@base", anim = "base", prop = "prop_rag_01", flag = 49, mao = 28422, extra = function()
		local vehicle = vRP.nearVehicle(7)
		if vehicle then
			TriggerEvent("Progress",10000)
			SetTimeout(10000,function()
				SetVehicleDirtLevel(vehicle,0.0)
				vRP.removeObjects("one")
			end)
		end
	end },
	["pano"] = { dict = "timetable@maid@cleaning_window@base", anim = "base", prop = "prop_rag_01", flag = 49, mao = 28422, extra = function()
		local vehicle = vRP.nearVehicle(7)
		if vehicle then
			TriggerEvent("Progress",10000)
			SetTimeout(10000,function()
				SetVehicleDirtLevel(vehicle,0.0)
				vRP.removeObjects("one")
			end)
		end
	end },
	-- ["checkinskyz"] = { dict = "anim@gangops@morgue@table@", anim = "body_search", andar = false, loop = true, extra = function()
	-- 	local ped = PlayerPedId()
	-- 	local coords = GetEntityCoords(ped)
	-- 	for k,v in pairs(beds) do
	-- 		local object = GetClosestObjectOfType(coords["x"],coords["y"],coords["z"],0.9,v[1],0,0,0)
	-- 		if DoesEntityExist(object) then
	-- 			local heading = GetEntityHeading(object)
	-- 			local objCoords = GetEntityCoords(ped)
	-- 			local health = GetEntityHealth(ped)
	-- 			local armour = GetPedArmour(ped)

	-- 			NetworkResurrectLocalPlayer(objCoords["x"],objCoords["y"],objCoords["z"] + v[2],heading,true,false)
	-- 			SetEntityHealth(ped,health)
	-- 			SetPedArmour(ped,armour)

	-- 			TriggerEvent("resetBleeding")
	-- 			TriggerEvent("resetDiagnostic")
	-- 			TriggerEvent("cancelando",true)

	-- 			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + v[2],1,0,0,0)
	-- 			SetEntityHeading(ped,heading + v[3] - 180.0)
	-- 			tratamento = true
	-- 			break
	-- 		end
	-- 	end
	-- end },
	["cruzar"] = { dict = "random@street_race", anim = "_car_b_lookout", andar = true, loop = true },
	["cruzar2"] = { dict = "anim@amb@nightclub@peds@", anim = "rcmme_amanda1_stand_loop_cop", andar = true, loop = true },
	["wait"] = { dict = "random@shop_tattoo", anim = "_idle_a", andar = true, loop = true },
	["wait2"] = { dict = "rcmnigel1cnmt_1c", anim = "base", andar = true, loop = true },
	["wait3"] = { dict = "rcmjosh1", anim = "idle", andar = true, loop = true },
	["wait4"] = { dict = "timetable@amanda@ig_3", anim = "ig_3_base_tracy", andar = true, loop = true },
	["wait5"] = { dict = "misshair_shop@hair_dressers", anim = "keeper_base", andar = true, loop = true },
	["wait6"] = { dict = "jh_1_ig_3-2", anim = "cs_jewelass_dual-2", andar = true, loop = true },
	["knucklecrunch"] = { dict = "anim@mp_player_intcelebrationfemale@knuckle_crunch", anim = "knuckle_crunch", andar = true, loop = false },
	["leanside"] = { dict = "misscarstealfinalecar_5_ig_1", anim = "waitloop_lamar", andar = true, loop = true },
	["no2"] = { dict = "anim@heists@ornate_bank@chat_manager", anim = "fail", andar = true, loop = false },
	["ok"] = { dict = "anim@mp_player_intselfiedock", anim = "idle_a", andar = true, loop = false },
	["screwyou"] = { dict = "misscommon@response", anim = "screw_you", andar = true, loop = false },
	["think"] = { dict = "misscarsteal4@aliens", anim = "rehearsal_base_idle_director", andar = true, loop = true },
	["think2"] = { dict = "missheist_jewelleadinout", anim = "jh_int_outro_loop_a", andar = true, loop = true },
	["think3"] = { dict = "timetable@tracy@ig_8@base", anim = "base", andar = true, loop = true },
	["wave"] = { dict = "random@mugging5", anim = "001445_01_gangintimidation_1_female_idle_b", andar = true, loop = true },
	["wave2"] = { dict = "friends@fra@ig_1", anim = "over_here_idle_a", andar = true, loop = true },
	["wave3"] = { dict = "friends@frj@ig_1", anim = "wave_e", andar = true, loop = true },
	["gangsign"] = { dict = "mp_player_int_uppergang_sign_a", anim = "mp_player_int_gang_sign_a", andar = true, loop = true },
	["gangsign2"] = { dict = "mp_player_int_uppergang_sign_b", anim = "mp_player_int_gang_sign_b", andar = true, loop = true },
	["flipoff"] = { dict = "anim@arena@celeb@podium@no_prop@", anim = "flip_off_c_1st", andar = true, loop = true },
	["bow"] = { dict = "anim@arena@celeb@podium@no_prop@", anim = "regal_c_1st", andar = true, loop = false },
	["headbutt"] = { dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_front_headbutt", andar = true, loop = false },
	["airplane"] = { dict = "missfbi1", anim = "ledge_loop", andar = true, loop = true },
	["cough"] = { dict = "timetable@gardener@smoking_joint", anim = "idle_cough", andar = true, loop = true },
	["stretch"] = { dict = "mini@triathlon", anim = "idle_f", andar = true, loop = true },
	["punching"] = { dict = "rcmextreme2", anim = "loop_punching", andar = true, loop = true },
	["mindcontrol"] = { dict = "rcmbarry", anim = "bar_1_attack_idle_aln", andar = true, loop = true },
	["clown"] = { dict = "rcm_barry2", anim = "clown_idle_0", andar = false, loop = true },
	["clown2"] = { dict = "rcm_barry2", anim = "clown_idle_1", andar = false, loop = true },
	["clown3"] = { dict = "rcm_barry2", anim = "clown_idle_3", andar = false, loop = true },
	["namaste"] = { dict = "timetable@amanda@ig_4", anim = "ig_4_base", andar = false, loop = true },
	["candle"] = { dict = "amb@world_human_drinking@coffee@male@base", anim = "base", prop = "nany_candle", flag = 50, mao = 28422 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("emotes")
AddEventHandler("emotes",function(nome)
	if 1 == 1 then
		local ped = PlayerPedId()

		if animacoes[nome] and not IsPedArmed(ped,6) and not IsPedSwimming(ped) and CheckPetAnimation(nome) then
			if (GetEntityHealth(ped) > 101 or nome == "checkinskyz") and vSERVER.checkInventory() then
				vRP.removeObjects("one")

				if not IsPedInAnyVehicle(ped) and not animacoes[nome]["cars"] then
					if animacoes[nome]["extra"] then
						animacoes[nome].extra()
					end

					if animacoes[nome]["altura"] and animacoes[nome]["anim"] == nil then
						vRP.createObjects("","",animacoes[nome]["prop"],animacoes[nome]["flag"],animacoes[nome]["mao"],animacoes[nome]["altura"],animacoes[nome]["pos1"],animacoes[nome]["pos2"],animacoes[nome]["pos3"],animacoes[nome]["pos4"],animacoes[nome]["pos5"])
					elseif animacoes[nome]["altura"] and animacoes[nome]["anim"] then
						vRP.createObjects(animacoes[nome]["dict"],animacoes[nome]["anim"],animacoes[nome]["prop"],animacoes[nome]["flag"],animacoes[nome]["mao"],animacoes[nome]["altura"],animacoes[nome]["pos1"],animacoes[nome]["pos2"],animacoes[nome]["pos3"],animacoes[nome]["pos4"],animacoes[nome]["pos5"])
					elseif animacoes[nome]["prop"] then
						vRP.createObjects(animacoes[nome]["dict"],animacoes[nome]["anim"],animacoes[nome]["prop"],animacoes[nome]["flag"],animacoes[nome]["mao"])
					elseif animacoes[nome]["dict"] then
						vRP.playAnim(animacoes[nome]["andar"],{animacoes[nome]["dict"],animacoes[nome]["anim"]},animacoes[nome]["loop"])
					else
						vRP.playAnim(false,{ task = animacoes[nome]["anim"] },false)
					end
				else
					if IsPedInAnyVehicle(ped) and animacoes[nome]["cars"] then
						local vehicle = GetVehiclePedIsUsing(ped)

						if (GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,1) == ped) and nome == "sexo4" then
							vRP.playAnim(animacoes[nome]["andar"],{animacoes[nome]["dict"],animacoes[nome]["anim"]},animacoes[nome]["loop"])
						elseif (GetPedInVehicleSeat(vehicle,0) == ped or GetPedInVehicleSeat(vehicle,2) == ped) and (nome == "sexo5" or nome == "sexo6") then
							vRP.playAnim(animacoes[nome]["andar"],{animacoes[nome]["dict"],animacoes[nome]["anim"]},animacoes[nome]["loop"])
						elseif nome == "hotwired" then
							vRP.playAnim(animacoes[nome]["andar"],{animacoes[nome]["dict"],animacoes[nome]["anim"]},animacoes[nome]["loop"])
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if (binoculos or cameras) then
			timeDistance = 1

			local ped = PlayerPedId()
			local scaleform = RequestScaleformMovie("BINOCULARS")
			while not HasScaleformMovieLoaded(scaleform) do
				Wait(1)
			end

			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
			AttachCamToEntity(cam,ped,0.0,0.0,1.0,true)
			SetCamRot(cam,0.0,0.0,GetEntityHeading(ped))
			SetCamFov(cam,fov)
			RenderScriptCams(true,false,0,1,0)

			while (binoculos or cameras) and true do
				Wait(1)

				local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
				CheckInputRotation(cam,zoomvalue)
				HandleZoom(cam)

				if binoculos then
					DrawScaleformMovieFullscreen(scaleform,255,255,255,255)
				end

				if IsPedArmed(PlayerPedId(),6) then
					TriggerServerEvent("inventory:Cancel")
					binoculos = false
					cameras = false
				end
			end

			fov = (fov_max + fov_min) * 0.5
			RenderScriptCams(false,false,0,1,0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam,false)
			SetNightvision(false)
			SetSeethrough(false)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEBINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("useBinoculos")
AddEventHandler("useBinoculos",function()
	binoculos = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEBINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("useCamera")
AddEventHandler("useCamera",function()
	cameras = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("binoculos")
AddEventHandler("binoculos",function()
	if IsEntityPlayingAnim(PlayerPedId(),"amb@world_human_binoculars@male@enter","enter",3) then
		binoculos = true
	else
		binoculos = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("camera")
AddEventHandler("camera",function()
	if IsEntityPlayingAnim(PlayerPedId(),"amb@world_human_paparazzi@male@base","base",3) then
		cameras = true
	else
		cameras = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX * -1.0 * 8.0 * (zoomvalue + 0.1)
		new_x = math.max(math.min(20.0,rotation["x"] + rightAxisY * -1.0 * 8.0 * (zoomvalue + 0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYPED
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckPetAnimation(name) 
	local playerModel = GetEntityModel(GetPlayerPed(-1))
	local pedModels = {
		"a_c_shepherd", "a_c_rottweiler", "a_c_husky", "a_c_poodle", "a_c_pug", "a_c_westy", "a_c_retriever", "huskymaite", "a_c_chop", "a_c_cat_01", "sphynx", "stherzinha", "snoopdog", "dog_policial"
	}

	local petAnimation = {
		"dogdeitar", "doglatir", "dogsentar",
		"dogcocar", "dogatencao1", "dogpedir",
		"dogdarpata", "dogcarinho", "dogsentar2",
		"dogatencao2", "dogatencao3", "dogpedir2",
		"dogfingirmorto", "dogpoop", "dogpegar",
		"dogxixi", "dogsecar", "catatencao",
		"catlevantar", "catdeitar", "catpular"
	}

	if HasValue(petAnimation, name, false) then
		if HasValue(pedModels, playerModel, true) then
			return true
		end
	else 
		return true
	end

	return false
end

function HasValue (tab, val, isPed)
	for index, value in ipairs(tab) do
		if isPed then
			if GetHashKey(value) == val then
					return true
			end
		else
			if value == val then
					return true
			end
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleZoom(cam)
	if IsControlJustPressed(1,241) then
		fov = math.max(fov - 10.0,fov_min)
	end

	if IsControlJustPressed(1,242) then
		fov = math.min(fov + 10.0,fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov - current_fov) < 0.1 then
		fov = current_fov
	end

	SetCamFov(cam,current_fov + (fov - current_fov) * 0.05)
end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADTRATAMENTO
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	local treatmentTimers = GetGameTimer()

-- 	while true do
-- 		if GetGameTimer() >= treatmentTimers then
-- 			treatmentTimers = GetGameTimer() + 2000

-- 			if tratamento then
-- 				local ped = PlayerPedId()
-- 				local health = GetEntityHealth(ped)

-- 				if health < 200 then
-- 					SetEntityHealth(ped,health + 1)
-- 				else
-- 					tratamento = false
-- 					ClearPedBloodDamage(ped)
-- 					TriggerEvent("cancelando",false)
-- 					TriggerEvent("player:blockCommands",false)
-- 					TriggerEvent("Notify","verde","Tratamento concluido.",3000)
-- 				end
-- 			end
-- 		end

-- 		Wait(1000)
-- 	end
-- end)