$(function(){
	$("input[type='submit']").click(function(){
		var id = $.trim($("input[name='id']").val());
		var pwd = $.trim($("input[name='password']").val());
		if((id == "") && (pwd == "")){
			$("#alert").text("ユーザとパスワードを入力してください。");
			return false;
		}
		if((id == "") && (pwd != "")){
			$("#alert").text("ユーザを入力してください。");
			return false;
		}
		if((id != "") && (pwd == "")){
			$("#alert").text("パスワードを入力してください。");
			return false;
		}
	});
});