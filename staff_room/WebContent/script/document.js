$(function(){
	$("input[name='inputFile']").on("change",function(){
		var files = $("#upload-select")[0].files;
		var file_str = "";
		for(var i = 0; files[i]; i++){
			file_str += files[i].name + "\n";
		}
		$("input[name='select_files']").val(file_str);
		$("#add").prop('disabled',false);
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
						"page" : page}
			}).done(function(){
				notif({
					type : "success",
					msg : "削除しました!",
					position : "center",
					width : 500,
					height : 60,
					timeout : 2000
				});
				if(page == "manual"){
					$(".uk-table :checked").each(function(){
						$(this).parent("td").parent("tr").fadeOut();
					});
				}else{
					setTimeout(function(){
				        location.reload();
				    },1500);
				}
				
			});
		}
	});
});