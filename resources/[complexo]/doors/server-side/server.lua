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
Tunnel.bindInterface("doors",cRP)
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Doors"] = {
	[1] = { x = 431.38, y = -1000.68, z = 25.55, hash = 2130672747, lock = true, text = true, distance = 20, press = 5, perm = "Police" },
	[2] = { x = 452.25, y = -1000.73, z = 25.55, hash = 2130672747, lock = true, text = true, distance = 20, press = 5, perm = "Police" },
	[3] = { x = 488.90, y = -1017.19, z = 28.50, hash = -1603817716, lock = true, text = true, distance = 20, press = 5, perm = "Police" },
	[4] = { x = 476.59, y = -1007.79, z = 26.54, hash = -53345114, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[5] = { x = 482.11, y = -1004.11, z = 26.54, hash = -53345114, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[6] = { x = 476.82, y = -1012.13, z = 26.54, hash = -53345114, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[7] = { x = 479.83, y = -1012.17, z = 26.54, hash = -53345114, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[8] = { x = 482.83, y = -1012.18, z = 26.54, hash = -53345114, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[9] = { x = 485.81, y = -1012.17, z = 26.54, hash = -53345114, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[10] = { x = 485.26, y = -1007.78, z = 26.54, hash = -53345114, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[11] = { x = 441.62, y = -977.67, z = 30.95, hash = 2888281650, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[12] = { x = 441.58, y = -986.18, z = 30.95, hash = 4198287975, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[13] = { x = 479.69, y = -998.53, z = 30.95, hash = -692649124, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[14] = { x = 486.36, y = -1000.26, z = 30.95, hash = -692649124, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[15] = { x = 467.96, y = -1014.42, z = 26.5, hash = -692649124, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 16 },
	[16] = { x = 469.06, y = -1014.41, z = 26.5, hash = -692649124, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 15 },
	[17] = { x = 441.27, y = -998.75, z = 30.95, hash = -1547307588, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 18 },
	[18] = { x = 442.43, y = -998.78, z = 30.95, hash = -1547307588, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 17 },
	[19] = { x = 457.59, y = -972.28, z = 30.95, hash = -1547307588, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 20 },
	[20] = { x = 456.43, y = -972.27, z = 30.95, hash = -1547307588, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 19 },
	[21] = { x = 1846.049, y = 2604.733, z = 45.579, hash = 741314661, lock = true, text = true, distance = 30, press = 10, perm = "Emergency" },
	[22] = { x = 1819.475, y = 2604.743, z = 45.577, hash = 741314661, lock = true, text = true, distance = 30, press = 10, perm = "Emergency" },
	[23] = { x = 1836.71, y = 2590.32, z = 46.20, hash = 539686410, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[24] = { x = 1769.52, y = 2498.92, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[25] = { x = 1766.34, y = 2497.09, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[26] = { x = 1763.20, y = 2495.26, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[27] = { x = 1756.89, y = 2491.66, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[28] = { x = 1753.75, y = 2489.85, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[29] = { x = 1750.61, y = 2488.02, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[30] = { x = 1757.14, y = 2474.87, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[31] = { x = 1760.26, y = 2476.71, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[32] = { x = 1763.44, y = 2478.50, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[33] = { x = 1766.54, y = 2480.33, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[34] = { x = 1769.73, y = 2482.13, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[35] = { x = 1772.83, y = 2483.97, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[36] = { x = 1776.00, y = 2485.77, z = 46.00, hash = 913760512, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	--[37] = { x = 383.45, y = 799.41, z = 187.65, hash = 517369125, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[38] = { x = 383.45, y = 796.74, z = 187.67, hash = -868087669, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[39] = { x = 388.59, y = 798.36, z = 187.67, hash = -1018783587, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[40] = { x = 398.14, y = -1607.53, z = 29.50, hash = 1286535678, lock = true, text = true, distance = 20, press = 5, perm = "Police" },

	[41] = { x = -444.45, y = 6007.71, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[42] = { x = -442.98, y = 6011.80, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[43] = { x = -445.12, y = 6012.14, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[44] = { x = -448.08, y = 6015.12, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[45] = { x = -445.60, y = 6017.56, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[46] = { x = -442.63, y = 6014.60, z = 27.75, hash = -594854737, lock = true, text = true, distance = 10, press = 2, perm = "Police" },

	[51] = { x = 370.17, y = -1606.45, z = 30.25, hash = -674638964, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[52] = { x = 367.29, y = -1604.14, z = 30.25, hash = -674638964, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[53] = { x = 374.00, y = -1597.64, z = 25.75, hash = -674638964, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[54] = { x = 376.83, y = -1599.97, z = 25.75, hash = -674638964, lock = true, text = true, distance = 10, press = 2, perm = "Police" },

	[61] = { x = 1849.02, y = 3693.30, z = 34.37, hash = -1491332605, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[62] = { x = 1851.94, y = 3694.98, z = 34.37, hash = -1491332605, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[63] = { x = 1856.33, y = 3696.54, z = 34.37, hash = -1491332605, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[64] = { x = 1853.76, y = 3699.85, z = 34.37, hash = -2002725619, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[65] = { x = 1847.24, y = 3688.46, z = 34.37, hash = -2002725619, lock = true, text = true, distance = 10, press = 2, perm = "Police" },

	[71] = { x = 308.03, y = -597.30, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[72] = { x = 308.20, y = -570.00, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[73] = { x = 337.25, y = -580.58, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[74] = { x = 341.87, y = -582.25, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[75] = { x = 347.87, y = -584.44, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[76] = { x = 340.13, y = -587.07, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[77] = { x = 361.60, y = -589.44, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[78] = { x = 359.86, y = -594.25, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[79] = { x = 351.75, y = -595.23, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[80] = { x = 350.39, y = -598.99, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[81] = { x = 345.96, y = -596.25, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[82] = { x = 347.32, y = -592.49, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[83] = { x = 355.68, y = -584.45, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[84] = { x = 357.04, y = -580.70, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[85] = { x = 304.40, y = -571.45, z = 43.39, hash = 854291622, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[86] = { x = 303.60, y = -581.75, z = 43.39, hash = -434783486, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 87 },
	[87] = { x = 304.39, y = -582.05, z = 43.39, hash = -1700911976, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 86 },
	[88] = { x = 325.03, y = -589.55, z = 43.39, hash = -434783486, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 89 },
	[89] = { x = 325.81, y = -589.84, z = 43.39, hash = -1700911976, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 88 },
	[90] = { x = 312.80, y = -571.67, z = 43.39, hash = -434783486, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 91 },
	[91] = { x = 313.58, y = -571.95, z = 43.39, hash = -1700911976, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 90 },
	[92] = { x = 318.64, y = -574.08, z = 43.39, hash = -434783486, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 93 },
	[93] = { x = 319.44, y = -575.76, z = 43.39, hash = -1700911976, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 92 },
	[94] = { x = 324.04, y = -575.76, z = 43.39, hash = -434783486, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 95 },
	[95] = { x = 324.83, y = -576.04, z = 43.39, hash = -1700911976, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 94 },

	[101] = { x = -1646.20, y = -1069.72, z = 13.85, hash = 855881614, lock = true, text = true, distance = 10, press = 2, perm = "Arcade" },

	[102] = { x = -913.0, y = -2033.18, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 103 },
	[103] = { x = -913.59, y = -2032.48, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 102 },

	[104] = { x = -913.26, y = -2030.34, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[105] = { x = -909.11, y = -2027.74, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[106] = { x = -920.05, y = -2018.1, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[107] = { x = -929.19, y = -2043.34, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 2, press = 2, perm = "Police" },

	[108] = { x = -926.67, y = -2034.58, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 109 },
	[109] = { x = -926.03, y = -2035.1, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 108 },
	[110] = { x = -927.53, y = -2038.0, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 111 },
	[111] = { x = -926.84, y = -2037.32, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 110 },
	[112] = { x = -938.7, y = -2038.2, z = 9.4, hash = 855881614, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[113] = { x = -936.97, y = -2039.89, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 114 },
	[114] = { x = -936.36, y = -2040.65, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 113 },
	[115] = { x = -942.63, y = -2060.24, z = 9.4, hash = 855881614, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[116] = { x = -959.51, y = -2052.72, z = 9.4, hash = -1291439697, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[117] = { x = -955.76, y = -2049.0, z = 9.4, hash = -1291439697, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[118] = { x = -953.2, y = -2051.73, z = 9.4, hash = -1291439697, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[119] = { x = -952.58, y = -2053.84, z = 9.4, hash = -806761221, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[120] = { x = -952.37, y = -2049.85, z = 9.4, hash = -806761221, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	--[121] = { x = -943.56, y = -2054.29, z = 9.4, hash = -806761221, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[122] = { x = -937.93, y = -2048.5, z = 6.1, hash = -806761221, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[123] = { x = -939.32, y = -2045.4, z = 6.1, hash = -806761221, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[124] = { x = -936.64, y = -2041.58, z = 6.1, hash = -806761221, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[125] = { x = -945.62, y = -2039.12, z = 6.1, hash = -806761221, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[126] = { x = -932.13, y = -2044.65, z = 9.4, hash = -806761221, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[127] = { x = -943.95, y = -2044.99, z = 9.4, hash = 855881614, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[128] = { x = -953.73, y = -2044.23, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[129] = { x = -954.61, y = -2057.72, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 130 },
	[130] = { x = -954.03, y = -2058.25, z = 9.4, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 129 },
	[131] = { x = -964.87, y = -2067.13, z = 9.4, hash = -1795139803, lock = true, text = true, distance = 2, press = 2, perm = "Police" },
	[132] = { x = -948.07, y = -2067.41, z = 9.5, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 133 },
	[133] = { x = -947.4, y = -2068.0, z = 9.5, hash = 1307986194, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 132 },
	[134] = { x = -916.58, y = -2037.98, z = 9.4, hash = -1316777937, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 135 },
	[135] = { x = -915.61, y = -2037.08, z = 9.4, hash = -1316777937, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 134 },
	[136] = { x = -844.04, y = 156.33, z = 66.81, hash = -2125423493, lock = true, text = true, distance = 20, press = 5, perm = "Yakuza" },
	[137] = { x = 386.68, y = 792.93, z = 187.69, hash = -1018783587 , lock = true, text = true, distance = 10, press = 5, perm = "Police" },
	[138] = { x = 379.47, y = 792.62, z = 190.42, hash = 1715748964 , lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 139 },
	[139] = { x = 378.72, y = 792.93, z = 190.49, hash = 1715748964, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 138 },
	[140] = { x = -662.45, y = 944.21, z = 244.09, hash = 118134501, lock = true, text = true, distance = 10, press = 5, perm = "BLX" },
	[141] = { x = -661.81, y = 953.32, z = 243.95, hash = -1421690152, lock = true, text = true, distance = 10, press = 5, perm = "BLX" },
	[142] = { x = 1122.3, y = 264.1, z = -51.04, hash = 680601509 , lock = true, text = true, distance = 10, press = 2, perm = "HotGirls", other = 143 },
	[143] = { x = 1122.31, y = 265.02, z = -51.04, hash = 680601509, lock = true, text = true, distance = 10, press = 2, perm = "HotGirls", other = 142 },
	[144] = { x = 1111.48, y = 251.11, z = -45.85, hash = -643593781 , lock = true, text = true, distance = 10, press = 2, perm = "HotGirls", other = 145 },
	[145] = { x = 1110.6, y = 251.11, z = -45.85, hash = -643593781, lock = true, text = true, distance = 10, press = 2, perm = "HotGirls", other = 144 },
	[146] = { x = 18.7, y = 546.4, z = 176.03, hash = 2052512905, lock = true, text = true, distance = 10, press = 5, perm = "CasaLolo" },
	[147] = { x = 8.25, y = 539.2, z = 176.03, hash = 308207762, lock = true, text = true, distance = 10, press = 5, perm = "CasaLolo" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsStatistics(doorNumber,doorStatus)
	local Doors = GlobalState["Doors"]

	Doors[doorNumber]["lock"] = doorStatus

	if Doors[doorNumber]["other"] ~= nil then
		local doorSecond = Doors[doorNumber]["other"]
		Doors[doorSecond]["lock"] = doorStatus
	end

	GlobalState["Doors"] = Doors
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["Doors"][doorNumber]["perm"] ~= nil then
			if vRP.hasGroup(user_id,GlobalState["Doors"][doorNumber]["perm"]) then
				return true
			else
				local consultItem = vRP.getInventoryItemAmount(user_id,"lockpick2")
				if consultItem[1] >= 1 then
					if math.random(100) >= 50 then
						vRP.removeInventoryItem(user_id,consultItem[2],1,true)
						vRP.generateItem(user_id,"brokenpick",1,false)
					end

					local taskResult = vTASKBAR.taskDoors(source)
					if taskResult then
						return true
					end
				end
			end
		end
	end

	return false
end
----------------------------------------------------------------------------------------------------------------
