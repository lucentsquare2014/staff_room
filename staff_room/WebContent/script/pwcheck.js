$(function(){
	$("input[type='submit']").click(function(){
		var now_pw1 = $.trim($("input[name='now_pw1']").val());
		var id = $.trim($("input[name='id']").val());
		var pw1 = $.trim($("input[name='new_pw1']").val());
		var pw2 = $.trim($("input[name='new_pw2']").val());
		if((now_pw1 == "")){
			$("#alert").text("現在のパスワードを入力してください");
			return false;
		}
		if((pw1 == "") && (pw2 == "")){
			$("#alert").text("変更したいパスワードを二度入力してください。");
			return false;
		}
		if((pw1 == "") && (pw2 != "")){
			$("#alert").text("変更したいパスワードを入力してください。");
			return false;
		}
		if((pw1 != "") && (pw2 == "")){
			$("#alert").text("変更したいパスワードをもう一度入力してください。");
			return false;
		}
		if((pw1 != pw2)){
			$("#alert").text("入力が一致しませんでした。もう一度入力してください。");
			return false;
		}
		if((pw1 == id)||(pw2 == id)){
			$("#alert").text("パスワードにアカウントと同一のものは使用できません。");
			return false;
		}
	});
});