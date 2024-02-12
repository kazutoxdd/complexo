-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- variaveis
-----------------------------------------------------------------------------------------------------------------------------------------
local keyGlobal
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("leoz_groups/create","INSERT INTO leoz_groups (grupo, saldo) VALUES (@grupo, 0)")
vRP._prepare("leoz_groups/deletemembro","DELETE FROM leoz_groups_membros WHERE membro = @membro")
vRP._prepare("leoz_groups/addmembro","INSERT INTO leoz_groups_membros (nome, grupo, membro, cargo) VALUES (@nome, @grupo, @membro, @cargo)")
vRP._prepare("leoz_groups/selectmembro","SELECT * FROM leoz_groups_membros WHERE membro = @membro")
vRP._prepare("leoz_groups/getmembros","SELECT * FROM leoz_groups_membros WHERE grupo = @grupo")
vRP._prepare("leoz_groups/getbau","SELECT * FROM leoz_groups_bau WHERE grupo = @grupo AND data_transacao > DATE_SUB(NOW(), INTERVAL 1 DAY) ORDER BY data_transacao DESC")
vRP._prepare("leoz_groups/getbanco","SELECT * FROM leoz_groups_banco WHERE grupo = @grupo AND data_transacao > DATE_SUB(NOW(), INTERVAL 3 DAY) ORDER BY data_transacao DESC")
vRP._prepare("leoz_groups/addBauLog","INSERT INTO leoz_groups_bau (`membro_id`,`membro_nome`,`colocou`,`item`,`quantidade`,`grupo`) VALUES (@membro_id,@membro_nome,@colocou,@item,@quantidade,@grupo)")
vRP._prepare("leoz_groups/addTransacao","INSERT INTO leoz_groups_banco (`membro_id`,`membro`,`deposito`,`valor`,`grupo`) VALUES (@id,@nome,@deposito,@valor,@grupo)")
vRP._prepare("leoz_groups/updateSaldo","UPDATE leoz_groups SET saldo = @saldo WHERE grupo = @grupo")
vRP._prepare("leoz_groups/getSaldo","SELECT * FROM leoz_groups WHERE grupo = @grupo")
vRP._prepare("leoz_groups/getMembro","SELECT * FROM leoz_groups_users WHERE id = @id")
vRP._prepare("leoz_painel/membros_grupo","SELECT * FROM leoz_permissions WHERE permiss = @grupo")
vRP._prepare("leoz_groups/addMembro","INSERT INTO leoz_groups_users (`id`, `nome`, `cargo`, `status`) VALUES (@id,@nome,@cargo,@status)")
vRP._prepare("leoz_groups/updateMembroStatus","UPDATE leoz_groups_users SET status = @status WHERE id = @id")

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
 function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("painel", function(source, args)
    local user_id = vRP.getUserId(source)
    local grupo = args[1] -- Obter o nome do grupo fornecido pelo jogador
    keyGlobal = nil
    
    if grupo then
        local grupoConfig = Config.grupos[grupo]
        if grupoConfig then
            if vRP.hasPermission(user_id, grupoConfig.grupos["Líder"].grupo) then
                TriggerClientEvent("abrir", source, user_id, grupoConfig.config.foto, grupo, "lider")
                return
            else
                if vRP.hasPermission(user_id, grupoConfig.grupos["Membros"].grupo) then
                    TriggerClientEvent("abrir", source, user_id, grupoConfig.config.foto, grupo, "membro")
                    return
                end
            end
        else
            -- Grupo inválido, enviar mensagem de erro ao jogador
            TriggerClientEvent(Config.notify, source, Config.notify_erro, "Grupo inválido.", 5000)
        end
    else
        -- Grupo não especificado, enviar mensagem de erro ao jogador
        TriggerClientEvent(Config.notify, source, Config.notify_erro, "Você precisa especificar o nome do grupo.", 5000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("home-page",function(key)
    local source = source -- pega a source de quem está usando o painel
    local user_id = vRP.getUserId(source) -- id do usuário que está usando o painel
    local identidade = vRP.userIdentity(user_id) -- identidade do usuário que está usando o painel
    local liderPermissoes = getUsersByGroup(Config.grupos[key].grupos["Líder"].grupo)
    local membrosPermissoes = getUsersByGroup(Config.grupos[key].grupos["Membros"].grupo)
    local membros_ativos = #liderPermissoes + #membrosPermissoes
    local todosMembros = getUsersByGroupDatable(Config.grupos[key].grupos["Membros"].grupo, Config.grupos[key].grupos["Líder"].grupo)
    local membros_totais_klein = #todosMembros --#liderPermissoes + #membrosPermissoes
    local construtor = {}
    local instancia = {}
    local tabela = {}
    local counter = 0
    keyGlobal = key

    for k, v in ipairs(membrosPermissoes) do
        if not vRP.hasPermission(v, Config.grupos[key].grupos["Líder"].grupo) then
            -- Verifica se o jogador já foi adicionado à tabela
            if not construtor[v] then
                counter = counter + 1
                local identity = vRP.userIdentity(v)
                local userName = (identity.name or "") .. " " .. (identity.name2 or "")
                construtor[v] = v .. " " .. userName
                tabela[counter] = {cargo = Config.grupos[key].grupos["Membros"].titulo, id = v, nome = userName} 
                local membro = vRP.query("leoz_groups/getMembro",{id = v})
                local cadastrado = false
                local logado = ""
                for k, v2 in pairs(membro) do
                    cadastrado = true
                    tabela[counter] = {
                        cargo = Config.grupos[key].grupos["Membros"].titulo,
                        id = v,
                        nome = userName,
                        logado = "",
                        status = "online"
                    }
                    if v2.status == "offline" then
                        vRP.query("leoz_groups/updateMembroStatus",{ id = v, status = "online" })
                    end
                end
                if cadastrado == false then
                    vRP.query("leoz_groups/addMembro",{cargo = Config.grupos[key].grupos["Membros"].titulo, id = v, nome = userName, status = "online" })
                    tabela[counter] = {
                        cargo = Config.grupos[key].grupos["Membros"].titulo,
                        id = v,
                        nome = userName,
                        logado = "",
                        status = "online"
                    }
                end
            end
        else
            membros_ativos = membros_ativos - 1
        end
    end 

    for k, v in ipairs(liderPermissoes) do
        local identity = vRP.userIdentity(v)
        local userName = (identity.name or "") .. " " .. (identity.name2 or "")
        -- Verifica se o jogador já foi adicionado à tabela
        if not construtor[v] then
            construtor[v] = v .. " " .. userName
            counter = counter + 1
            local membro = vRP.query("leoz_groups/getMembro",{id = v})
            local cadastrado = false
            local logado = ""
            for k, v2 in pairs(membro) do
                cadastrado = true
                tabela[counter] = {
                    cargo = Config.grupos[key].grupos["Líder"].titulo,
                    id = v,
                    nome = userName,
                    logado = "",
                    status = "online"
                }
                if v2.status == "offline" then
                    vRP.query("leoz_groups/updateMembroStatus",{ id = v, status = "online" })
                end
            end
            if cadastrado == false then
                vRP.query("leoz_groups/addMembro",{ cargo = Config.grupos[key].grupos["Líder"].titulo, id = v, nome = userName, status = "online" })
                tabela[counter] = {
                    cargo = Config.grupos[key].grupos["Líder"].titulo,
                    id = v,
                    nome = userName,
                    logado = "",
                    status = "online"
                }
            end
        end
    end

    for k, v2 in ipairs(Config.grupos[key].grupos["Membros"]) do
        local groupUsers = getUsersOfflineByGroup(v2.grupo);
        for k, v in ipairs(groupUsers) do
            if not vRP.hasPermission(v, v2.grupo) then
                local consult = vRP.query("vRP/get_group",{ user_id = v, permiss = tostring(Config.grupos[key].grupos["Líder"].grupo) })
                if not consult[1] then
                    -- Verifica se o jogador já foi adicionado à tabela
                    if not construtor[v] then
                        counter = counter + 1
                        local identity = vRP.userIdentity(v)
                        local userName = (identity.name or "") .. " " .. (identity.name2 or "")
                        construtor[v] = v .. " " .. userName
                        tabela[counter] = {cargo = v2.titulo, id = v, nome = userName} 
                        local membro = vRP.query("leoz_groups/getMembro",{id = v})
                        for k10, v10 in pairs(membro) do
                            tabela[counter] = {
                                cargo = v2.titulo,
                                id = v,
                                nome = userName,
                                logado = v10.logado,
                                status = "offline"
                            }
                        end
                    end
                else
                    membros_ativos = membros_ativos - 1
                end
            end
        end

    end

    local groupUsers = getUsersOfflineByGroup(Config.grupos[key].grupos["Líder"].grupo);

    for k, v in ipairs(groupUsers) do
        local users = vRP.userList()
        local nao_online = true
        for k10, v10 in pairs(users) do
            if v10 == v then
                nao_online = false
            end
        end
        if not nao_online then
            local identity = vRP.userIdentity(v)
            local userName = (identity.name or "") .. " " .. (identity.name2 or "")
            -- Verifica se o jogador já foi adicionado à tabela
            if not construtor[v] then
                construtor[v] = v .. " " .. userName
                counter = counter + 1
                local membro = vRP.query("leoz_groups/getMembro",{id = v})
                local cadastrado = false
                local logado = ""
                for k10, v10 in pairs(membro) do
                    tabela[counter] = {
                        cargo = Config.grupos[key].grupos["Líder"].titulo,
                        id = v,
                        nome = userName,
                        logado = v10.logado,
                        status = "offline"
                    }
                end
            end
        end
    end
    for k, v in pairs(construtor) do
        table.insert(instancia, v)
    end
    local total_membros = table.concat(instancia, ", ")
    local nome2 = (identidade.name or "") .. " " .. (identidade.name2 or "")
    TriggerClientEvent("home-page", source, membros_ativos, membros_totais_klein, nome2, tabela)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("leoz_painel:add-membro", function(user_id)
    local source = source
    local lider_id = vRP.getUserId(source)
    local lider_identity = vRP.userIdentity(lider_id)
    local user_id = parseInt(user_id)
    local user_identity = vRP.userIdentity(user_id)
    local user_source = vRP.getUserSource(user_id)
    local userTables = vRP.userData(user_id,"Datatable")
    local liderTables = vRP.userData(lider_id,"Datatable")
    
    if vRP.hasPermission(lider_id, Config.grupos[keyGlobal].grupos["Líder"].grupo) then
        if vRP.hasPermission(user_id, Config.grupos[keyGlobal].grupos["Líder"].grupo) then
            return TriggerClientEvent(Config.notify, source, Config.notify_erro, "Você não pode promover um líder", 10000)
        else
            local grupo = keyGlobal
            if user_id and grupo then
                local nsource = vRP.getUserSource(user_id)
                local tem_grupo = false
                if nsource then
                    if vRP.hasPermission(user_id, Config.grupos[keyGlobal].grupos["Líder"].grupo) then
                        tem_grupo = true
                    end
                    
                    if vRP.hasPermission(user_id, Config.grupos[keyGlobal].grupos["Membros"].grupo) then
                        tem_grupo = true
                    end
                    
                    -- for k10, v10 in pairs(Config.grupos) do
                    --     for k11, v11 in pairs(v10.grupos["Membros"]) do
                    --         if vRP.hasPermission(user_id, v11.grupo) then
                    --             tem_grupo = true
                    --         end
                    --     end
                        
                    --     if vRP.hasPermission(user_id, v10.grupos["Líder"].grupo) then
                    --         tem_grupo = true
                    --     end
                    -- end
                    
                    -- for k10, v10 in pairs(Config.blocklist) do
                    --     if vRP.hasPermission(user_id, v10) then
                    --         tem_grupo = true
                    --     end
                    -- end
                    
                    if tem_grupo == false then
                        local userName_lider = (lider_identity.name or "") .. " " .. (lider_identity.name2 or "")
                        local userName = (user_identity.name or "") .. " " .. (user_identity.name2 or "")

                        if vRP.request(user_source, "O(a) " .. userName_lider .. " te convidou para se juntar ao grupo <b>" .. keyGlobal .. "</b>", "Sim") then
                            local new_grupo = Config.grupos[keyGlobal].grupos["Membros"]

                            if new_grupo then
                                vRP.setPermission(user_id, new_grupo.grupo)
                                --vRP.execute("vRP/add_group", {user_id = parseInt(user_id), permiss = tostring(new_grupo.grupo)})
                                
                                TriggerClientEvent(Config.notify, source, Config.notify_sucesso, "Você <b>adicionou</b> o membro " .. userName .. " ao cargo <b>" .. new_grupo.titulo .. "</b> !", 5000)
                                TriggerEvent("membros-page-2", source)
                                
                                -- Enviar evento para o jogador contratado
                                TriggerClientEvent(Config.notify, user_source, Config.notify_sucesso, "Você foi contratado por " .. userName_lider .. " para se juntar ao grupo <b>" .. keyGlobal .. "</b> como <b>" .. new_grupo.titulo .. "</b> !", 5000)
                                
                                -- Enviar webhook para registrar a contratação
                                SendWebhookMessage(Config.webhooks.promover, "```prolog\n[ID]: " .. tostring(lider_id) .. "\n[Nome do líder]: " .. tostring(userName_lider) .. "\n[Contratou]: " .. tostring(user_id) .. "\n[Nome do contratado]: " .. tostring(userName) .. "\n[Grupo]: " .. tostring(keyGlobal) .. "\n[Cargo]: " .. tostring(new_grupo.titulo) .. "\n[Data]: " .. os.date("%d/%m/%Y") .. " [Hora]: " .. os.date("%H:%M:%S") .. "\n```")
                            end
                        end
                    else
                        TriggerClientEvent(Config.notify, source, Config.notify_erro, "O passaporte <b>" .. user_id .. "</b> já <b>pertence</b> a um grupo", 10000)
                    end
                else
                    TriggerClientEvent(Config.notify, source, Config.notify_erro, "O passaporte <b>" .. user_id .. "</b> <b>não está</b> ativo na cidade", 10000)
                end
            end
        end
    end

end)

-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("membros-page",function(key)
        local source = source -- pega a source de quem esta usando o painel
        local user_id = vRP.getUserId(source) -- id do usuario que esta usando o painel
        local identidade = vRP.userIdentity(user_id) -- identidade do usuario que esta usando o painel
        local todosMembros = getUsersByGroupDatable(Config.grupos[keyGlobal].grupos["Membros"].grupo, Config.grupos[keyGlobal].grupos["Líder"].grupo)
        local userTables = vRP.userData(user_id,"Datatable")
        local construtor = {}
        local instancia = {}
        local tabela = {}
        local counter = 0

        if vRP.hasPermission(user_id, Config.grupos[keyGlobal].grupos["Líder"].grupo) then
            local liderPermissoes = getUsersByGroup(Config.grupos[keyGlobal].grupos["Líder"].grupo)
            for k, v in ipairs(todosMembros) do
                local identity = vRP.userIdentity(v)
                local userName = (identity.name or "") .. " " .. (identity.name2 or "")
                local cargoValue = Config.grupos[keyGlobal].grupos["Membros"].titulo
                construtor[v] = v .. " " .. userName
                counter = counter + 1

                local userTables = vRP.userData(v,"Datatable")

                if userTables["perm"] then
                    if userTables["perm"][Config.grupos[keyGlobal].grupos["Líder"].grupo] then
                        cargoValue = Config.grupos[keyGlobal].grupos["Líder"].titulo
                    end
                end

                tabela[counter] = {
                    cargo = cargoValue,
                    id = v,
                    nome = userName
                }
            end
            for k, v2 in ipairs(Config.grupos[keyGlobal].grupos["Membros"]) do
                local groupUsers = getUsersByGroup(v2.grupo)
                for k, v in ipairs(groupUsers) do
                    if not vRP.hasPermission(v, Config.grupos[keyGlobal].grupos["Líder"].grupo) then
                    counter = counter + 1
                    local identity = vRP.userIdentity(v)
                    local userName = (identity.name or "") .. " " .. (identity.name2 or "")
                    construtor[v] = v .. " " .. userName
                    tabela[counter] = {cargo = v2.titulo, id = v, nome = userName}
                    end
                end
            end
            end
    TriggerClientEvent("membros-page", source, tabela)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("membros-page",function(src)
        local source = src -- pega a source de quem esta usando o painel
        local user_id = vRP.getUserId(source) -- id do usuario que esta usando o painel
        local identidade = vRP.userIdentity(user_id) -- identidade do usuario que esta usando o painel
        local construtor = {}
        local instancia = {}
        local tabela = {}
        local counter = 0

        for key, value in pairs(Config.grupos) do
            if vRP.hasPermission(user_id, value.grupos["Líder"].grupo) then
                local liderPermissoes = getUsersByGroup(Config.grupos[key].grupos["Líder"].grupo)
                for k, v in ipairs(liderPermissoes) do
                    local identity = vRP.userIdentity(v)
                    local userName = (identity.name or "") .. " " .. (identity.name2 or "")
                    construtor[v] = v .. " " .. userName
                    counter = counter + 1
                    tabela[counter] = {
                        cargo = Config.grupos[key].grupos["Líder"].titulo,
                        id = v,
                        nome = userName
                    }
                end
                for k, v2 in ipairs(Config.grupos[key].grupos["Membros"]) do
                    local groupUsers = getUsersByGroup(v2.grupo)
                    for k, v in ipairs(groupUsers) do
                        if not vRP.hasPermission(v, Config.grupos[key].grupos["Líder"].grupo) then
                        counter = counter + 1
                        local identity = vRP.userIdentity(v)
                        local userName = (identity.name or "") .. " " .. (identity.name2 or "")
                        construtor[v] = v .. " " .. userName
                        tabela[counter] = {cargo = v2.titulo, id = v, nome = userName}
                        end
                    end
                end
            end
        end
        TriggerClientEvent("membros-page", source, tabela)
    end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("leoz_painel:promover-membro", function(user_id)
    local source = source
    local lider_id = vRP.getUserId(source)
    local lider_identity = vRP.userIdentity(lider_id)
    local user_id = parseInt(user_id)
    local user_identity = vRP.userIdentity(user_id)
    
    for key, value in pairs(Config.grupos) do
        if vRP.hasPermission(lider_id, value.grupos["Líder"].grupo) then
            if vRP.hasPermission(user_id, value.grupos["Líder"].grupo) then
                return TriggerClientEvent(Config.notify, source, Config.notify_erro, "Você não pode promover um líder", 10000)
            else
                local grupo = key
                if user_id and grupo then
                    local nsource = vRP.getUserSource(user_id)
                    local tem_grupo = false
                    
                    if nsource then
                        if vRP.hasPermission(user_id, value.grupos["Líder"].grupo) then
                            tem_grupo = true
                        end
                        
                        for k6, v6 in pairs(value.grupos["Membros"]) do
                            if vRP.hasPermission(user_id, v6.grupo) then
                                tem_grupo = true
                            end
                        end
                        
                        if tem_grupo == true then
                            local request = vRP.request(source, "Você tem certeza que deseja promover <b>" .. user_identity.name .. "</b>?", 30)
                            
                            if request then
                                for k6, v6 in pairs(value.grupos["Membros"]) do
                                    if vRP.hasPermission(user_id, v6.grupo) then
                                        if k6 == 0 then
                                            return TriggerClientEvent(Config.notify, source, Config.notify_erro, "Membro já está no maior cargo", 10000)
                                        else
                                            local new_grupo_index = k6 + 1
                                            
                                            if new_grupo_index >= 0 then
                                                local new_grupo = value.grupos["Membros"][new_grupo_index]
                                                
                                                if new_grupo then
                                                    vRP.remPermission(user_id, v6.grupo)
                                                    --vRP.execute("vRP/del_group", {user_id = parseInt(user_id), permiss = tostring(v6.grupo)})
                                                    vRP.setPermission(user_id, new_grupo.grupo)
                                                   -- vRP.execute("vRP/add_group", {user_id = parseInt(user_id), permiss = tostring(new_grupo.grupo)})
                                                    
                                                    local userName = (user_identity.name or "") .. " " .. (user_identity.name2 or "")
                                                    local userName_lider = (lider_identity.name or "") .. " " .. (lider_identity.name2 or "")
                                                    
                                                    TriggerClientEvent(Config.notify, source, Config.notify_sucesso, "Você <b>promoveu</b> o membro " .. userName .. " para o cargo <b>" .. new_grupo.titulo .. "</b> !", 5000)
                                                    
                                                    -- Enviar evento para o jogador promovido
                                                    TriggerClientEvent(Config.notify, nsource, Config.notify_sucesso, "Você foi promovido por " .. userName_lider .. " para o cargo <b>" .. new_grupo.titulo .. "</b> !", 5000)
                                                    
                                                    -- Enviar webhook para registrar a promoção
                                                    SendWebhookMessage(Config.webhooks.promover, "```prolog\n[ID]: " .. tostring(userName_lider) .. " " .. tostring(lider_id) .. "\n[PROMOVEU]: " .. tostring(userName) .. " " .. tostring(user_id) .. " \n[GRUPO]: " .. tostring(key) .. " \n[CARGO ANTERIOR]: " .. tostring(v6.titulo) .. " \n[NOVO CARGO]: " .. tostring(new_grupo.titulo) .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```")
                                                    
                                                    TriggerEvent("membros-page-2", source)
                                                    
                                                    return
                                                elseif new_grupo == nil then
                                                    TriggerClientEvent(Config.notify, source, Config.notify_erro, "Membro já está no maior cargo", 10000)
                                                    
                                                    return
                                                end
                                            else
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        TriggerClientEvent(Config.notify, source, Config.notify_erro, "O passaporte <b>" .. user_id .. "</b> não <b>pertence</b> ao grupo <b>" .. key .. "</b>.", 10000)
                    end
                else
                    TriggerClientEvent(Config.notify, source, Config.notify_erro, "O passaporte <b>" .. user_id .. "</b> não <b>está</b> ativo na <b>cidade</b>.", 10000)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("leoz_painel:demitir-membro",function(user_id)
        local source = source
        local lider_id = vRP.getUserId(source)
        local lider_identity = vRP.userIdentity(lider_id)
        local user_id = parseInt(user_id)
        local user_identity = vRP.userIdentity(user_id)
        local userTables = vRP.userData(user_id,"Datatable")

        if vRP.hasPermission(lider_id, Config.grupos[keyGlobal].grupos["Líder"].grupo) then
            if userTables["perm"][Config.grupos[keyGlobal].grupos["Líder"].grupo] then
                return TriggerClientEvent(Config.notify, source, Config.notify_erro, "Você não pode demitir um líder", 10000)
            else
            local grupo = keyGlobal

            if user_id and grupo then
            local nsource = vRP.getUserSource(user_id)
            local tem_grupo = true

            if true then
                if vRP.hasPermission(user_id, Config.grupos[keyGlobal].grupos["Líder"].grupo) then
                    tem_grupo = true
                end

                if tem_grupo == true then
                    if true then
                        vRP.remPermission(user_id, Config.grupos[keyGlobal].grupos["Membros"].grupo)
                        --vRP.cleanPermission(user_id)
                        --vRP.execute("vRP/del_group",{ user_id = parseInt(user_id), permiss = tostring(Config.grupos[keyGlobal].grupos["Membros"].grupo) })
                        local userName = (user_identity.name or "") .. " " .. (user_identity.name2 or "")
                        TriggerClientEvent(Config.notify,source,Config.notify_sucesso,"Você <b>demitiu</b> o membro ".. userName .." do grupo <b>".. keyGlobal .."</b> !",5000)
                        TriggerClientEvent(Config.notify,user_id,Config.notify_credito,"Você foi <b>demitido</b> do grupo <b>".. keyGlobal .."</b> !",5000)
                        TriggerClientEvent("close-demitir", source)
                        local userName_lider = (lider_identity.name or "") .. " " .. (lider_identity.name2 or "")
                        SendWebhookMessage(Config.webhooks.demitir,"```prolog\n[ID]: "..tostring(userName_lider).." "..tostring(lider_id).."\n[DEMITIU]: "..tostring(userName).." "..tostring(user_id).." \n[GRUPO]: "..tostring(keyGlobal).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                        TriggerEvent("membros-page-2", source)
                    end
                end
            else
                TriggerClientEvent(Config.notify,source,Config.notify_erro,"O passaporte <b>" .. user_id .. "</b> já <b>pertence</b> ao grupo <b>" .. keyGlobal .. "</b>.", 10000)
            end
        end
         end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [[
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bau-page", function()
        local source = source -- pega a source de quem esta usando o painel
        local user_id = vRP.getUserId(source) -- id do usuario que esta usando o painel
        local identidade2 = vRP.userIdentity(user_id) -- identidade do usuario que esta usando o painel

        for k, v in pairs(Config.grupos) do
            if vRP.hasPermission(user_id, v.grupos["Líder"].grupo) then
                local bau_logs =
                    vRP.query( "leoz_groups/getbau", { grupo = k })
                TriggerClientEvent("bau-page", source, bau_logs)
            else
                for k2, v2 in pairs(v.grupos["Membros"]) do
                    if vRP.hasPermission(user_id, v2.grupo) then
                        local bau_logs =
                            vRP.query( "leoz_groups/getbau", { grupo = k })
                        TriggerClientEvent("bau-page", source, bau_logs)
                    end
                end
            end
        end
    end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("banco-page", function()
        local source = source -- pega a source de quem esta usando o painel
        local user_id = vRP.getUserId(source) -- id do usuario que esta usando o painel
        local identidade2 = vRP.userIdentity(user_id) -- identidade do usuario que esta usando o painel

        for key, value in pairs(Config.grupos) do
            if vRP.hasPermission(user_id, value.grupos["Líder"].grupo) then
                local lider = false
                local logs_bau = vRP.query("leoz_groups/getbanco", {grupo = tostring(key)})
                local dados = logs_bau
                local saldo = vRP.query("leoz_groups/getSaldo", {grupo = tostring(key)})
                local saldo2 = 0
                for k10, v10 in pairs(saldo) do
                    if v10.saldo then
                        saldo2 = v10.saldo
                    else
                        saldo2 = 0
                    end
                end
                TriggerClientEvent("banco-page", source, dados, tostring(saldo2))
            else
                for k20, v10 in pairs(value.grupos["Membros"]) do
                    if vRP.hasPermission(user_id, v10.grupo) then
                        local lider = false
                        local logs_bau = vRP.query("leoz_groups/getbanco", {grupo = tostring(key)})
                        local saldo = vRP.query("leoz_groups/getSaldo", {grupo = tostring(key)})
                        local saldo2 = 0
                        for k10, v10 in pairs(saldo) do
                            if v10.saldo then
                                saldo2 = v10.saldo
                            else
                                saldo2 = 0
                            end
                        end
                        local dados = logs_bau
                        TriggerClientEvent("banco-page", source, dados, tostring(saldo2))
                    end
                end
            end
        end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("banco-page-2",function(src)
        local source = src -- pega a source de quem esta usando o painel
        local user_id = vRP.getUserId(source) -- id do usuario que esta usando o painel
        local identidade2 = vRP.userIdentity(user_id) -- identidade do usuario que esta usando o painel
        for key, value in pairs(Config.grupos) do
            if vRP.hasPermission(user_id, value.grupos["Líder"].grupo) then
                local lider = false
                local logs_bau = vRP.query("leoz_groups/getbanco", {grupo = tostring(key)})
                local dados = logs_bau
                local saldo = vRP.query("leoz_groups/getSaldo", {grupo = tostring(key)})
                local saldo2 = 0
                for k10, v10 in pairs(saldo) do
                    if v10.saldo then
                        saldo2 = v10.saldo
                    else
                        saldo2 = 0
                    end
                end
                TriggerClientEvent("banco-page", source, dados, tostring(saldo2))
            else
                for k20, v10 in pairs(value.grupos["Membros"]) do
                    if vRP.hasPermission(user_id, v10.grupo) then
                        local lider = false
                        local logs_bau = vRP.query("leoz_groups/getbanco", {grupo = tostring(key)})
                        local saldo = vRP.query("leoz_groups/getSaldo", {grupo = tostring(key)})
                        local saldo2 = 0
                        for k10, v10 in pairs(saldo) do
                            if v10.saldo then
                                saldo2 = v10.saldo
                            else
                                saldo2 = 0
                            end
                        end
                        local dados = logs_bau
                        TriggerClientEvent("banco-page", source, dados, tostring(saldo2))
                    end
                end
            end
        end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [[
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent( "uz_painel:addlogbau", function(user_id, acao, item, quantidade, grupo)
        print(grupo)
        if Config.printbau then
            print(grupo)
        end
        local user_id = user_id
        local horario = os.time(os.date("!*t"))
        local identity = vRP.userIdentity(user_id)
        local nome = (identity.name or "") .. " " .. (identity.name2 or "")
        for k, v in pairs(Config.grupos) do
            if v.config.bau == grupo then
                vRP._execute( "leoz_groups/addBauLog",{ membro_id = user_id, membro_nome = nome, colocou = acao, item = item, quantidade = quantidade, grupo = k })
                if acao == true then
                    SendWebhookMessage(Config.webhooks.bau,"```prolog\n[ID]: "..tostring(nome).." "..tostring(user_id).."\n[COLOCOU NO BAU]: "..tostring(item).." \n[QUANTIDADE]: "..tostring(quantidade).."\n[GRUPO]: "..tostring(k).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                else
                    SendWebhookMessage(Config.webhooks.bau,"```prolog\n[ID]: "..tostring(nome).." "..tostring(user_id).."\n[RETIROU DO BAU]: "..tostring(item).." \n[QUANTIDADE]: "..tostring(quantidade).."\n[GRUPO]: "..tostring(k).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                end

            end
        end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("leoz_painel:depositar",function()
        local source = source -- pega a source de quem esta usando o painel
        local user_id = vRP.getUserId(source) -- id do usuario que esta usando o painel
        local valor = vRP.prompt(source, "Valor","")

            if tonumber(valor) then
                local acao = false
                    for key, value in pairs(Config.grupos) do
                        if vRP.hasPermission(user_id, value.grupos["Líder"].grupo) then
                            local identidade = vRP.userIdentity(user_id)
                            local userName = (identidade.name or "") .. " " .. (identidade.name2 or "")
                            local horario = os.time(os.date("!*t"))
                            local saldo = vRP.query("leoz_groups/getSaldo", {grupo = tostring(key)})
                            local existe = false 
                            for k10, v10 in pairs(saldo) do
                               existe = true
                        
                               local money_a = 0;
                               if v10.saldo then
                                if v10.saldo > 0 then
                                    money_a = v10.saldo + tonumber(valor)
                                   else
                                     money_a = tonumber(valor)
                                   end
                                else
                                    money_a = tonumber(valor)
                                end
                            
                                if money_a > 0 then
                                    if vRP.getBank(user_id) >= tonumber(valor) then
                                        vRP.delBank(user_id, tonumber(valor))
                                        vRP._execute("leoz_groups/updateSaldo",{ grupo = key, saldo = money_a })
                                            TriggerClientEvent(Config.notify,source,Config.notify_debito,"Você <b>depositou</b> com sucesso <b>R$".. valor .."</b> no banco do grupo "..key.."!",5000)
                                            local logs_bau = vRP.query("leoz_groups/getbanco", {grupo = tostring(key)})
                                            TriggerEvent("banco-page-2", source)
                                        vRP._execute("leoz_groups/addTransacao", { id = user_id, grupo = key, deposito = "true", nome = userName, valor = tonumber(valor) })
                                        SendWebhookMessage(Config.webhooks.banco,"```prolog\n[ID]: "..tostring(userName).." "..tostring(user_id).."\n[DEPOSITOU]: R$"..tostring(valor).." \n[GRUPO]: "..tostring(key)..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                    else
                                        TriggerClientEvent(Config.notify,source,Config.notify_erro,"Valor <b>insuficiente<b/>!",5000)
                                    end
                                    
                                end
                      
                            end
                            if existe == false then
                                    vRP._execute("leoz_groups/create",{ grupo = key })
                                   vRP._execute("leoz_groups/addTransacao", { id = user_id, grupo = key, deposito = "true", nome = userName, valor = tonumber(valor) })
                            end
                            
                        else
                            for k, v in ipairs(value.grupos["Membros"]) do
                                if vRP.hasPermission(user_id, v.grupo) then
                                    local identidade = vRP.userIdentity(user_id)
                                    local userName = (identidade.name or "") .. " " .. (identidade.name2 or "")
                                    local horario = os.time(os.date("!*t"))
                                    local existe = false 
                                    local saldo = vRP.query("leoz_groups/getSaldo", {grupo = tostring(key)})
                            for k10, v10 in pairs(saldo) do
                               existe = true
                        
                               local money_a = 0;
                               if v10.saldo then
                                if v10.saldo > 0 then
                                    money_a = v10.saldo + tonumber(valor)
                                   else
                                     money_a = tonumber(valor)
                                   end
                                else
                                    money_a = tonumber(valor)
                                end
                            
                                if money_a > 0 then
                                    if vRP.getBank(user_id) >= tonumber(valor) then
                                        vRP.delBank(user_id, tonumber(valor))
                                        vRP._execute("leoz_groups/updateSaldo",{ grupo = key, saldo = money_a })
                                            TriggerClientEvent(Config.notify,source,Config.notify_debito,"Você <b>depositou</b> com sucesso <b>R$".. valor .."</b> no banco do grupo "..key.."!",5000)
                                            local logs_bau = vRP.query("leoz_groups/getbanco", {grupo = tostring(key)})
                                            TriggerEvent("banco-page-2", source)
                                        vRP._execute("leoz_groups/addTransacao", { id = user_id, grupo = key, deposito = "true",  nome = userName, valor = tonumber(valor) })
                                        SendWebhookMessage(Config.webhooks.banco,"```prolog\n[ID]: "..tostring(userName).." "..tostring(user_id).."\n[DEPOSITOU]: R$"..tostring(valor).." \n[GRUPO]: "..tostring(key)..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                    else
                                        TriggerClientEvent(Config.notify,source,Config.notify_erro,"Valor <b>insuficiente<b/>!",5000)
                                    end
                                end
                            end
                            if existe == false then
                                vRP._execute("leoz_groups/create",{ grupo = key, valor = tonumber(valor) })
                                vRP._execute("leoz_groups/addTransacao", { id = user_id, grupo = key, deposito = "true", nome = userName, valor = tonumber(valor) })
                            end
                        end
                            end
                        end
                    end
            else
                TriggerClientEvent(Config.notify, source, Config.notify_erro, "Valor <b>inválido</b>",5000)
            end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("leoz_painel:sacar", function()
        local source = source -- pega a source de quem esta usando o painel
        local user_id = vRP.getUserId(source) -- id do usuario que esta usando o painel
        local valor = vRP.prompt(source, "Valor que você deseja sacar","")

            if tonumber(valor) then
                local request = vRP.request(source,"Você tem certeza que deseja sacar este valor?",30)
                if request then
                    for key, value in pairs(Config.grupos) do
                        local lider = false
                        if vRP.hasPermission(user_id, value.grupos["Líder"].grupo) then
                            lider = true
                            local identidade = vRP.userIdentity(user_id)
                            local userName = (identidade.name or "") .. " " .. (identidade.firstname or "")
                            local horario = os.time(os.date("!*t"))
                            local saldo = vRP.query("leoz_groups/getSaldo", {grupo = tostring(key)})
                            for k10, v10 in pairs(saldo) do
                               existe = true

                               local money_a = 0;
                               if v10.saldo then
                                if v10.saldo > 0 then
                                    money_a = v10.saldo - tonumber(valor)
                                   else
                                     money_a = tonumber(valor)
                                   end
                                else
                                    money_a = tonumber(valor)
                                end

                                if money_a >= 0 then
                                    local saldo2 = vRP.query("leoz_groups/getSaldo", {grupo = tostring(key)})
                                    for k20, v20 in pairs(saldo) do
                                        if v20.saldo > 0 then
                                            vRP._execute("leoz_groups/updateSaldo",{
                                                grupo = key, saldo = money_a
                                                })
                                                local data_atual = os.time(os.date("!*t"))
                                                vRP._execute("leoz_groups/addTransacao", {
                                                    id = user_id,
                                                    grupo = key,
                                                    deposito = "false",
                                                    nome = userName,
                                                    valor = tonumber(valor),
                                                    data_transacao = data_atual
                                                })
                                                TriggerClientEvent("Notify",source,"sucesso","Você <b>sacou</b> com sucesso <b>R$".. valor .."</b> no banco do grupo "..key.."!",5000)
                                                local logs_bau = vRP.query("leoz_groups/getbanco", {grupo = tostring(key)})
                                                TriggerEvent("banco-page-2", source)
                                                vRP.giveBankMoney(user_id,tonumber(valor))
                                                SendWebhookMessage(Config.webhooks.banco,"```prolog\n[ID]: "..tostring(userName).." "..tostring(user_id).."\n[SACOU]: R$"..tostring(valor).." \n[GRUPO]: "..tostring(key)..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")  
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Valor <b>insuficiente<b/>!",5000)
                                        end
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Valor <b>insuficiente<b/>!",5000)
                                end
                            end
                            if existe == false then
                                    vRP._execute("leoz_groups/create",{ grupo = key })
                                local data_atual = os.time(os.date("!*t"))
                                vRP._execute("leoz_groups/addTransacao", { id = user_id, grupo = key, deposito = "false", nome = userName, valor = tonumber(valor), data_transacao = data_atual })
                            end
                        end
                    end
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Valor <b>inválido</b>",5000)
            end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
function getUsersOfflineByGroup(group)
    local instancia = {}
    local membros = vRP.query("leoz_painel/membros_grupo", {grupo = group})
    for k10, v10 in pairs(membros) do
        table.insert(instancia, v10.user_id)
    end
    return instancia
end
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
function getUsersByGroup(group)
    local instancia = {}
    for user_id, source in pairs(vRP.userList()) do
        if vRP.hasGroup(user_id, group) then
            table.insert(instancia, user_id)
        end
    end
    return instancia
end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
function getUsersByGroupDatable(groupMembro, groupLider)
    local instancia = {}
    local allMembros = vRP.query("characters/allChars", {})
    for k, membro in pairs(allMembros) do
        local userTables = vRP.userData(allMembros[k]["id"],"Datatable")

        if userTables["perm"] then
            if userTables["perm"][groupMembro] or userTables["perm"][groupLider] then
                table.insert(instancia, allMembros[k]["id"])
                -- print(allMembros[k]["id"])
                -- print(allMembros[k]["name"])
                -- print(allMembros[k]["name2"])
            end
        end
        -- if vRP.hasPermission(membro.id, group) then

        -- end

        -- if vRP.hasGroup(allMembros[k]["id"], group) then
        --     table.insert(instancia, allMembros[k]["id"])
        -- end
    end
    return instancia
end
-----------------------------------------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped', function (reason)
    local v = vRP.getUserId(source) -- id do usuario que esta usando o painel
    local membro = vRP.query("leoz_groups/getMembro",{id = v})
    for k, v2 in pairs(membro) do
        cadastrado = true
            vRP.query("leoz_groups/updateMembroStatus",{ id = v, status = "offline" })
    end
end)