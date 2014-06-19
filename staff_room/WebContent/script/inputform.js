var name_str = $("input[name='inputFiles']").val();
$(function(){
	
	var flg = "input";
	$("button").click(function(){
		$("#alert").text("");
		if(flg == "input"){
			$("#select").text($("select[name='inputPostid'] option:selected").text());
			$("#title").text($("input[name='inputTitle']").val());
			$("#text").text($("textarea[name='inputText']").val());
			$("#author").text($("input[name='inputWriter']").val());
			if($("#loop *").length == 0){
				$("#file").text("選択されていません");
			}else{
				$("#file").text("");
				var input_files = $("input[name='inputFiles']").val().split(",");
				for(var i = 0; i < input_files.length; i++){
					$("#file").append("<a href=\"/staff_room/upload/" + input_files[i] + 
							"\">" + input_files[i] + "</a>&nbsp;");
				}
			}
			if($("input[name='inputPrimary']").prop('checked')){
				$("#primary").addClass("uk-panel-badge uk-badge uk-badge-warning uk-text-large");
				$("#primary").text("緊急");
				$("input[name='inputPrimary']").val("1");
			}else{
				$("#primary").removeClass();
				$("#primary").text("");
				$("input[name='inputPrimary']").val("0");
			}
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
	
	$('input').keypress(function(ev) {
		if ((ev.which && ev.which === 13) || (ev.keyCode && ev.keyCode === 13)) {
			return false;
		} else {
			return true;
		}
	});
});

$(function(){
	name_str = $("input[name='inputFiles']").val();
    var progressbar = $("#progressbar"),
        bar         = progressbar.find('.uk-progress-bar'),
        settings    = {

        action: '/staff_room/upload', // upload url

        allow : '*.*', // allow only files

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
            $(".uk-form-controls").prepend("<div class=\"uk-alert uk-alert-success\" id=\"cpl\">アップロードが完了しました。</div>");
            setTimeout(function(){
                $("#cpl").addClass("uk-hidden");
            }, 3000);
            var files = $("#upload-select")[0].files;
            for(var i = 0; files[i]; i++){
            	if(name_str.indexOf(files[i].name) == -1){
            		name_str = name_str + files[i].name + ",";
                	$("#loop").append(function(){
                		return "<div class=\"uk-alert\">" + 
                		"<a href=\"\" class=\"uk-alert-close uk-close\" data-uk-alert></a>" +
                		"<a href=\"/staff_room/upload/" + files[i].name + "\">" + files[i].name + "</a></div>";
                	});
            	}
            	$("#loop").find('a').click(function(){
            		var deleted = $(this).next().text();
            		var news_id = $("input[name='inputNewsid']").val();
            		var $close= $(this).parent();
            			$.ajax({
            				type: "POST",
            				url: "/staff_room/Delete",
            				data: {"deleteFile" : deleted,
            						"newsId" : news_id },
            				cache: false,
            				statusCode: {
            					403: function() {
                    				location.href = "/staff_room/jsp/ip_forbidden.jsp";
                    			}
                    		}
            			}).done(function(){
            				$close.remove();
            				var remove_name = deleted + ",";
            				var s = $("input[name='inputFiles']").val().replace(remove_name,'');
            				$("input[name='inputFiles']").val(s);
            				name_str = $("input[name='inputFiles']").val();
            			});
            		//return false;
            	});
            }
            $("input[name='inputFiles']").val(name_str);
            
        }
    };

    var select = new $.UIkit.upload.select($("#upload-select"), settings);
});
$(function(){
	$(".uk-close").click(function(){
		var deleted = $(this).next().text();
		var news_id = $("input[name='inputNewsid']").val();
		var $close= $(this).parent();
			$.ajax({
				type: "POST",
				url: "/staff_room/Delete",
				data: {"deleteFile" : deleted,
						"newsId" : news_id },
				cache: false,
				statusCode: {
					403: function() {
        				location.href = "/staff_room/jsp/ip_forbidden.jsp";
        			}
        		}
			}).done(function(){
				$close.remove();
				var remove_name = deleted + ",";
				var s = $("input[name='inputFiles']").val().replace(remove_name,'');
				$("input[name='inputFiles']").val(s);
				name_str = $("input[name='inputFiles']").val();
			});
		//return false;
	});
	
});