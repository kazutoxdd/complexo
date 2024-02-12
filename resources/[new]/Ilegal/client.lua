-- RegisterCommand("criargrupo", function(id)
--     onNui = not onNui
--     if onNui then
--         SetNuiFocus(true, true)
--         SendNUIMessage({
--             action = "abrir-criar-grupo",
--             data = {
--                 id: id,
--                 nome: 
--             }
--         })
--     else
--         SetNuiFocus(false)
--         SendNUIMessage({
--             action = "fechar-criar-grupo"
--         })
--     end
-- end)
RegisterNetEvent('abrir', function(user_id, foto, grupo, permissao)
    onNui = not onNui
    if onNui then
        TriggerServerEvent("home-page",grupo)
        SetNuiFocus(true, true)

        SendNUIMessage({
            action = "abrir",
            data = {
                id = user_id, 
                foto = foto,
                grupo = grupo,
                permissao = permissao
            }
        })
    else
        SetNuiFocus(false)
        SendNUIMessage({
            action = "fechar"
        })
    end
end)

RegisterNetEvent('home-page', function(ativos, total, nome, data)
    SendNUIMessage({
        action = "home-page",
        online = ativos,
        total = total,
        nome = nome,
        dados = data
    })
end)

RegisterNetEvent('membros-page', function(data)
    SendNUIMessage({
        action = "membros-page",
        dados = data
    })
end)

RegisterNetEvent('close-demitir', function(ativos, total, nome, data)
    SendNUIMessage({
        action = "close-demitir"
    })
end)

RegisterNetEvent('bau-page', function(data)
    SendNUIMessage({
        action = "bau-page",
        dados = data
    })
end)

RegisterNetEvent('banco-page', function(data,saldo,permissao)
    SendNUIMessage({
        action = "banco-page",
        dados = data,
        saldo = saldo,
        permissao = permissao
    })
end)


RegisterNUICallback('bau-page', function()
    TriggerServerEvent('bau-page')
end)

RegisterNUICallback('adicionar-saldo', function()
    TriggerServerEvent('leoz_painel:depositar')
end)

RegisterNUICallback('remover-saldo', function()
    TriggerServerEvent('leoz_painel:sacar')
end)

RegisterNUICallback('promover-membro', function(data)
    if tonumber(data.id) then
        TriggerServerEvent('leoz_painel:promover-membro', data.id); 
    end
end)


RegisterNUICallback('banco-page', function()
    TriggerServerEvent('banco-page')
end)

RegisterNUICallback('depositar', function()
    TriggerServerEvent('rspainel:depositar')
end)

RegisterNUICallback('membros-page', function()
    TriggerServerEvent('membros-page')
end)

RegisterNUICallback("demitir-membro", function(data)
    if tonumber(data.id) then 
        TriggerServerEvent("leoz_painel:demitir-membro", data.id)
    end
end)

RegisterNUICallback("fechar", function()
    onNui = not onNui
    SetNuiFocus(false)
    SendNUIMessage({
        action = "fechar"
    })
end)

RegisterNUICallback("criargrupo", function(data)
    if tonumber(data.lider) then 
        TriggerServerEvent("leoz_painel:criargrupo", data.nome, data.lider)
    end
end)

RegisterNUICallback("pagar", function(data)
    TriggerServerEvent('jose:pagamento', data.dinheiro)
end)

RegisterNUICallback("add-membro", function(data)
    if tonumber(data.id) then 
        TriggerServerEvent("leoz_painel:add-membro", data.id)
    end
end)

RegisterNetEvent('membros-page', function(data)
    SendNUIMessage({
        action = "membros-page",
        dados = data
    })
end)