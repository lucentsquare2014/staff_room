$(function(){
	var flg = "input";
	$("button").click(function(){
		if(flg == "input"){
			$("#select").text($("select[name='inputPostid'] option:selected").text());
			$("#title").text($("input[name='inputTitle']").val());
			$("#text").text($("textarea[name='inputText']").val());
			$("#file").text("選択されていません");
			$("#author").text($("input[name='inputWriter']").val());
			flg = "confirm";
		}else{
			flg = "input";
		}
	});
	
	$("input[type='submit']").click(function(){
		var title = $.trim($("#title").text());
		var text = $.trim($("#text").text());
		if(title == ""){
			$("#alert").text("タイトルを入力してください。");
			return false;
		}
		if(text == ""){
			$("#alert").text("本文を入力してください。");
			return false;
		}
	});
});