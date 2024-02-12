var selectPage = "Prender";
var reversePage = "Prender";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function () {
	functionPrender();
	
	window.addEventListener("message", function (event) {
		switch (event["data"]["action"]) {
			case "openSystem":
				$("#mainPage").css("display", "block");
				break;

			case "closeSystem":
				$("#mainPage").css("display", "none");
				break;

			case "reloadPrison":
				functionPrender();
				limpar(); 
				break;

			case "reloadFine":
				functionMultar();
				break;

			case "reloadProcurados":
				functionProcurados();
				break;

			case "reloadPortes":
				functionPortes();
				break;

			case "reloadSearch":
				functionSearch(event["data"]["data"]);
				break;

		};
	});

	document.onkeyup = function (data) {
		if (data["which"] == 27) {
			$.post("http://police/closeSystem");
		};
	};
});
/* ATIVAR .ACTIVE QUANDO A PÁGINA FOR SELECIONADA */
$(document).on("click", "#mainMenu .nav li", function () {
	if (selectPage != reversePage) {
		let isActive = $(this).hasClass('active');
		$('#mainMenu .nav li').removeClass('active');
		if (!isActive) {
			$(this).addClass('active');
			reversePage = selectPage;

			$("#content").css("height", "540px");
			$("#content").css("margin", "30px 10px 30px 10px");
		};
	};
});

/* ---------- BUSCA PRISÃO POR ID ---------- */
const functionVisualizarPrisao = (idprisao) => {
	if (idprisao != "") {
		$.post("http://police/checkPrisionId", JSON.stringify({ idprisao: parseInt(idprisao) }), (data) => {
			console.log(data["result"])
			console.log(data["result"][0])
			console.log(JSON.stringify(data["result"][1]))
			console.log(JSON.stringify(data["result"][2]))

			if (data["result"][0] != false) {
				$('#content').html(`
					<div id="titleContent">Prisão: ${data["result"][1]}</div>
					<div id="pageCenter">
	
						<div class="infoPrisao">
							<b>Passaporte:</b> ${data["result"][2]["nuser_id"]}<br>
							<b>Serviços:</b> ${data["result"][2]["services"]}<br>
							<b>Multas:</b> ${data["result"][2]["fines"]}<br>
							<br>
							<b>Oficial responsável:</b> ${data["result"][2]["police"]}<br>
							<b>Demais oficiais:</b> ${(data["result"][2]["cops"] != null && data["result"][2]["cops"] != "") ? data["result"][2]["cops"] : "Sem outros oficiais"}<br>
							<b>Associação criminosa:</b> ${(data["result"][2]["association"] != null && data["result"][2]["association"] != "") ? data["result"][2]["association"] : "Sem associação"}<br>
							<b>Material genético:</b> ${data["result"][2]["residual"] == 0 ? "Não coletado" : "Coletado" }<br>
							<br>
							<b>Data:</b> ${data["result"][2]["date"]}<br>
							<b>Motivos:</b> ${data["result"][2]["text"]}<br>
						</div>
						<div class="infoPrisaoFoto">
							<img class="foto" src="${data["result"][2]["url"]}" />
						</div>
					</div>
				`);
			} else {
				$('#content').html(`
					<div id="titleContent">Prisão</div>
					Não conseguimos carregar as informações desta prisão.
				`);
			}
		});
	}
}
/* ---------- BUSCA PROCURADO POR ID ---------- */
const functionVisualizarProcurado = (idprocurado) => {
	if (idprocurado != "") {
		$.post("http://police/checkWarrantId", JSON.stringify({ idprocurado: parseInt(idprocurado) }), (data) => {
			console.log(data["result"])
			if (data["result"][0] != false) {
				$('#content').html(`
					<div id="titleContent">Informações do procurado: ${data["result"][1]}</div>
					<div id="pageCenter">
	
						<div class="infoBox">
							<b>Passaporte:</b> ${data["result"][2]["user_id"]}<br>
							<b>Nome:</b> ${data["result"][2]["identity"]}<br>
							<b>Status:</b> ${data["result"][2]["status"]}<br>
							<b>Motivo:</b> ${data["result"][2]["reason"]}<br>
							<b>Oficial:</b> ${data["result"][2]["nidentity"]}<br>
							<b>Data de expedição:</b> ${data["result"][2]["timeStamp"]}<br>
						</div>
						<label class="buttonVoltar" onclick="functionProcurados();">Voltar</label>

					</div>
				`);
			} else {
				$('#content').html(`
					<div id="titleContent">Procurados</div>
					Não conseguimos carregar as informações deste procurado.
				`);
			}
		});
	}
}

/* ---------- BUSCA DE INFORMAÇÃO DO CIDADÃO POR ID ---------- */
const functionSearch = (passaporte) => {
	if (passaporte != "") {
		$.post("http://police/searchUser", JSON.stringify({ passaporte: parseInt(passaporte) }), (data) => {
			if (data["result"][1] != false) {
				$('#content').html(`
					<div id="titleContent">${data["result"][2]}</div>
					<div id="pageLeftSearch">
						<div class="searchBox">
							<b>Passaporte:</b> ${formatarNumero(passaporte)}<br>
							<b>Nome:</b> ${data["result"][2]}<br>
							<b>Telefone:</b> ${data["result"][3]}<br>
							<b>Multas:</b> $${data["result"][4]}<br>
							<b>Policial:</b> ${data["result"][8] == 0 ? "Sul":"Norte"} <update id="policeUpdate" data-id="${passaporte}">Atualizar</update>
						</div>
						${data["result"][7].map((data) => (`
						
							<div class="searchBox" style="margin-top: 5px;">
								<div class="fineSeachTitle3">
									<span style="width: 280px; float: left;"><b>Porte:</b> ${data["portType"]}</span>
									<span style="width: 280px; float: left;"><b>Serial:</b> ${data["serial"]}</span>
								</div>
							</div>
						`)).join('')}
						${data["result"][5].map((data) => (`
							<div class="recordBox">
								<div class="fineSeachTitle">
									<span style="width: 180px; float: left;"><b>Policial:</b> ${data["police"]}</span>
									<span style="width: 130px; float: left;"><b>Serviços:</b> ${formatarNumero(data["services"])}</span>
									<span style="width: 130px; float: left;"><b>Multa:</b> $${formatarNumero(data["fines"])}</span>
									<span style="width: 130px; float: left;">${data["date"]}</span>
									<span style="width: 55px; float: right; text-align: right;">
										<button id="buttonPrisao${data["id"]}" class="buttonPrisao"><i class="fa fa-eye"></i></button>
									</span>
								</div>
								<b>Motivo:</b><br> - ${data["text"]}
							</div>
						`)).join('')}
					</div>

					<div id="pageRight">
						<h2>OBSERVAÇÕES:</h2>
						<b>1:</b> Todas as informações encontradas são de uso exclusivo policial, tudo que for encontrado na mesma são informações em tempo real.<br><br>
						<b>2:</b> Nunca forneça qualquer informação dessa página para outra pessoa, apenas se a mesma for o proprietário ou o advogado do mesmo.
					</div>
				`);
			} else {
				$('#content').html(`
					<div id="titleContent">RESULTADO</div>
					Não foi encontrado informações sobre o passaporte procurado.
				`);
			}
		});
	}
}
/* ---------- CHAMA FUNÇÃO DE BUSCAR INFO CIDADÃO PASSANDO PARAMETRO ID ---------- */
$(document).on("click", ".buttonSearch", function (e) {
	const passaporte = $('#searchPassaporte').val();
	functionSearch(passaporte);
});

/* ---------- CHAMA FUNÇÃO DE PRISÃO PASSANDO PARAMETRO ID  --------- */
$(document).on("click", ".buttonPrisao", function (e) {
	e.preventDefault();
	const idpri = $(this).attr('id');

	const idprisao = idpri.replace('buttonPrisao', '');

	functionVisualizarPrisao(idprisao);
});

/* ---------- CHAMA FUNÇÃO DE PROCURADO PASSANDO PARAMETRO ID --------- */
$(document).on("click", ".buttonProcurado", function (e) {
	e.preventDefault();
	const idprocurado = $(this).attr('id');

	const strSemId = idprocurado.replace('buttonProcurado', '');

	functionVisualizarProcurado(strSemId);
});

/* ---------- CHAMA FUNÇÃO DE EXCLUIR PROCURADO PASSANDO PARAMETRO ID ---------- */
$(document).on("click", ".buttonExcluirProcurado", function (e) {
	e.preventDefault();
	const idexprocurado = $(this).attr('id');

	const excluirpro = idexprocurado.replace('buttonExcluirProcurado', '');
	$.post("http://police/deleteWarrant", JSON.stringify({ excluirpro: excluirpro }));
});

/* ---------- CHAMA FUNÇÃO DE EXCLUIR PORTE PASSANDO PARAMETRO ID ---------- */
$(document).on("click", ".buttonExcluirPorte", function (e) {
	e.preventDefault();
	const idexporte = $(this).attr('id');

	const excluirporte = idexporte.replace('buttonExcluirPorte', '');
	$.post("http://police/deletePort", JSON.stringify({ excluirporte: excluirporte }));
});

/* ---------- CHAMA FUNÇÃO DE EDITAR PORTE PASSANDO PARAMETRO ID --------- */
$(document).on("click", ".buttoneditPort", function (e) {
	e.preventDefault();
	const ideditporte = $(this).attr('id');
	const idedporte = ideditporte.replace('buttoneditPort', '');
	functionEditPorte(idedporte);
});
/* ----------CLICKBUY---------- */
$(document).on("click","#policeUpdate",function(e){
	$.post("http://police/updatePolice",JSON.stringify({ passaporte: e["target"]["dataset"]["id"] }));
});
/* ---------------------------------------------------------------------------------------------------------------- */
function calcular() {
	var Multa = 0;
	var Fianca = 0;

	/* Crimes */
	var crimes = document.getElementsByName('crime[]');
	for (var i = 0; i < crimes.length; i++) {
		if (crimes[i].checked) {
			var valores_crime = crimes[i].value.split("|");
			Multa += parseInt(valores_crime[1]);
			Fianca += parseInt(valores_crime[2]);
		}
	}
	/* TENTATIVA DE HOMICIDIO */
	var drogas = parseInt(document.getElementById("drogas").value);
	if (drogas > 0) {
		Multa += drogas * 1000;
		Fianca += drogas * 25;
	}

	/* TENTATIVA DE HOMICIDIO A OFICIAL */
	var sujo = parseInt(document.getElementById("sujo").value);
	if (sujo > 0) {
		Multa += sujo * 1500;
		Fianca += sujo * 35;
	}
	/* HOMICIDIO */
	var multas = parseInt(document.getElementById("multas").value);
	if (multas > 0) {
		Multa += multas * 1500;
		Fianca += multas * 30;
	}
	/* HOMICIDIO A OFICIAL */
	var muniçao = parseInt(document.getElementById("muniçao").value);
	if (muniçao > 0) {
		Multa += muniçao * 2000;
		Fianca += muniçao * 40;
	}

	var multa_txt = document.getElementById("prenderMultas");
	multa_txt.value = Multa;
	var fianca_txt = document.getElementById("prenderServices");
	fianca_txt.value = Fianca;

	/* Crimes */
	var crimess = document.getElementsByName('crime[]');
	var crimeid = '';
	var crimeidd = '';
	for (var i = 0; i < crimess.length; i++) {
		if (crimess[i].checked) {
			var valores_crimee = crimess[i].value.split("|");
			crimeid = valores_crimee[0];
			crimeidd = crimeid + ', ' + crimeidd;
		}
	}

	var crimes = crimeidd;

	var crimes_txt = document.getElementById("prenderTexto");
	crimes_txt.value = crimes;
}
function limpar() {
	var crimes = document.getElementsByName('crime[]');
	for (var i = 0; i < crimes.length; i++) {
		crimes[i].checked = false;
	}


	var drogas = document.getElementById("drogas");
	drogas.value = 0;

	var sujo = document.getElementById("sujo");
	sujo.value = 0;

	var sujo = document.getElementById("multas");
	sujo.value = 0;

	var sujo = document.getElementById("muniçao");
	sujo.value = 0;

	document.getElementById("prenderMultas").value = "0";
	document.getElementById("prenderServices").value = "0";
	document.getElementById("prenderTexto").value = "";

}

const functionPrender = () => {
	selectPage = "Prender";

	$('#content').html(`
		<div id="titleContent">PRENDER</div>
		<div id="pageLeft">
			<input class="inputTentativas" id="prenderPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<input class="inputTentativas2" id="prenderUrl" type="text" value="" placeholder="Url da foto."></input>

			<label class="buttonCrimes" for="modal-1">Adicionar crimes</label>
			
			<div style="display: inline-block">
				<input class="inputTentativas" id="prenderServices" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Serviços."></input>
				<input class="inputTentativas2" id="prenderMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."></input>
			</div>
			<textarea class="textareaPrison" maxlength="500" id="prenderTexto" value="" placeholder="Todas as informações dos crimes."></textarea>
			<div style="display: inline-block">
				<select class="inputPrison" name="prenderMaterial" id="prenderMaterial"><option value="Não">Sem coleta de material genético.</option><option value="Sim">Material genético coletado.</option></select>
				<input class="inputPrison" id="prenderAssociacao" type="text" value="" placeholder="Associação (Ex: 1, 2, 3)."></input>
			</div>
			<input class="inputPrison" id="prenderPenais" type="text" value="" placeholder="Oficiais Penais (Ex: 1, 2, 3)."></input>
			<input class="inputPrison" id="prenderMilitares" type="text" value="" placeholder="Demais policiais (Ex: 1, 2, 3)."></input>
			<button class="buttonPrison">Prender</button>
			<button class="buttonPrisonLimpar" onclick="limpar()">Limpar</button>
			
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com o crime efetuado, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
			<b>3:</b> Todas as prisões são salvas no sistema após o envio, então lembre-se que cada formulário enviado, o valor das multas, serviços e afins são somados com a ultima prisão caso o mesmo ainda esteja preso.
		</div>
	`);
};

/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA CLIENTE DO INSERIR PRISÃO ---------- */
$(document).on("click", ".buttonPrison", function (e) {
	const passaporte = $('#prenderPassaporte').val()
	const servicos = $('#prenderServices').val()
	const url = $('#prenderUrl').val()
	const multas = $('#prenderMultas').val()
	const texto = $('#prenderTexto').val()
	const material = $('#prenderMaterial').val()
	const associacao = $('#prenderAssociacao').val()
	const penais = $('#prenderPenais').val()
	const militares = $('#prenderMilitares').val()

	if (passaporte != "" && servicos != "" && multas != "" && texto != "" && url != "") {
		$.post("http://police/initPrison", JSON.stringify({
			passaporte: parseInt(passaporte),
			servicos: parseInt(servicos),
			multas: parseInt(multas),
			texto: texto,
			associacao: associacao,
			material: material,
			url: url,
			penais: penais,
			militares: militares
		}));
	}
});

/* --------- LISTAR PORTES ---------- */
const functionPortes = () => {
	selectPage = "Portes";

	$.post("http://police/searchPort", JSON.stringify({ type: 'consultar' }), (data) => {
		if (data["result"][0] != false) {
			$('#content').html(`
				<div id="titleContent">Portes</div>
				<div id="pageCenter">
					<label class="buttonAddPortes" onclick="functionAddPorte();">Adicionar Porte</label>
					${data["result"][1].map((data) => (`
						<div class="centerBox">
							
							<div class="fineSeachTitle3" style="display: inline-block;">
								<span style="width: 480px; float: left;"><b>Passaporte:</b> ${data["user_id"]}</span>
								<span style="width: 380px; float: left;"><b>Nome:</b> ${data["identity"]}</span>
								<span style="width: 100px; float: right;">
									<button id="buttoneditPort${data["portId"]}" class="buttoneditPort"><i class="fa fa-pencil"></i></button>
									<button id="buttonExcluirPorte${data["portId"]}" class="buttonExcluirPorte"><i class="fa fa-trash"></i></button>
								</span>
								<span style="width: 480px; float: left;"><b>Tipo de porte:</b> ${data["portType"]}</span>
								<span style="width: 480px; float: left;"><b>Serial:</b> ${data["serial"]}</span>
								<span style="width: 480px; float: left;"><b>Oficial:</b> ${data["nidentity"]}</span>
								<span style="width: 480px; float: left;"><b>Data:</b> ${data["date"]}</span>
					
							</div>
						</div>
					`)).join('')}
				</div>
			`);
		} else {
			$('#content').html(`
				<div id="titleContent">Portes</div>
				Não foi encontrado informações sobre portes.
			`);
		}

	});
};
/* ---------- FUNÇÃO DO EDITAR PORTE TRAZENDO AS INFORMAÇÕES PASSANDO PARAMETRO ID ---------- */
const functionEditPorte = (idedporte) => {
	if (idedporte != "") {
		$.post("http://police/getPortById", JSON.stringify({ idedporte: parseInt(idedporte) }), (data) => {
			if (data["result"][0] != false) {
				$('#content').html(`
					<div id="titleContent">Editar Porte</div>
					<div id="pageCenter">
						<input type="hidden" class="inputFormCenter" id="porteId" value="${data["result"][1]["portId"]}"></input>
						<input class="inputFormCenter" id="portePassaporte" value="${data["result"][1]["user_id"]}" placeholder="Passaporte"></input>
						<input class="inputFormCenter" id="porteNome" value="${data["result"][1]["identity"]}" placeholder="Nome completo"></input>
						<input class="inputFormCenter2" id="porteSerial" value="${data["result"][1]["serial"]}" placeholder="Serial de arma"></input>
						<input class="inputFormCenter2" id="porteStatus" value="${data["result"][1]["portType"]}" placeholder="Tipo de porte"></input>
						<input class="inputFormCenter3" id="porteExame" value="${data["result"][1]["exam"]}" placeholder="Resultado toxicológico"></input>
						<button class="buttonVoltar" onclick="functionPortes();">Voltar</button>
						<button class="buttonEditarPorte">Editar</button>
					</div>
				`);
			} else {
				$('#content').html(`
					<div id="titleContent">RESULTADO</div>
					Não foi encontrado informações sobre o passaporte procurado.
				`);
			}
		});
	}
}
/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA EDITAR PRISÃO ---------- */
$(document).on("click", ".buttonEditarPorte", function (e) {
	const id = $('#porteId').val()
	const passaporte = $('#portePassaporte').val()
	const nome = $('#porteNome').val()
	const serial = $('#porteSerial').val()
	const status = $('#porteStatus').val()
	const exame = $('#porteExame').val()

	if (passaporte != "" && id != "" && nome != "" && serial != "" && status != "" && exame != "") {
		$.post("http://police/editPort", JSON.stringify({
			id: id,
			passaporte: parseInt(passaporte),
			nome: nome,
			serial: serial,
			status: status,
			exame: exame
		}));
	}
});

/* ---------- CHAMANDO PAGINA DE INSERIR PORTE ---------- */
const functionAddPorte = () => {
	selectPage = "Porte";

	$('#content').html(`
		<div id="titleContent">Adicionar Porte</div>
		<div id="pageCenter">
			<input class="inputFormCenter" id="portePassaporte" value="" placeholder="Passaporte"></input>
			<input class="inputFormCenter" id="porteNome" value="" placeholder="Nome completo"></input>
			<input class="inputFormCenter2" id="porteSerial" value="" placeholder="Serial de arma"></input>
			<input class="inputFormCenter2" id="porteStatus" value="" placeholder="Tipo de porte"></input>
			<input class="inputFormCenter3" id="porteExame" value="" placeholder="Resultado toxicológico"></input>
			<button class="buttonAddPorte">Adicionar</button>
		</div>
	`);
};

/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA INSERIR PORTE ---------- */
$(document).on("click", ".buttonAddPorte", function (e) {
	const passaporte = $('#portePassaporte').val()
	const nome = $('#porteNome').val()
	const serial = $('#porteSerial').val()
	const status = $('#porteStatus').val()
	const exame = $('#porteExame').val()

	if (passaporte != "" != "" && nome != "" && serial != "" && status != "" && exame != "") {
		$.post("http://police/givePort", JSON.stringify({
			passaporte: parseInt(passaporte),
			nome: nome,
			serial: serial,
			status: status,
			exame: exame
		}));
	}
});

/* --------- LISTAR PROCURADOS ---------- */
const functionProcurados = () => {
	selectPage = "Procurados";

	$.post("http://police/getWarrants", JSON.stringify({ type: 'consultar' }), (data) => {

		if (data["result"][0] != false) {
			$('#content').html(`
				<div id="titleContent">Procurados</div>
				<div id="pageCenter">
					<label class="buttonAddProcurado" onclick="functionAddProcurado();">Adicionar Procurado</label>
					${data["result"][1].map((data) => (`
						<div class="centerBox">
							
							<div class="fineSeachTitle2" style="display: inline-block;">
								<span style="width: 320px; float: left;"><b>Passaporte:</b> ${data["user_id"]}</span>
								<span style="width: 320px; float: left;"><b>Nome:</b> ${data["identity"]}</span>
								<span style="width: 320px; float: left;"><b>Status:</b> ${data["status"]}</span>
								<span style="width: 320px; float: left;"><b>Oficial:</b> ${data["nidentity"]}</span>
								<span style="width: 320px; float: left;"><b>Data:</b> ${data["timeStamp"]}</span>
								<span style="width: 320px; float: right;">
								<button id="buttonProcurado${data["id"]}" class="buttonProcurado"><i class="fa fa-eye"></i></button>
								<button id="buttonExcluirProcurado${data["id"]}" class="buttonExcluirProcurado"><i class="fa fa-trash"></i></button>
								</span>
							</div>
							<br />
							<div style="display: inline-block;">
								<b>Motivo:</b><br> - ${data["reason"]}
							</div>
						</div>
					`)).join('')}
				</div>
			`);
		} else {
			$('#content').html(`
				<div id="titleContent">Procurados</div>
				Não foi encontrado informações sobre procurados.
			`);
		}

	});
};

/* ---------- CHAMANDO PAGINA DE INSERIR PROCURADO ---------- */
const functionAddProcurado = () => {
	selectPage = "Procurado";

	$('#content').html(`
		<div id="titleContent">Adicionar Procurado</div>
		<div id="pageCenter">
			<input class="inputFormCenter" id="procuradoPassaporte" value="" placeholder="Passaporte."></input>
			<input class="inputFormCenter" id="procuradoNome" value="" placeholder="Nome."></input>
			<textarea class="textareaFormCenter" id="procuradoTexto" maxlength="500" value="" placeholder="Todas as informações."></textarea>
			<button class="buttonAddP">Adicionar</button>
		</div>
	`);
};

/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA INSERIR PROCURADO ---------- */
$(document).on("click", ".buttonAddP", function (e) {
	const passaporte = $('#procuradoPassaporte').val()
	const nome = $('#procuradoNome').val()
	const texto = $('#procuradoTexto').val()

	if (passaporte != "" != "" && nome != "" && texto != "") {
		$.post("http://police/setWarrant", JSON.stringify({
			passaporte: parseInt(passaporte),
			nome: nome,
			texto: texto
		}));
	}
});

/* ---------- CHAMANDO PAGINA DE INSERIR MULTA ---------- */
const functionMultar = () => {
	selectPage = "Multar";

	// add depois:
	// <input style="margin-top: 8px;" class="inputFine" id="multarCnh" type="number" onKeyPress="if(this.value.length==2) return false;" value="" placeholder="Pontos da CNH a retirar. (Em branco não retira)"></input>
	$('#content').html(`
		<div id="titleContent">MULTAR</div>
		<div id="pageLeft">
			<input class="inputFine" id="multarPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<input class="inputFine2" id="multarMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."></input>
			<textarea class="textareaFine" id="multarTexto" maxlength="500" value="" placeholder="Todas as informações da multa."></textarea>
			<button class="buttonFine">Multar</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com a multa, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
		</div>
	`);
};

/* ---------- FUNÇÃO PARA ENVIAR DADOS PARA INSERIR MULTA ---------- */
$(document).on("click", ".buttonFine", function (e) {
	const passaporte = $('#multarPassaporte').val()
	const multas = $('#multarMultas').val()
	const texto = $('#multarTexto').val()
	//const cnh = $('#multarCnh').val()

	if (passaporte != "" != "" && multas != "" && texto != "") {
		$.post("http://police/initFine", JSON.stringify({
			passaporte: parseInt(passaporte),
			multas: parseInt(multas),
			texto: texto,
			/*cnh: cnh,*/
			cnh: 0
		}));
	}
});
/* ----------FORMATARNUMERO---------- */
const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}



