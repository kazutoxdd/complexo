$(() => {
    $()
    $("body").hide()
    $(".criar-grupo").hide()
    $(".home").hide()
    $('.pop-up-criar-grupo').hide();
    $(".pop-up-criar-grupo-criado").hide();
    $(".id_lider").val("");
    $(".nome_grupo").val("");
    $(".criar-grupo").hide()

    $(".home-page").hide();
    $(".membros-page").hide();
    $(".bau-page").hide();
    $(".banco-page").hide();

    $(".add-membro-popup").hide();
    $(".demitir-membro-popup").hide();

    window.addEventListener("message", function (event) {
        if (event.data.action != undefined) {
            let status = event.data.action
            if (status == "abrir-criar-grupo") {
                $("body").show()
                $(".criar-grupo").show()
            } else if (status == "fechar-criar-grupo") {
                $("body").hide()
                $(".criar-grupo").hide()
                $(".home").hide()
                $('.pop-up-criar-grupo').hide();
                $(".pop-up-criar-grupo-criado").hide();
                $(".blur-criar-grupo").css("filter", "blur(0px)")
            } else if (status == "fechar") {
                $("body").hide()
                $("body").hide()
                $(".home").hide()
                $(".home-page").hide();
                $(".add-membro-popup").hide();
                $(".demitir-membro-popup").hide();
            } else if (status == "abrir") {
                var permissao = event.data.data.permissao
                if (permissao == "lider") {
                    $("#membros-option").show();
                    $("body").show()
                    $(".home").show()
                    $(".home-page").show();
                    $(".membros-page").hide();
                    $(".bau-page").hide();
                    $(".banco-page").hide();
                    $(".nome-grupo-img").attr("src", event.data.data.foto);
                    $(".nome-grupo-p").text(event.data.data.grupo)
                } else if (permissao == "membro") {
                    $("#membros-option").hide();
                    $("body").show()
                    $(".home").show()
                    $(".home-page").show();
                    $(".membros-page").hide();
                    $(".bau-page").hide();
                    $(".banco-page").hide();
                    $(".nome-grupo-img").attr("src", event.data.data.foto);
                    $(".nome-grupo-p").text(event.data.data.grupo)
                }

            }
        }
    })

    window.addEventListener("message", function (event) {
        if (event.data.action == "home-page") {

            $("#home-page-content-bem-vindo").text(`Bem-vindo, ${event.data.nome}`) // altera o bem vindo com o nome de quem esta usando o painel
            $("#contador-membros-ativos").text(event.data.online) // altera o numero de membros online
            $("#contador-membros-total").text(event.data.total) // altera o numero de membros no total do grupo
            var content = "<table cellspacing='0' class='tabela-membros-home'><thead> <tr> <th> Cargo </th> <th> Nome </th> <th> Última vez acordado </th> <th> Status </th> </tr> </thead>"
            var dados = event.data.dados
            dados.forEach(e => {
                var hora = moment(parseInt(e.logado)).locale('pt-br').format('DD/MM - hh:mm');
                content += '<tbody> <tr class="membros-dados"><td>' + e.cargo + '</td>';
                content += '<td>' + e.nome + " | " + `${e.id}` + '</td>';
                if(e.status == "online"){
                    content += '<td>' + `Agora` + '</td>';
                }else{
                    content += '<td>' + `${hora}` + '</td>';
                }
                if(e.status == "online"){
                    content += '<td>' + `<img style="width:25px;height:25px;"src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Ski_trail_rating_symbol-green_circle.svg/1200px-Ski_trail_rating_symbol-green_circle.svg.png"/>` + '</td>';
                }else{
                    content += '<td>' + `<img style="width:25px;height:25px;"src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/LACMTA_Circle_Red_Line.svg/1200px-LACMTA_Circle_Red_Line.svg.png"/>` + '</td>';
                }
                content += `<td> </td></tr></tbody>`;
            })
            content += "</table>"
            $('.home-page-content').html(content);
        }
        if (event.data.action == "membros-page") {
            var dados = event.data.dados
            var content = "<table cellspacing='0' class='tabela-membros'><thead> <tr> <th> Cargo </th> <th> Nome </th> </tr> </thead>"
            var dados = event.data.dados
            dados.forEach(e => {
                content += '<tbody> <tr class="membros-dados-2"><td>' + e.cargo + '</td>';
                content += '<td>' + e.nome + "  |  " + `${e.id}` + '</td>';
                // content += `<td><button class="info-btn" id="info-${e.id}">Info</button></td>`;
                content += `<td><button class="promover-btn" id="promover-${e.id}">Promover</button></td>`;
                content += `<td><button class="demitir-btn" id="demitir-${e.id}">Demitir </button></td>`;
                content += `<td> </td></tr></tbody>`;
            })
            content += "</table>"
            $('.membros-page-table').html(content);
            $(".demitir-btn").on("click", function () {
                $(".demitir-membro-popup").show();
                var id = $(this).attr("id").replace("demitir-", "")
                $(".demitir-do-grupo").attr("id", `demitir2-${id}`)
            })
            $(".promover-btn").on("click", function () {
                var id = $(this).attr("id").replace("promover-", "")
                fetch(`https://${GetParentResourceName()}/promover-membro`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: JSON.stringify({
                        id: id
                    })
                })
            })
        }
        if (event.data.action == "close-demitir") {
            $(".demitir-membro-popup").hide();
        }
        if (event.data.action == "bau-page") {
            var content = "<table cellspacing='0' class='tabela-bau'><thead> <tr> <th> Nome </th> <th> Item </th> <th> Quantidade </th> <th> Ação </th>  <th> Data e Hora </th> </tr> </thead>"
            var dados = event.data.dados
            dados.forEach(e => {
                var hora = moment(parseInt(e.data_transacao)).locale('pt-br').format('DD/MM - hh:mm');
                var acao = "https://media.discordapp.net/attachments/915695615772594236/930643960244875284/down.png"
                if (e.colocou == 1) acao = "https://media.discordapp.net/attachments/915695615772594236/930645007948447794/uplo.png"
                content += '<tbody> <tr class="bau-dados-2">';
                content += '<td>' + e.membro_nome + "  |  " + `${e.membro_id}` + '</td>';
                content += '<td>' + e.item + '</td>';
                content += '<td>' + e.quantidade + "x" + '</td>';

                content += '<td>' + `<img src='${acao}' ></img>` + '</td>';
                content += '<td>' + `${hora}` + '</td>';
                content += `<td> </td></tr></tbody>`;
            })
            content += "</table>"
            $('.bau-page-table').html(content);
        }
        if (event.data.action == "banco-page") {
            var content = "<table cellspacing='0' class='tabela-bau'><thead> <tr> <th> Nome </th> <th> Valor </th> <th> Ação </th> <th> Data e Hora </th> </tr> </thead>"
            var dados = event.data.dados
            $('.banco-page-table').html(content);
            if (event.data.permissao == "membro") {
                $(".remover-saldo").hide();
            }
            dados.forEach(e => {
                var hora = moment(parseInt(e.data_transacao)).locale('pt-br').format('DD/MM - hh:mm');
                var acao = "https://media.discordapp.net/attachments/915695615772594236/930643960244875284/down.png"
                if (e.deposito == "true") acao = "https://media.discordapp.net/attachments/915695615772594236/930645007948447794/uplo.png"
                content += '<tbody> <tr class="bau-dados-2">';
                content += '<td>' + e.membro + "  |  " + `${e.membro_id}` + '</td>';
                content += '<td>R$ ' + e.valor + '</td>';
                content += '<td>' + `<img src='${acao}' ></img>` + '</td>';
                content += '<td>' + `${hora}` + '</td>';
                content += `<td> </td></tr></tbody>`;
            })
            content += "</table>"
            $('.banco-page-table').html(content);
            function numberWithCommas(x) {
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
            }
            $(".saldo").text("R$" + numberWithCommas(event.data.saldo))
        }
    })

    $(".demitir-do-grupo").click(function (id) {
        var id = $(this).attr("id").replace("demitir2-", "")
        fetch(`https://${GetParentResourceName()}/demitir-membro`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                id: id
            })
        })

    })

    $(".criar-grupo-btn").click(function () {
        $(".pop-up-criar-grupo").show();
        $(".blur-criar-grupo").css("filter", "blur(5px)")
        $(".blur-criar-grupo").css("transition", "0.25s filter linear")

    })

    $('.id_lider').on('input', function (e) {
        $(this).val($(this).val().replace(/[^0-9]/g, ''))
    });


    $(document).on('keyup', function (e) {
        if (e.key == "Escape") $.post(`http://${GetParentResourceName()}/fechar`);
    });


    $(".pop-up-criar-grupo-sim").click(function () {
        var id_lider = $(".id_lider").val();
        var nome_grupo = $(".nome_grupo").val();
        $(".id_lider").val("");
        $(".nome_grupo").val("");
        $(".pop-up-criar-grupo").hide();
        $(".pop-up-criar-grupo-criado").show();
        fetch(`https://${GetParentResourceName()}/criargrupo`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                nome: nome_grupo,
                lider: id_lider
            })
        }).then(resp => resp.json())
    })

    $(".pop-up-criar-grupo-criado-btn").click(function () {
        $(".pop-up-criar-grupo-criado").hide();
        $(".blur-criar-grupo").css("filter", "blur(0px)")
        $(".blur-criar-grupo").css("transition", "0.25s filter linear")
        $.post(`http://${GetParentResourceName()}/fechar`)
    })

    $(".nav-bar-item").click(function () {
        $(this).find('.nav-item-p').addClass("activeBorde")
        $(".nav-item-p").removeClass("activeBorde")
    })

    $("#home-p").click(function () {
        $(".home-page").show();
        $(".membros-page").hide();
        $(".bau-page").hide();
        $(".banco-page").hide();
    })

    $("#membros-p").click(function () {
        $(".home-page").hide();
        $(".membros-page").show();
        $(".bau-page").hide();
        $(".banco-page").hide();
        $.post(`http://${GetParentResourceName()}/membros-page`);
    })

    $("#bau-p").click(function () {
        $(".home-page").hide();
        $(".membros-page").hide();
        $(".bau-page").show();
        $(".banco-page").hide();
        $.post(`http://${GetParentResourceName()}/bau-page`);
    })

    $("#banco-p").click(function () {
        $(".home-page").hide();
        $(".membros-page").hide();
        $(".bau-page").hide();
        $(".banco-page").show();
        $.post(`http://${GetParentResourceName()}/banco-page`);
    })

    $("#home-p").hover(
        function () {
            $(this).css("font-weight", "600");
            $("#home-icon").css("width", "35px");
            $("#home-icon").css("height", "35px");
            $(this).css("transition", "0.50s filter linear");
            $("#home-icon").css("transition", "0.50s filter linear");

        },
        function () {
            $(this).css("font-weight", "400");
            $("#home-icon").css("width", "30.48px");
            $("#home-icon").css("height", "30.48px");
            $(this).css("transition", "0.50s filter linear");
            $("#home-icon").css("transition", "0.50s filter linear");
        })

    $("#membros-p").hover(
        function () {
            $(this).css("font-weight", "600");
            $("#membros-icon").css("width", "35px");
            $("#membros-icon").css("height", "35px");
            $(this).css("transition", "0.50s filter linear");
            $("#membros-icon").css("transition", "0.50s filter linear");

        },
        function () {
            $(this).css("font-weight", "400");
            $("#membros-icon").css("width", "30.48px");
            $("#membros-icon").css("height", "30.48px");
            $(this).css("transition", "0.50s filter linear");
            $("#membros-icon").css("transition", "0.50s filter linear");
        })

    $("#bau-p").hover(
        function () {
            $(this).css("font-weight", "600");
            $("#bau-icon").css("width", "35px");
            $("#bau-icon").css("height", "35px");
            $(this).css("transition", "0.50s filter linear");
            $("#bau-icon").css("transition", "0.50s filter linear");

        },
        function () {
            $(this).css("font-weight", "400");
            $("#bau-icon").css("width", "30.48px");
            $("#bau-icon").css("height", "30.48px");
            $(this).css("transition", "0.50s filter linear");
            $("#bau-icon").css("transition", "0.50s filter linear");
        }) 

    $(".adicionar-ao-grupo").click(function () {
        $(".add-membro-popup").show();
    })

    $("#banco-p").hover(
        function () {
            $(this).css("font-weight", "600");
            $("#banco-icon").css("width", "35px");
            $("#banco-icon").css("height", "35px");
            $(this).css("transition", "0.50s filter linear");
            $("#banco-icon").css("transition", "0.50s filter linear");

        },
        function () {
            $(this).css("font-weight", "400");
            $("#banco-icon").css("width", "30.48px");
            $("#banco-icon").css("height", "30.48px");
            $(this).css("transition", "0.50s filter linear");
            $("#banco-icon").css("transition", "0.50s filter linear");
        })


    $('.id-a-ser-adicionado').on('input', function (e) {
        $(this).val($(this).val().replace(/[^0-9]/g, ''))
    });

    $(".cancelar-botao-grupo").on('click', function () {
        $(".add-membro-popup").hide();
        $(".id-a-ser-adicionado").val("");
    })

    $(".cancelar-demitir-botao-grupo").on("click", function () {
        $(".demitir-membro-popup").hide();
    })

    $(".adicionar-botao-grupo").on('click', function () {
        $(".add-membro-popup").hide();
        var id = $(".id-a-ser-adicionado").val();
        $(".id-a-ser-adicionado").val("");
        fetch(`https://${GetParentResourceName()}/add-membro`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                id: id
            })
        })

    })

    $(".adicionar-saldo").on("click",function(){
        $.post(`http://${GetParentResourceName()}/adicionar-saldo`);
    })

    $(".remover-saldo").on("click", function(){
        $.post(`http://${GetParentResourceName()}/remover-saldo`);
    })
})