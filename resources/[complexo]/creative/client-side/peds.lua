-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {
	{ -- Ipiranga // Frentista Norte 3
		distance = 30,
		coords = { 160.82,6581.33,31.98,226.78 },
		model = { 0xC3114CB1,"frentista" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Frentista Norte 2
		distance = 30,
		coords = { 166.3,6586.77,31.98,226.78 },
		model = { 0xC3114CB1,"frentista" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Frentista Norte 1
		distance = 30,
		coords = { 171.7,6592.07,31.98,229.61 },
		model = { 0xC3114CB1,"frentista" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Frentista Sul 3
		distance = 30,
		coords = { -2098.29,-326.29,13.13,79.38 },
		model = { 0xC3114CB1,"frentista" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Frentista Sul 2
		distance = 30,
		coords = { -2097.6,-318.75,13.13,82.21 },
		model = { 0xC3114CB1,"frentista" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Frentista Sul 1
		distance = 30,
		coords = { -2096.75,-311.06,13.13,79.38 },
		model = { 0xC3114CB1,"frentista" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Caixa Sul
		distance = 30,
		coords = { -2066.69,-313.7,13.48,79.38 },
		model = { 0xC3114CB1,"atendente" },
		anim = { "mini@strip_club@idles@bouncer@base","base" }
	},
	{ -- Ipiranga // Caixa Norte
		distance = 30,
		coords = { 147.45,6610.57,32.08,45.36 },
		model = { 0xC3114CB1,"atendente" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Fred
		distance = 30,
		coords = { -2068.7,-333.73,13.31,172.92 },
		model = { 0x431FC24C,"fred" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Fred
		distance = 30,
		coords = { -2068.7,-333.73,13.31,172.92 },
		model = { 0x431FC24C,"fred" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Escritorio // Diagram
		distance = 30,
		coords = { -72.11,-814.43,243.38,158.75 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Entregas AmPm
		distance = 30,
		coords = { -2067.2,-311.44,13.19,0.0 },
		model = { 0xC3114CB1,"mp_f_freemode_03" },
		anim = { "mini@strip_club@idles@bouncer@base","base" }
	},
	{ -- Ipiranga // Thiago Camilo (Race)
		distance = 100,
		coords = { 4208.08,8038.67,97.09,147.41 },
		model = { 0xC3114CB1,"ipirangam1" },
		anim = { "random@mugging5","001445_01_gangintimidation_1_female_idle_b" }
	},
	{ -- Ipiranga // Cesar Ramos (Race)
		distance = 100,
		coords = { 4207.05,8039.4,97.09,153.08 },
		model = { 0xC3114CB1,"ipirangam2" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Mecânico Saída [2] (Race)
		distance = 100,
		coords = { 4227.75,8027.2,93.8,153.08 },
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ipiranga // Mecânico Saída [1] (Race)
		distance = 100,
		coords = { 4225.22,8028.43,93.85,150.24 },
		model = { 0xF7A74139,"mp_m_waremech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Banco do Brasil
		distance = 30,
		coords = { -1102.62,-1510.95,-9.25,28.35 },
		model = { 0xB7C61032,"a_f_y_business_04" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ilegal
		distance = 30,
		coords = { 1252.49,-2561.85,42.71,42.52 },
		model = { 0xBE20FA04,"s_m_y_xmech_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- MoradorFav01
		distance = 10,
		coords = { 1266.52,-296.63,80.79,8.51 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- MoradorFav02
		distance = 10,
		coords = { 1804.26,429.72,173.01,17.01 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- MoradorFav03
		distance = 10,
		coords = { 2209.56,125.52,231.68,192.76 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- MoradorFav04
		distance = 10,
		coords = { 2645.64,2743.5,41.38,11.34 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- MoradorFav05
		distance = 10,
		coords = { 60.74,1264.36,270.74,303.31 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Machado // Cozinheiro
		distance = 30,
		coords = { -443.86,-34.02,46.22,79.38 },
		model = { 0x0F977CEB,"s_m_y_chef_01" },
		anim = { "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@drunk","idle" }
	},
	{ -- Ilegal // Machado Bar (Shop 1)
		distance = 100,
		coords = { -437.57,-29.6,46.22,85.04 },
		model = { 0xE497BBEF,"s_m_y_dealer_01" },
		anim = { "missheist_jewelleadinout","jh_int_outro_loop_a" }
	},
	{ -- Ilegal // Machado Bar (Shop 2)
		distance = 100,
		coords = { -444.21,-22.57,46.22,269.3 },
		model = { 0x07DD91AC,"a_m_m_eastsa_02" },
		anim = { "amb@world_human_leaning@male@wall@back@foot_up@idle_a","idle_a" }
	},
	{ -- Ilegal // Machado Bar (Shop 3)
		distance = 100,
		coords = { -440.91,-22.7,46.22,85.04 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "misscarstealfinalecar_5_ig_1","waitloop_lamar" }
	},
	{ -- Ilegal // Machado Bar (Shop 4)
		distance = 100,
		coords = { -438.13,-36.03,46.22,269.3 },
		model = { 0x22911304,"s_m_y_doorman_01" },
		anim = { "anim@amb@nightclub@peds@","rcmme_amanda1_stand_loop_cop" }
	},
	{ -- Ilegal
		distance = 30,
		coords = { 472.08,-1308.52,29.23,206.93 },
		model = { 0xBE20FA04,"s_m_y_xmech_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 1338.37,4359.53,44.37,320.32 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Bracho
		distance = 10,
		coords = { 1956.72,3826.52,32.05,209.77 },
		model = { 0xB9DD0300,"g_m_m_chiboss_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Weapons
		distance = 10,
		coords = { 840.77,-2885.63,11.44,269.3 },
		model = { 0xB9DD0300,"g_m_m_chiboss_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 464.43,-789.48,27.35,2.84 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Police comanf garagem
		distance = 30,  
		coords = { 372.43,793.14,187.49,187.09 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 30,
		coords = { 1840.79,2538.28,45.66,308.98 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 30,
		coords = { 382.25,-1617.07,29.28,232.45 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 30,
		coords = { 864.28,-1337.52,26.02,85.04 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 30,
		coords = { 1840.78,2545.84,45.66,243.78 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 30,
		coords = { -479.48,6011.12,31.29,175.75 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 30,
		coords = { -459.37,6016.01,31.49,42.52 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 30,
		coords = { 1860.95,3685.79,34.27,167.25 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 30,
		coords = { 1856.7,3683.41,34.27,161.58 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 30,
		coords = { -956.43,-2056.65,9.4,150.24 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
	distance = 30,
	coords = { -942.88,-2021.01,11.32,85.04 },
	model = { 0x15F8700D,"s_f_y_cop_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Police
		distance = 30,
		coords = { 382.17,-1633.64,29.28,323.15 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Hospital Café
		distance = 30,
		coords = { -690.26,322.21,83.09,82.21 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Hospital Pharmacy
		distance = 30,
		coords = { -665.76,321.35,83.09,226.78 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Hospital Recepção
		distance = 30,
		coords = { -676.2,327.8,83.09,221.11 },
		model = { 0xD47303AC,"s_m_m_doctor_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Hospital Store 2
		distance = 30,
		coords = { -680.53,329.07,88.01,266.46 },
		model = { 0xAB594AB6,"s_f_y_scrubs_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic Store
		distance = 30,
		coords = { -676.25,334.77,83.09,172.92 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 30,
		coords = { -271.7,6321.75,32.42,0.0 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 30,
		coords = { -253.92,6339.42,32.42,5.67 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 30,
		coords = { 1193.81,-1486.91,34.85,226.78 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 30,
		coords = { 1207.61,-1486.89,34.85,147.41 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 30,
		coords = { 1841.83,3674.84,34.27,172.92 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 30,
		coords = { 1836.32,3671.52,34.27,260.79 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- AirForce
		distance = 50,
		coords = { -940.79,-2960.2,13.93,59.53 },
		model = { 0x3AE4A33B,"ig_fbisuit_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Favela01
		distance = 10,
		coords = { 1403.17,-188.18,161.51,51.03 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Favela02
		distance = 10,
		coords = { 1732.54,383.23,235.75,286.3 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Favela03
		distance = 10,
		coords = { 2203.23,59.5,240.43,348.67 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Favela04
		distance = 10,
		coords = { 3002.56,3035.98,105.73,28.35 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Favela05
		distance = 10,
		coords = { -22.16,1277.52,295.66,56.7 },
		model = { 0xE52E126C,"ig_ramp_gang" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 24.49,-1346.08,29.49,272.13 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 2556.04,380.89,108.61,0.0 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1164.82,-323.63,69.2,99.22 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -706.16,-914.55,19.21,90.71 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -47.39,-1758.63,29.42,51.03 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 372.86,327.53,103.56,257.96 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { -3243.38,1000.11,12.82,0.0 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1728.39,6416.21,35.03,246.62 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 549.2,2670.22,42.16,96.38 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1959.54,3741.01,32.33,303.31 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 2677.07,3279.95,55.23,334.49 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1697.35,4923.46,42.06,328.82 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { -1819.55,793.51,138.08,133.23 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1392.03,3606.1,34.98,204.1 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -2966.41,391.59,15.05,85.04 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -3040.04,584.22,7.9,19.85 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1134.33,-983.09,46.4,277.8 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1165.26,2710.79,38.15,178.59 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -1486.77,-377.56,40.15,133.23 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -1221.42,-907.91,12.32,31.19 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 1692.28,3760.94,34.69,229.61 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 253.79,-50.5,69.94,68.04 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 842.41,-1035.28,28.19,0.0 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -331.62,6084.93,31.46,226.78 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -662.29,-933.62,21.82,181.42 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -1304.17,-394.62,36.7,73.71 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -1118.95,2699.73,18.55,223.94 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 2567.98,292.65,108.73,0.0 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -3173.51,1088.38,20.84,249.45 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 22.59,-1105.54,29.79,155.91 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 810.22,-2158.99,29.62,0.0 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Life Invader
		distance = 20,
		coords = { -1083.15,-245.88,37.76,209.77 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { -172.89,6381.32,31.48,223.94 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { 1690.07,3581.68,35.62,212.6 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { 326.5,-1074.43,29.47,0.0 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { 114.39,-4.85,67.82,204.1 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		distance = 30,
		coords = { 45.64,-1750.97,29.62,48.19 },
		model = { 0xE6631195,"ig_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		distance = 30,
		coords = { 47.61,-1748.62,29.62,48.19 },
		model = { 0x3273A285,"g_m_y_salvagoon_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		distance = 30,
		coords = { 2747.73,3474.08,55.67,252.29 },
		model = { 0xE6631195,"ig_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		distance = 30,
		coords = { 2746.88,3471.96,55.67,252.29 },
		model = { 0x3273A285,"g_m_y_salvagoon_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Criminal
	distance = 30,
	coords = { 475.01,3554.76,33.23,260.793 },
	model = { 0x3273A285,"g_m_y_salvagoon_02" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
{ -- Criminal 2
distance = 30,
coords = { 112.25,3373.42,35.23,59.53 },
model = { 0x3273A285,"g_m_y_salvagoon_02" },
anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
{ -- Criminal 3
distance = 30,
coords = { 2013.99,4990.83,41.21,133.23 },
model = { 0x3273A285,"g_m_y_salvagoon_02" },
anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
{ -- Criminal 4
distance = 30,
coords = { 186.82,6374.73,32.33,206.93 },
model = { 0x3273A285,"g_m_y_salvagoon_02" },
anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
{ -- Criminal SUL  
distance = 30,
coords = { -653.09,-1502.67,5.22,246.62 },
model = { 0x3273A285,"g_m_y_salvagoon_02" },
anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
{ -- Criminal SUL  2
distance = 30,
coords = { 389.58,-942.72,29.42,178.59 },
model = { 0x3273A285,"g_m_y_salvagoon_02" },
anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
{ -- Criminal SUL  3
distance = 30,
coords = { 154.98,-1472.47,29.35 },
model = { 0x3273A285,"g_m_y_salvagoon_02" },
anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
{ -- Criminal SUL  4
distance = 30,
coords = { 488.1,-1456.11,29.28 },
model = { 0x3273A285,"g_m_y_salvagoon_02" },
anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
{ -- Criminal VENDA DE COLETE, ATTACHS E ETC
distance = 30,
coords = { 465.62,-750.75,27.36,87.88 },
model = { 0x3273A285,"g_m_y_salvagoon_02" },
anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
	{ -- Recycling Sell
		distance = 15,
		coords = { -428.54,-1728.29,19.78,70.87 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Bar
		distance = 15,
		coords = { 129.71,-1284.65,29.27,119.06 },
		model = { 0x780C01BD,"s_f_y_bartender_01" },
		anim = { "amb@prop_human_bum_shopping_cart@male@base","base" }
	},
	{ -- Bar
		distance = 15,
		coords = { -561.75,286.7,82.18,266.46 },
		model = { 0xE11A9FB4,"ig_josef" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Jewelry
		distance = 15,
		coords = { -622.25,-229.95,38.05,308.98 },
		model = { 0xC314F727,"cs_gurk" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Transportador
		distance = 30,
		coords = { -4.73,-654.14,33.45,187.09 },
		model = { 0xE0FA2554,"ig_casey" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
		distance = 30,
		coords = { -840.64,5398.94,34.61,303.31 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
		distance = 30,
		coords = { -842.92,5403.49,34.61,300.48 },
		model = { 0x1C95CB0B,"u_m_m_markfost" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
		distance = 30,
		coords = { 892.38,-2171.85,32.28,178.59 },
		model = { 0x1C95CB0B,"u_m_m_markfost" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Minerador
		distance = 30,
		coords = { 2832.97,2797.6,57.46,99.22 },
		model = { 0xD7DA9E99,"s_m_y_construct_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mergulhador
		distance = 30,
		coords = { 2768.92,1391.19,24.53,82.21 },
		model = { 0xC79F6928,"a_f_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mergulhador
		distance = 30,
		coords = { 2768.62,1392.77,24.53,116.23 },
		model = { 0x4A8E5536,"s_f_y_baywatch_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mergulhador
		distance = 30,
		coords = { 1520.59,3780.11,34.46,280.63 },
		model = { 0xC79F6928,"a_f_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Colheita
		distance = 30,
		coords = { 406.08,6526.17,27.75,87.88 },
		model = { 0x94562DD7,"a_m_m_farmer_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Motorista
		distance = 30,
		coords = { 452.97,-607.75,28.59,266.46 },
		model = { 0x2A797197,"u_m_m_edtoh" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { 82.98,-1553.55,29.59,51.03 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { 287.77,2843.9,44.7,121.89 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { -413.97,6171.58,31.48,320.32 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 73.96,-1393.01,29.37,274.97 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -709.23,-151.35,37.41,119.06 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -165.08,-303.46,39.73,249.45 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -823.12,-1072.36,11.32,209.77 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -1194.6,-767.56,17.3,215.44 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -1448.61,-237.61,49.81,51.03 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 5.82,6511.47,31.88,42.52 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 1695.3,4823.0,42.06,93.55 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 127.23,-223.39,54.56,65.2 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 613.09,2761.8,42.09,274.97 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 1196.64,2711.62,38.22,181.42 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -3169.1,1044.04,20.86,65.2 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -1102.41,2711.57,19.11,221.11 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 426.97,-806.17,29.49,87.88 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 73.96,-1393.01,29.37,274.97 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { 1324.38,-1650.09,52.27,127.56 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { -1152.27,-1423.81,4.95,124.73 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { 319.84,180.89,103.58,246.62 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { -3170.41,1073.06,20.83,334.49 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { 1862.58,3748.52,33.03,28.35 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { -292.02,6199.72,31.49,223.94 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caminhoneiro
		distance = 30,
		coords = { 1239.87,-3257.2,7.09,274.97 },
		model = { 0x59511A6C,"s_m_m_trucker_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Restocador
		distance = 30,
		coords = { 920.04,-1256.84,25.51,36.86 },
		model = { 0x59511A6C,"s_m_m_trucker_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Digital Den
		distance = 30,
		coords = { 384.02,-827.6,29.3,257.96 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		distance = 30,
		coords = { 894.9,-179.15,74.7,240.95 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		distance = 30,
		coords = { 1696.19,4785.25,42.02,93.55 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Minerador
		distance = 30,
		coords = { -594.77,2090.0,131.65,19.85 },
		model = { 0xB1B196B2,"ig_floyd" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		distance = 10,
		coords = { -679.13,5839.52,17.32,226.78 },
		model = { 0xCE1324DE,"ig_hunter" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		distance = 30,
		coords = { -695.56,5802.12,17.32,65.2 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Credential
		distance = 30,
		coords = { 262.94,2592.61,44.94,192.76 },
		model = { 0xBE20FA04,"s_m_y_xmech_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Animal Park
		distance = 15,
		coords = { 563.19,2752.92,42.87,187.09 },
		model = { 0x51C03FA4,"a_f_y_eastsa_03" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Cassino
		distance = 15,
		coords = { 1109.33,229.28,-49.64,195.6 },
		model = { 0xC2E31A0A,"s_f_y_beachbarstaff_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
	    distance = 15,
	    coords = { -565.49,5325.7,73.58,68.04 },
	    model = { 0xE6631195,"ig_cletus" },
	    anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Pescador
		distance = 50,
		coords = { -1816.76,-1193.97,14.31,334.49 },
		model = { 0x51C03FA4,"a_f_y_eastsa_03" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pescador
		distance = 20,
		coords = { 1518.52,3782.17,34.46,317.49 },
		model = { 0x51C03FA4,"a_f_y_eastsa_03" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Impound
	    distance = 10,
	    coords = { 406.79,-1625.22,29.28,226.78 },
	    model = { 0xE0FA2554,"ig_casey" },
	    anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Pescador
		distance = 50,
		coords = { -326.16,6228.61,31.49,229.61 },
		model = { 0x51C03FA4,"a_f_y_eastsa_03" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(pedList) do
			local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= v["distance"] then
				if not IsPedInAnyVehicle(ped) then
					if localPeds[k] == nil then
						local mHash = GetHashKey(v["model"][2])

						RequestModel(mHash)
						while not HasModelLoaded(mHash) do
							Wait(1)
						end

						if HasModelLoaded(mHash) then
							localPeds[k] = CreatePed(4,v["model"][2],v["coords"][1],v["coords"][2],v["coords"][3] - 1,3374176,false,false)

							SetPedComponentVariation(localPeds[k],9,1,0,1)

							if v["model"][2] == "frentista" then
								SetPedPropIndex(localPeds[k],0,0,0,1)
								SetPedComponentVariation(localPeds[k],4,0,0,1)
								SetPedComponentVariation(localPeds[k],3,0,0,1)
								SetPedComponentVariation(localPeds[k],8,0,0,1)
								SetPedComponentVariation(localPeds[k],9,0,0,1)
								SetPedComponentVariation(localPeds[k],11,0,0,1)
								SetPedComponentVariation(localPeds[k],6,0,0,1)
								SetPedComponentVariation(localPeds[k],1,0,0,1)
								SetPedComponentVariation(localPeds[k],10,0,0,1)
								SetPedComponentVariation(localPeds[k],7,0,0,1)
								SetPedComponentVariation(localPeds[k],2,0,0,1)
							end

							if v["logitech"] then
								SetPedPropIndex(localPeds[k],0,-1,0,1)
								SetPedComponentVariation(localPeds[k],4,2,0,1)
								SetPedComponentVariation(localPeds[k],3,0,0,1)
								SetPedComponentVariation(localPeds[k],8,-1,0,1)
								SetPedComponentVariation(localPeds[k],9,0,0,1)
								SetPedComponentVariation(localPeds[k],11,0,0,1)
								SetPedComponentVariation(localPeds[k],6,0,0,1)
								SetPedComponentVariation(localPeds[k],1,0,0,1)
								SetPedComponentVariation(localPeds[k],10,0,0,1)
								SetPedComponentVariation(localPeds[k],7,0,0,1)
								SetPedComponentVariation(localPeds[k],2,0,0,1)
							end

							SetPedArmour(localPeds[k],100)
							SetEntityInvincible(localPeds[k],true)
							FreezeEntityPosition(localPeds[k],true)
							SetEntityHeading(localPeds[k],v["coords"][4])
							SetBlockingOfNonTemporaryEvents(localPeds[k],true)

							SetModelAsNoLongerNeeded(mHash)

							if v["anim"][1] ~= nil then
								if v["anim"][1] == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
									TaskStartScenarioAtPosition(localPeds[k],"PROP_HUMAN_SEAT_CHAIR_MP_PLAYER",v["coords"][1],v["coords"][2],v["coords"][3],v["coords"][4],-1,1,false)
								else
									RequestAnimDict(v["anim"][1])
									while not HasAnimDictLoaded(v["anim"][1]) do
										Wait(1)
									end

									TaskPlayAnim(localPeds[k],v["anim"][1],v["anim"][2],8.0,0.0,-1,49,0,0,0,0)
								end
							end
						end
					end
				end
			else
				if localPeds[k] then
					DeleteEntity(localPeds[k])
					localPeds[k] = nil
				end
			end
		end

		Wait(1000)
	end
end)