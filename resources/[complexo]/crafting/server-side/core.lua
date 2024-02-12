
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
Tunnel.bindInterface("crafting",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
	["BLX"] = {
		["perm"] = "BLX",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 5,
					["capsule"] = 5,
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 6,
					["capsule"] = 6,
				}
			},
			["WEAPON_SHOTGUN_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 10,
					["capsule"] = 10,
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 7,
					["capsule"] = 7,
				}
			},
		}
	},
	["Fazenda"] = {
		["perm"] = "Fazenda",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 5,
					["capsule"] = 5,
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 6,
					["capsule"] = 6,
				}
			},
			["WEAPON_SHOTGUN_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 10,
					["capsule"] = 10,
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 7,
					["capsule"] = 7,
				}
			},
		}
	},
	["FerroVelho"] = {
		["perm"] = "FerroVelho",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 5,
					["capsule"] = 5,
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 6,
					["capsule"] = 6,
				}
			},
			["WEAPON_SHOTGUN_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 10,
					["capsule"] = 10,
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 7,
					["capsule"] = 7,
				}
			},
		}
	},
	["Vinhedo"] = {
		["perm"] = "Vinhedo",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 5,
					["capsule"] = 5,
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 6,
					["capsule"] = 6,
				}
			},
			["WEAPON_SHOTGUN_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 10,
					["capsule"] = 10,
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["gunpowder"] = 7,
					["capsule"] = 7,
				}
			},
		}
	},
	["Lixeiro"] = {
		["list"] = {
			["glass"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["glassbottle"] = 1
				}
			},
			["plastic"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["plasticbottle"] = 1
				}
			},
			["rubber"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["elastic"] = 1
				}
			},
			["aluminum"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["metalcan"] = 1
				}
			},
			["copper"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["battery"] = 1
				}
			}
		}
	},
	["Chacara"] = {
		["perm"] = "Chacara",
		["list"] = {
            ["soap"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["saline"] = 55,
					["sulfuric"] = 5
                }
            },
			["card01"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["aluminum"] = 5
                }
            },
			["card02"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["aluminum"] = 10
                }
            },
			["card03"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["aluminum"] = 15
                }
            },
			["card04"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["aluminum"] = 20
                }
            },
			["card05"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["aluminum"] = 25
                }
            },
        }
    },
	["Ballas"] = {
		["perm"] = "Ballas",
		["list"] = {
            ["ecstasy"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["codeine"] = 1,
					["saline"] = 1  
                 }
            },
        }
    },
	["BDT"] = {
		["perm"] = "BDT",
		["list"] = {
            ["heroine"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["codeine"] = 1,
					["saline"] = 1  
                 }
            },
        }
    },
	["FavelaDK"] = {
	 	["perm"] = "FavelaDK",
	 	["list"] = {
             ["joint"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["weedleaf"] = 1,
                	["paper"] = 1
                }
             }
        }
    },
	["Lavagem"] = {
		["list"] = {
			["dollars"] = {
			   ["amount"] = 8500,
			   ["destroy"] = false,
			   ["require"] = {
				   ["dollarsz"] = 14000
			   }
			}
	   }
   },
	["Vagos"] = {
		["perm"] = "Vagos",
		["list"] = {
			["lancap"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                	["plastic"] = 1,
					["saline"] = 1
                }
            },
        }
    },
	["PlayBoy"] = {
		["perm"] = "PlayBoy",
		["list"] = {
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 30
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 35
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 25
				}
			},
			["WEAPON_PUMPSHOTGUN_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 10
				}
			},
			["WEAPON_PISTOL50"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 25
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 80,
					["glass"] = 80,
					["rubber"] = 75
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 15
				}
			},
			["WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 175,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			 ["WEAPON_SMG_MK2"] = { 
			 	["amount"] = 1,
			 	["destroy"] = false,
			 	["require"] = {
			 		["smgbody"] = 3,
			 		["aluminum"] = 250,
			 		["copper"] = 250,
			 		["plastic"] = 100,
			 		["glass"] = 75,
			 		["rubber"] = 75
			 	}
			 },
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_PARAFAL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 9,
					["aluminum"] = 575,
					["copper"] = 550,
					["plastic"] = 375,
					["glass"] = 375,
					["rubber"] = 375
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 250,
					["copper"] = 250,
					["plastic"] = 100,
					["glass"] = 75,
					["rubber"] = 75
				}
			}
		}
	},
	["Cosanostra"] = {
		["perm"] = "Cosanostra",
		["list"] = {
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 30
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 35
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 25
				}
			},
			["WEAPON_PUMPSHOTGUN_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 10
				}
			},
			["WEAPON_PISTOL50"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 25
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 80,
					["glass"] = 80,
					["rubber"] = 75
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 15
				}
			},
			["WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 175,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			 ["WEAPON_SMG_MK2"] = { 
			 	["amount"] = 1,
			 	["destroy"] = false,
			 	["require"] = {
			 		["smgbody"] = 3,
			 		["aluminum"] = 250,
			 		["copper"] = 250,
			 		["plastic"] = 100,
			 		["glass"] = 75,
			 		["rubber"] = 75
			 	}
			 },
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_PARAFAL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 9,
					["aluminum"] = 575,
					["copper"] = 550,
					["plastic"] = 375,
					["glass"] = 375,
					["rubber"] = 375
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 250,
					["copper"] = 250,
					["plastic"] = 100,
					["glass"] = 75,
					["rubber"] = 75
				}
			}
		}
	},
	["LiderYakuza"] = {
		["perm"] = "LiderYakuza",
		["list"] = {
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 30
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 35
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 25
				}
			},
			["WEAPON_PUMPSHOTGUN_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 10
				}
			},
			["WEAPON_PISTOL50"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 25
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 80,
					["glass"] = 80,
					["rubber"] = 75
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 3,
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 15
				}
			},
			["WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 175,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			 ["WEAPON_SMG_MK2"] = { 
			 	["amount"] = 1,
			 	["destroy"] = false,
			 	["require"] = {
			 		["smgbody"] = 3,
			 		["aluminum"] = 250,
			 		["copper"] = 250,
			 		["plastic"] = 100,
			 		["glass"] = 75,
			 		["rubber"] = 75
			 	}
			 },
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 3,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_PARAFAL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 9,
					["aluminum"] = 575,
					["copper"] = 550,
					["plastic"] = 375,
					["glass"] = 375,
					["rubber"] = 375
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 3,
					["aluminum"] = 250,
					["copper"] = 250,
					["plastic"] = 100,
					["glass"] = 75,
					["rubber"] = 75
				}
			}
		}
	},
	["Inventory"] = {
		["list"] = {
			["ketchup"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["tomato"] = 3
				}
			},
			["campfire"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 10,
					["alcohol"] = 1,
					["lighter"] = 1
				}
			},
			["gauze"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cotton"] = 2,
					["alcohol"] = 1,
					["plaster"] = 1,
					["silk"] = 1
				}
			}
		}
	},
	 ["Fuels"] = {
	 	["list"] = {
	 		["WEAPON_PETROLCAN"] = {
	 			["amount"] = 1,
	 			["destroy"] = false,
 			["require"] = {
				["dollars"] = 75
				}
	 		},
	 		["WEAPON_PETROLCAN_AMMO"] = {
	 			["amount"] = 5000,
	 			["destroy"] = false,
	 			["require"] = {
	 				["dollars"] = 500
	 			}
	 		}
	 	}
	 },
	["Grota"] = { -- Grota 
		["perm"] = "Grota",
		["list"] = {
            ["meth"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                    ["amphetamine"] = 1,
                    ["glass"] = 1,
                }
            }
        }
    },
	["HotGirls"] = { -- HotGirls
		["perm"] = "HotGirls",
		["list"] = {
			["handcuff"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 3,
					["elastic"] = 3
				}
			},
			["pager"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 5,
					["elastic"] = 5
				}
			},
			["dollars"] = {
				["amount"] = 9000,
				["destroy"] = false,
				["require"] = {
					["dollarsz"] = 10000
				}
			}
		}
	},
	["Bahamas"] = { -- Bahamas
		["perm"] = "Bahamas",
		["list"] = {
			["handcuff"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                 	["aluminum"] = 3,
			 		["elastic"] = 3
                }
            },
			["pager"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                 	["aluminum"] = 5,
			 		["elastic"] = 5
                }
            },
            ["dollars"] = {
                ["amount"] = 9000,
                ["destroy"] = false,
                ["require"] = {
                    ["dollarsz"] = 10000
                }
            }
        }
    },
	["Vanilla"] = { -- Vanilla
		["perm"] = "Vanilla",
		["list"] = {
			["handcuff"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                 	["aluminum"] = 3,
			 		["elastic"] = 3
                }
            },
			["pager"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                 	["aluminum"] = 5,
			 		["elastic"] = 5
                }
            },
            ["dollars"] = {
                ["amount"] = 9000 ,
                ["destroy"] = false,
                ["require"] = {
                    ["dollarsz"] = 10000
                }
            }
        }
    },
	["Motoclub"] = { -- Motoclub
		["perm"] = "Motoclub",
		["list"] = {
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["copper"] = 1,
					["dollarsz"] = 1000
			   }
			},
			["credential"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["copper"] = 1,
					["dollarsz"] = 1000
			   }
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 3,
					["copper"] = 3
				}
			},
			["lockpick2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 3,
					["copper"] = 3
				}
			},
			["plate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 3,
					["aluminum"] = 3
				}
            }
        }
    },
	["Primatas"] = { 
		["perm"] = "Primatas",
		["list"] = {
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["copper"] = 1,
					["dollarsz"] = 1000
			   }
			},
			["credential"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["copper"] = 1,
					["dollarsz"] = 1000
			   }
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 3,
					["copper"] = 3
				}
			},
			["lockpick2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 3,
					["copper"] = 3
				}
			},
			["plate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 3,
					["aluminum"] = 3
				}
            }
        }
    },
	-- ["Bennys"] = { -- Bennys
	-- 	["perm"] = "Bennys",
	-- 	["list"] = {
	-- 		["nitro"] = {
    --             ["amount"] = 1,
    --             ["destroy"] = false,
    --             ["require"] = {
	-- 				["aluminum"] = 15,
	-- 				["sulfuric"] = 15
    --             }
    --         }
    --     }
    -- },
	["Arcade"] = {
		["perm"] = "Arcade", -- Arcade
		["list"] = {
			["vest"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
					["roadsigns"] = 6,
					["techtrash"] = 6,
					["sheetmetal"] = 6
                }
            },
			["attachsMuzzleFat"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				 }
			},
			["attachsMagazine"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				 }
			},
			["attachsGrip"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				}
			},
			["attachsBarrel"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				}
			},
			["attachsSilencer"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 20,
				["roadsigns"] = 20,
				["sheetmetal"] = 20
				}
			},
			["attachsCrosshair"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				}
			},
			["attachsMuzzleHeavy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 4,
					["roadsigns"] = 4,
					["sheetmetal"] = 4
				}
			},

        }
    },
	["Salieris"] = {
		["perm"] = "Salieris", 
		["list"] = {
			["vest"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
					["roadsigns"] = 6,
					["techtrash"] = 6,
					["sheetmetal"] = 6
                }
            },
			["attachsMagazine"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				 }
			},
			["attachsMuzzleFat"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				 }
			},
			["attachsGrip"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				}
			},
			["attachsBarrel"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				}
			},
			["attachsSilencer"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 20,
				["roadsigns"] = 20,
				["sheetmetal"] = 20
				}
			},
			["attachsCrosshair"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
				["techtrash"] = 4,
				["roadsigns"] = 4,
				["sheetmetal"] = 4
				}
			},
			["attachsMuzzleHeavy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 4,
					["roadsigns"] = 4,
					["sheetmetal"] = 4
				}
			},

        }
    },
	["FavelaNH"] = {
		["perm"] = "FavelaNH",
		["list"] = {
			["cocaine"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["codeine"] = 1,
					["saline"] = 1
				}
			},
        }
    },
	["Bloods"] = {
		["perm"] = "Bloods",
		["list"] = {
			["lsd"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["glass"] = 1,
					["saline"] = 1
				}
			},
        }
    },
	["Crips"] = {
		["perm"] = "Crips",
		["list"] = {
			["xanax"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["glass"] = 1,
					["codeine"] = 1
				}
			},
        }
    },
	["Duros"] = {
		["perm"] = "Duros",
		["list"] = {
			["lancap"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 1,
					["saline"] = 1
				}
			},
        }
    },
	["FavelaSV"] = {
		["perm"] = "FavelaSV",
		["list"] = {
			["heroine"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
                	["plastic"] = 1,
					["saline"] = 1
				}
			},
        }
    },
	["Pedreira"] = {
		["perm"] = "Pedreira",
		["list"] = {
            ["lean"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                    ["codeine"] = 1,
					["plastic"] = 1
				}
			},
		}
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(craftType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if craftList[craftType]["perm"] ~= nil then
			if not vRP.hasGroup(user_id,craftList[craftType]["perm"]) then
				return false
			end
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestCrafting(craftType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(craftList[craftType]["list"]) do
			local craftList = {}
			for k,v in pairs(v["require"]) do
				table.insert(craftList,{ name = itemName(k), amount = v })
			end

			table.insert(inventoryShop,{ name = itemName(k), index = itemIndex(k), key = k, peso = itemWeight(k), list = craftList, amount = parseInt(v["amount"]), desc = itemDescription(k), economy = itemEconomy(k) })
		end

		local inventoryUser = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["economy"] = itemEconomy(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			inventoryUser[k] = v
		end

		return inventoryShop,inventoryUser,vRP.inventoryWeight(user_id),vRP.getWeight(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionCrafting(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		if craftList[shopType]["list"][shopItem] then
			if vRP.checkMaxItens(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"] * shopAmount) then
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
				TriggerClientEvent("crafting:Update",source,"requestCrafting")
				return
			end

			if (vRP.inventoryWeight(user_id) + (itemWeight(shopItem) * parseInt(shopAmount))) <= vRP.getWeight(user_id) then
				if shopItem == "WEAPON_NAIL_AMMO" then
					local Inventory = vRP.userInventory(user_id)
					if Inventory then
						for k,v in pairs(Inventory) do
							if string.sub(v["item"],1,5) == "badge" then
								vRP.removeInventoryItem(user_id,v["item"],1,false)
								vRP.generateItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"] * shopAmount,false,slot)
								break
							end
						end
					end
				else
					for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
						local consultItem = vRP.getInventoryItemAmount(user_id,k)
						if consultItem[1] < parseInt(v * shopAmount) then
							return
						end

						if vRP.checkBroken(consultItem[2]) then
							TriggerClientEvent("Notify",source,"vermelho","Item quebrado.",5000)
							return
						end
					end

					for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
						local consultItem = vRP.getInventoryItemAmount(user_id,k)
						vRP.removeInventoryItem(user_id,consultItem[2],parseInt(v * shopAmount))
					end

					vRP.generateItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"] * shopAmount,false,slot)
				end
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionDestroy(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end
		local splitName = splitString(shopItem,"-")

		if craftList[shopType]["list"][splitName[1]] then
			if craftList[shopType]["list"][splitName[1]]["destroy"] then
				if vRP.checkBroken(shopItem) then
					TriggerClientEvent("Notify",source,"vermelho","Itens quebrados reciclados.",5000)
					TriggerClientEvent("crafting:Update",source,"requestCrafting")
					return
				end

				if vRP.tryGetInventoryItem(user_id,shopItem,craftList[shopType]["list"][splitName[1]]["amount"]) then
					for k,v in pairs(craftList[shopType]["list"][splitName[1]]["require"]) do
						if parseInt(v) <= 1 then
							vRP.generateItem(user_id,k,1)
						else
							vRP.generateItem(user_id,k,v / 2)
						end
					end
				end
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:populateSlot")
AddEventHandler("crafting:populateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
			vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			TriggerClientEvent("crafting:Update",source,"requestCrafting")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:updateSlot")
AddEventHandler("crafting:updateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inventory = vRP.userInventory(user_id)
		if inventory[tostring(slot)] and inventory[tostring(target)] and inventory[tostring(slot)]["item"] == inventory[tostring(target)]["item"] then
			if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
				vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			end
		else
			vRP.swapSlot(user_id,slot,target)
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end)