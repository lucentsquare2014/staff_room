$(function(){
	$("#section").change(function(){
		if($("#section").val() == "1"){
			$("#order1").show();
			$("#order2").hide();
		}else{
			$("#order1").hide();
			$("#order2").show();
		}
	});
	
	$("#add_gruop").click(function(){
		var no = $.trim($("input[name='add_gruno']").val());
		var name = $.trim($("input[name='add_grname']").val());
		if(no == ""){
			alert("番号を入力してしてください。");
			return false;
		}
		if(name == ""){
			alert("グループ名を入力してしてください。");
			return false;
		}
		var inputText = $("input[name='gruno']").map(function (index, el) {
			return $(this).val();
	    });
		for(var i = 0; i < inputText.length; i++){
			if(no == inputText[i]){
				alert("番号が重複しています！");
				return false;
			}
		}
	});
	
	$("#update").click(function(){
		var inputText = $("input[name='gruno']").map(function (index, el) {
			return $(this).val();
	    });
		var l = inputText.length;
		if(l != $.unique(inputText).length){
			alert("番号が重複しています！");
			location.reload();
			return false;
			
		}
	});
	
	$("input[type='text']").change(function(){
		var txt = $.trim($(this).val());
		var han = txt.replace(/[Ａ-Ｚａ-ｚ０-９]/g,function(s){return String.fromCharCode(s.charCodeAt(0)-0xFEE0);});
		$(this).val(han);
	});
	
});