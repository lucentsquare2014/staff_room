var exist_flag = [];
var exist_files = "";
$(function(){
	$("input[name='inputFile']").on("change",function(){
		exist_flag.length = 0;
		exist_files = "";	
		var files = $("#upload-select")[0].files;
		$("#select_files ul").html("");
		var fl = $("input[name='inputFile']").offset();
		$("#select_files .uk-panel").addClass("uk-panel-box");
		$("#select_files").css({
			"top": fl.top + 35 + "px",
			"left": fl.left - 225 + "px"
		});
		for(var i = 0; files[i]; i++){
			$("#select_files ul").append('<li><div class="uk-align-left" style="margin:0 0 0 0;">'
						+ '<div class="uk-badge uk-badge-notification uk-badge-danger"'
						+ 'data-uk-tooltip title="このファイルは既に存在しています。">!</div>&nbsp;' 
						+ files[i].name + '</div><div class="uk-align-right">' 
						+ getFileSize(files[i].size) + '</div></li>');
			isExist(files[i].name,i);
		}
		$("#select_files").show();
		$("#add").prop('disabled',false);
		if(files.length == 0){
			$("#select_files").hide();
			$("#add").prop('disabled',true);
		}
	});
	
	$(".uk-table :checkbox").click(function(){
		if($(".uk-table :checked").length > 0){
			$("#delete").prop('disabled', false);
		}else{
			$("#delete").prop('disabled', true);
		}
	});
	
	$("#delete").click(function(){
		if(confirm('選択された書類をすべて削除してもいいですか?')){
			var page = $("input[name='page']").val();
			var filenames = "";
			$(".uk-table :checked").each(function(){
				filenames += $(this).val() + ",";
				console.log($(this).val());
			});
			$.ajax({
				type : "POST",
				url : "/staff_room/DocumentDelete",
				cache: false,
				data : {"delete" : filenames,
						"page" : page},
				statusCode: {
					403: function() {
        				location.href = "/staff_room/jsp/error/ip_forbidden.jsp";
        			}
        		}
			}).done(function(){
				notif({
					type : "success",
					msg : "削除しました!",
					position : "center",
					width : 500,
					height : 60,
					timeout : 2000
				});
				setTimeout(function(){
					location.reload();
				},1500);
			});
		}
	});
	
	// ファイルのサイズを取得
	function getFileSize(file_size)
	{
	  var str = "";
	  
	  // 単位
	  var unit = ['byte', 'KB', 'MB', 'GB', 'TB'];

	  for (var i = 0; i < unit.length; i++) {  
	    if (file_size < 1024) {
	      if (i == 0) {
	        // カンマ付与
	        var integer = file_size.toString().replace(/([0-9]{1,3})(?=(?:[0-9]{3})+$)/g, '$1,');
	        str = integer +  unit[ i ];
	      } else {
	        // 小数点第2位は切り捨て
	        file_size = Math.floor(file_size * 100) / 100;
	        // 整数と小数に分割
	        var num = file_size.toString().split('.');
	        // カンマ付与
	        var integer = num[0].replace(/([0-9]{1,3})(?=(?:[0-9]{3})+$)/g, '$1,');
	        if (num[1]) {
	          file_size = integer + '.' + num[1];
	        }
	        str = file_size +  unit[ i ];
	      }
	      break;
	    }
	    file_size = file_size / 1024;
	  }

	  return str;
	} 
	
	// ファイルが既に存在するかを判定
	function isExist(filename,li_index){
		var category = $("select option:selected").val();
		var page = $("input[name='page']").val();
		$.ajax({
			type : "POST",
			url : "/staff_room/IfExist",
			cache: false,
			data : {"category" : category,
					"file" : filename,
					"page" : page},
			async: false,
		}).done(function(result){
			var exist_file = $("#select_files ul li:eq(" + li_index + ")"); 
			if(result == "true"){
				exist_flag.push(1);
				exist_files += '"' + filename + '" ';
				exist_file.addClass("uk-text-danger");
				exist_file.children(1).children(".uk-badge").show();
			}else{
				exist_flag.push(0);
				exist_file.removeClass("uk-text-danger");
				exist_file.children(1).children(".uk-badge").hide();
			}
		});
	}
	
	$("#add").click(function(){
		if(exist_flag.indexOf(1) != -1){
			if(!confirm('ファイル' + exist_files + 'はすでに存在しています。置き換えますか？')){
				return false;
			}
		}
	});
	
	$("select[name='category']").on("change",function(){
		var files = $("#upload-select")[0].files;
		exist_flag.length = 0;
		exist_files = "";
		for(var i = 0; files[i]; i++){
			isExist(files[i].name,i);
		}
	});
	
	// ファイル名を変更
	var older_name = "";
	var category = "";
	$("i#edit").on("click",function(){
		$("input[name='new_name']").val($(this).prev().text());
		older_name = $("input[name='new_name']").val();
		var row = $(this).parent().parent();
		var index = row.index("tr");
		for(var i = index; i > 0; i--){
			var type = $("tr:eq(" + i + ")").find("#type").text();
			if(type != ""){
				category = type;
				break;
			}
		}
	});
	
	$("#enter").on("click",function(){
		var new_name = $("input[name='new_name']").val();
		var page = $("input[name='page']").val();
		$.ajax({
			type : "POST",
			url : "/staff_room/ReName",
			cache: false,
			data : {"category" : category,
					"new_name" : new_name,
					"older_name" : older_name,
					"page" : page},
			statusCode: {
				403: function() {
					$("#msg").text("このファイルはすでに存在しています。別のファイル名にしてください！")
							 .addClass("uk-text-danger");
	        	}
	        }
		}).done(function(){
			$("#msg").text("ファイル名変更しました！").attr("class","uk-text-success");
			setTimeout(function(){
				location.reload();
			},1500);
		});
	});
	$("table td#filename").mouseover(function(){
		$(this).children("i").show();
	}).mouseout(function(){
		$(this).children("i").hide();
	});
	
	$('.uk-modal').on({
	    'uk.modal.hide': function(){
	        $("#msg").text("新しいファイル名を入力してください。").removeClass("uk-text-danger");
	    },
		'uk.modal.show': function(){
			$("input[name='new_name']").focus();
		}
	});
	
	$("#select_files div p").mousedown(function(e){
		var clickPonitX = e.pageX - $("#select_files").offset().left;
		var clickPonitY = e.pageY - $("#select_files").offset().top;
		$(document).mousemove(function(e){
			$("#select_files").css({
				"top": e.pageY - clickPonitY + "px",
				"left": e.pageX - clickPonitX + "px"
			});
		});
	}).mouseup(function(){
		$(document).off("mousemove");
	});
	
	// IE対応
	$("#select_files .uk-close").click(function(){
		var ua=window.navigator.userAgent;
		if(ua.match(/MSIE/) || ua.match(/Trident/)) {
			$("#select_files").hide();
			$("#add").prop("disabled",true);
			return false;
		}
	});

	$(".content").mCustomScrollbar({
    	autoHideScrollbar: true,
    	theme: "dark"
    });

});