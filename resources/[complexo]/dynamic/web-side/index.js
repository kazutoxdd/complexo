$(document).ready(function(){
	const buttons = [];
	const submenus = [];
  
	$(document).keyup(function(event){
	  if (event.which == 27){
		buttons.length = 0;
		submenus.length = 0;
		$("button").remove();
		$("#title").html("");
		$(".container").hide();
		$.post("http://dynamic/close");
	  }
	});
  
	window.addEventListener("message", function(event){
	  var item = event["data"];
  
	  if(item["addbutton"] == true){
		if(item.id == false || item.id == null){
		  var b = `<button id="normalbutton" data-trigger="${item["trigger"]}" data-parm="${item["par"]}" data-server="${item["server"]}" class="btn"><div class="title">${item["title"]}</div><div class="description">${item["description"]}</div></button>`;
		  buttons.push(b);
		  $(".container").append(b).show();
		} else {
		  var b = `<button id="${item["id"]}" data-trigger="${item["trigger"]}" data-parm="${item["par"]}" data-server="${item["server"]}" class="a btn"><div class="title">${item["title"]}</div><div class="description">${item["description"]}</div></button>`;
		  buttons.push(b);
		}
	  } else if(item["addmenu"] == true){
		var aa = `<button data-menu="${item["menuid"]}" class="b btn"><div class="title">${item["title"]}</div><div class="description">${item["description"]}</div><i class="fas fa-chevron-right" style="float:right;margin-top:-10%"></i></button>`;
		$(".container").append(aa);
		submenus.push(aa);
		$(".container").show();
	  }
  
	  if (item["close"] == true){
		buttons.length = 0;
		submenus.length = 0;
		$("button").remove();
		$("#title").html("");
		$(".container").hide();
	  }
	});
  
	function goback(){
	  var gobackbutton = `<button style="height:10px; background: #3e0283;" id="goback" class="btn"><div class="title" style="margin-top:-3.8%">Voltar</div><i class="fas fa-chevron-left" style="float: right; margin-top:-3.5%"></i></button>`;
	  $(".container").append(gobackbutton);
	}
  
	$("body").on("click", ".a", function(){
	  $.post("http://dynamic/clicked", JSON.stringify({ trigger:$(this).attr("data-trigger"), param:$(this).attr("data-parm"), server: $(this).attr("data-server"), title: $(this).find(".title").text() }));
	});
  
	$("body").on("click", "#normalbutton", function(){
	  $.post("http://dynamic/clicked", JSON.stringify({ trigger: $(this).attr("data-trigger"), param: $(this).attr("data-parm"), server: $(this).attr("data-server"), title: $(this).find(".title").text() }));
	});
  
	$("body").on("click", ".b", function(){
	  goback();
  
	  $(".b").remove();
	  $(".a").remove();
	  $("#normalbutton").remove();
  
	  var menuid = $(this).attr("data-menu");
	  for (i = 0; i < buttons.length; ++i){
		var div = buttons[i];
		var match = div.match(`id="${menuid}"`);
		if(match) {
		  $(".container").append(div);
		}
	  }
	});
  
	$("body").on("click", "[id=goback]", function(){
	  $(".b").remove();
	  $(".a").remove();
	  $("button").remove();
	  $(".container").append(submenus).show();
  
	  for (i = 0; i < buttons.length; ++i){
		var div = buttons[i];
		var match = div.match("normalbutton");
		if(match){
		  $(".container").append(div);
		}
	  }
	});
  });