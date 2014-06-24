$(function(){
	
	$("#all_check").click(function(){
		$("table :checkbox").prop("checked",true);
	});
	
	$("#clear").click(function(){
		$("table :checkbox").prop("checked",false);
	});
	
	$("#mail").click(function(){
		var m = $("table :checkbox").length;
		var n = $("table :checked").length;
		var mail_str = "";
		if(m == n){
			mail_str = "all@lucentsquare.co.jp";
			location.href = "mailto:" + mail_str;
		}else if(n == 0){
			alert("チェックされていません");
		}else if(n>70){
			alert("一度に選択できる数は70人までです。\n" +
					"全社員宛てのメールならば送ることができます。\n" +
					"その場合は全てにチェックを入れ、メール作成をして下さい。");		
		}else{
			$("table :checked").each(function(){
				var mail_add = $(this).parent().parent().children("#address").children("a");
				mail_str += mail_add.text() + ";";
			});
			location.href = "mailto:" + mail_str;
		}
	});
});