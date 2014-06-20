$(function() {

		$(document).ready(
				function() {
					/* チェックボックスにチェックがついたかを判別する */
					$('[name="check"]').click(
							function() {
								var checkbox = $("#" + $(this).attr("id"));
								if (checkbox.attr("flag") === "0") {
									checkbox.attr("flag", "1");
									$("#" + checkbox.attr("id")).attr("class",
											"uk-icon-check-square-o");
								} else {
									checkbox.attr("flag", "0");
									$("#" + checkbox.attr("id")).attr("class",
											"uk-icon-square-o");
								}
							});
					$("#mai").click(function() {
						$('[name="check"]').attr("flag","1");
						$('[name="check"]').attr("class","uk-icon-check-square-o");
					});
					$("#none").click(function() {
						$('[name="check"]').attr("flag","0");
						$('[name="check"]').attr("class","uk-icon-square-o");
					});
					$("#mail").click(function() {
						var str = [];
						var d = 0;
						var ids = [];
						var news = $('[name="check"]');
						for ( var n = 0; n < news.length; n++) {
							if (news[n].getAttribute("flag") == "1")
								ids.push(news[n].getAttribute("id"));
						}
						
						
						for ( var i = 0; i < ids.length; i++) {
							if(i%70==0){
								d = d + 1;
								str[d]="";
							}
							if(i<70*d){
								if (str[d] != "")
									str[d] = str[d] + "";
								str[d] = str[d] + ids[i] +"@lucentsquare.co.jp;";
							}													
						}
						
						if(d==0){
							window.alert('チェックされていません');
						}
						
						else if(ids.length < 70){
							if(window.confirm("以下を宛先としてメールを作成します。よろしいですか？\n" +
									          "---------------------------------------------\n"+str[1])){
								location.href = "mailto:" + str[1];							
							}
						}else{
							if(window.confirm("文字数がURLの制限を超えています。\n" +
											  "複数のメールを作成します。よろしいですか？\n")){
								for(var q=1;q<=d;q++){
								location.href = "mailto:" +str[q] ;						
							}
						}
							/*注意が出る場合のダイアログ
							 * windows.alert('このシステムから一度に入れられる宛先の数は70件までとなります。\n
							 * 70件以下にするか、直接アドレスを入力してください')
							*/
						}

						});

				});
	});

//$("#mail").attr("href", "mailto:" + str);}
/*$("#mail").click(function() {
var str = "";
var ids = [];
var news = $('[name="check"]');
for ( var n = 0; n < news.length; n++) {
	if (news[n].getAttribute("flag") == "1")
		ids.push(news[n].getAttribute("id"));
}
for ( var i = 0; i < ids.length; i++) {
	if (str != "")
		str = str + "";
	str = str + ids[i] +"@lucentsquare.co.jp;";
}
if(str.length === 0){
	window.alert('チェックされていません');
}
else if(str.length < 2083){
	if(window.confirm("以下の宛先にメールを送ります。よろしいですか？\n" +
			          "---------------------------------------------\n"+str)){
		location.href = "mailto:" + str;
		location.href = "mailto:" + str;
		location.href = "mailto:" + str;
	}else{
		
	}
}else{
	if(window.confirm("文字数がURLの制限を超えています。\n" +
					  "以下のアドレスをコピーしてOK押してください。その後、メーラーが起動するので宛先にペーストしてください。\n" +
					  "---------------------------------------------\n"+str)){
		location.href = "mailto:";
	}else{
		
	}
}

});*/