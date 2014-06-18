var exist_flag = 0;
var exist_files = "";
$(function(){
	$("input[name='inputFile']").on("change",function(){
		exist_flag = 0;
		exist_files = "";
		var files = $("#upload-select")[0].files;
		$("#select_files ul").html("");
		$("#select_files div").addClass("uk-panel-box");
		for(var i = 0; files[i]; i++){
			isExist(files[i].name);
			$("#select_files ul").append('<li>' + files[i].name + '<p class="uk-align-right">' 
						+ getFileSize(files[i].size) + '</p></li>');
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
        				location.href = "/staff_room/jsp/ip_forbidden.jsp";
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
	function isExist(filename){
		var category = $("select option:selected").val();
		var page = $("input[name='page']").val();
		$.ajax({
			type : "POST",
			url : "/staff_room/IfExist",
			cache: false,
			data : {"category" : category,
					"file" : filename,
					"page" : page},
		}).done(function(result){
			if(result == "true"){
				exist_flag = 1;
				exist_files += filename + " ";
				$("#select_files ul li:contains('" + filename + "')").addClass("uk-text-danger");
			}
		});
	}
	
	$("#add").click(function(){
		if(exist_flag == 1){
			if(!confirm('ファイル' + exist_files + 'はすでに存在しています。置き換えますか？')){
				return false;
			}
		}
	});
	
	$("select[name='category']").on("change",function(){
		var files = $("#upload-select")[0].files;
		for(var i = 0; files[i]; i++){
			isExist(files[i].name);
		}
	});
});