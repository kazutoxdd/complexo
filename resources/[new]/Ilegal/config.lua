Config = {} -- deixar aqui importante para o funcionamento da config

Config.blocklist =
    { -- aqui irão ficar todos os outros grupos que não usam o painel porém são empregos com carteira assinada
        "Spotify",
        "Desserts",
        "PopsDiner",
        "BurgerShot",
        "PizzaThis"
    }

Config.notify = "Notify"

Config.notify_sucesso = "verde"

Config.notify_erro = "vermelho"

Config.notify_debito = "azul"

Config.notify_credito = "amarelo"

Config.printbau = true


Config.webhooks = {
    demitir = "",
    promover = "",
    contratar = "",
    bau = "",
    banco = ""
}

Config.grupos = {
--==============================================================================================================================================================================
--== STAFF
--==============================================================================================================================================================================
["Salieris"] = { -- inicio de um grupo
config = {
    foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
    bau = "chest:" -- nome do bau que vai ser criado com o comando createChest
},
grupos = {
    ["Líder"] = {grupo = "LiderSalieris", titulo = "Líder"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
    ["Membros"] = {grupo = "Salieris", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
}
},


["Police"] = { -- inicio de um grupo
config = {
    foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
    bau = "chest:Police" -- nome do bau que vai ser criado com o comando createChest
},
grupos = {
    ["Líder"] = {grupo = "masterPolice", titulo = "Líder"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
    ["Membros"] = {grupo = "Police", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
}
},


["HP"] = { -- inicio de um grupo
config = {
    foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
    bau = "chest:Paramedic"
},
grupos = {
    ["Líder"] = {grupo = "masterParamedic", titulo = "Líder"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
    ["Membros"] = {grupo = "Paramedic", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
}
},

["Mec"] = { -- inicio de um grupo
config = {
    foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
    bau = "chest:Bennys"
},
grupos = {
    ["Líder"] = {grupo = "LiderBennys", titulo = "Líder"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
    ["Membros"] = {grupo = "Bennys", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
}
},


["Staff"] = { -- inicio de um grupo
        config = {
            foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
            bau = "chest:" -- nome do bau que vai ser criado com o comando createChest
        },
        grupos = {
            ["Líder"] = {grupo = "Admin", titulo = "Admin"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
            ["Membros"] = {grupo = "Moderator", titulo = "Moderador"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
        }
    }, -- final de um grupo


 ["Cosanostra"] = { -- inicio de um grupo
        config = {
            foto = "https://cdn.discordapp.com/attachments/1076933637829828711/1121888922205700187/WhatsApp_Image_2023-06-20_at_20.57.34.jpeg", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
            bau = "chest:Cosanostra" -- nome do bau que vai ser criado com o comando createChest
        },
        grupos = {
            ["Líder"] = {grupo = "LiderCosanostra", titulo = "Líder Cosanostra"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
            ["Membros"] = {grupo = "Cosanostra", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
        }
    }, -- final de um grupo


    ["Arcade"] = { -- inicio de um grupo
        config = {
            foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
            bau = "chest:Arcade" -- nome do bau que vai ser criado com o comando createChest
        },
        grupos = {
            ["Líder"] = {grupo = "LiderArcade", titulo = "Líder Arcade"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
            ["Membros"] = {grupo = "Arcade", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
        }
    }, -- final de um grupo


    ["Vanilla"] = { -- inicio de um grupo
        config = {
            foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
            bau = "chest:Vanilla" -- nome do bau que vai ser criado com o comando createChest
        },
        grupos = {
            ["Líder"] = {grupo = "LiderVanilla", titulo = "Líder Vanilla"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
            ["Membros"] = {grupo = "Vanilla", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
        }
    }, -- final de um grupo


    ["Bahamas"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Bahamas" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderBahamas", titulo = "Líder Bahamas"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Bahamas", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["Ballas"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Ballas" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderBallas", titulo = "Líder Ballas"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Ballas", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["Vagos"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Vagos" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderVagos", titulo = "Líder Vagos"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Vagos", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["Fazenda"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Fazenda" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderFazenda", titulo = "Líder Fazenda"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Fazenda", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["Vinhedo"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Vinhedo" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderVinhedo", titulo = "Líder Vinhedo"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Vinhedo", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["BDT"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:BDT" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderBDT", titulo = "Líder BDT"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "BDT", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo

["PlayBoy"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:PlayBoy" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderPlayBoy", titulo = "Líder PlayBoy"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "PlayBoy", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo

["Crips"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Crips" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderCrips", titulo = "Líder Crips"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Crips", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo

["Bloods"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Bloods" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderBloods", titulo = "Líder Bloods"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Bloods", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["Motoclub"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Motoclub" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderMotoclub", titulo = "Líder Motoclub"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Motoclub", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["Grota"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Grota" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderGrota", titulo = "Líder Grota"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Grota", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo

["BLX"] = { -- inicio de um grupo
    config = {
        foto = "https://discord.com/channels/@me/1121667695310549043/1125118916818112582", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderBLX", titulo = "Líder BLX"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "BLX", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo

["HotGirls"] = { -- inicio de um grupo
    config = {
        foto = "https://discord.com/channels/@me/1121667695310549043/1125118916818112582", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderHotGirls", titulo = "Líder HotGirls"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "HotGirls", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo

["FavelaNH"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:FavelaNH" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderFavelaNH", titulo = "Líder FavelaNH"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "FavelaNH", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo

["FerroVelho"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:FerroVelho" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderFerroVelho", titulo = "Líder FerroVelho"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "FerroVelho", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo

["Primatas"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderPrimatas", titulo = "Líder Primatas"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Primatas", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["FavelaSV"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:FavelaSV" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderFavelaSV", titulo = "Líder FavelaSV"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "FavelaSV", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["Pedreira"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Pedreira" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderPedreira", titulo = "Líder Pedreira"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Pedreira", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["FavelaDK"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:FavelaDK" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderFavelaDK", titulo = "Líder FavelaDK"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "FavelaDK", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo


["Duros"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Duros" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderDuros", titulo = "Líder Duros"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Duros", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }
}, -- final de um grupo

["Bennys"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Duros" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderBennys", titulo = "Líder Bennys"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Bennys", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }, -- final de um grupo
},
["Yakuza"] = { -- inicio de um grupo
    config = {
        foto = "", -- link direto da imagem que será a foto do grupo (A proporção deve ser 1:1 ou seja 1080x1080 / 1000x1000)
        bau = "chest:Duros" -- nome do bau que vai ser criado com o comando createChest
    },
    grupos = {
        ["Líder"] = {grupo = "LiderYakuza", titulo = "Líder Yakuza"}, -- grupo -> igual ao do group id grupo | titulo -> um titulo mais bonito para gerar mais imesão na NUI
        ["Membros"] = {grupo = "Yakuza", titulo = "Membro"},-- aqui irão ficar todos os grupos dos membros que não sao líderes, esses grupos devem ser numerados sempre respeitando que o grupo base deve ser o número 1   
    }, -- final de um grupo
}
}



