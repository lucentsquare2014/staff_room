$(function(){
	
	var flg = "input";
	$("button").click(function(){
		$("#alert").text("");
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

$(function(){
	
    var progressbar = $("#progressbar"),
        bar         = progressbar.find('.uk-progress-bar'),
        settings    = {

        action: '/staff_room/upload', // upload url

        allow : '*.*', // allow only images

        loadstart: function() {
            bar.css("width", "0%").text("0%");
            progressbar.removeClass("uk-hidden");
        },

        progress: function(percent) {
            percent = Math.ceil(percent);
            bar.css("width", percent+"%").text(percent+"%");
        },

        allcomplete: function(response) {

            bar.css("width", "100%").text("100%");

            setTimeout(function(){
                progressbar.addClass("uk-hidden");
            }, 1500);
        }
    };

    var select = new $.UIkit.upload.select($("#upload-select"), settings);
});