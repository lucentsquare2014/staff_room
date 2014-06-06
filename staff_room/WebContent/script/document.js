$(function(){
	$("input[name='inputFile']").on("change",function(){
		var files = $("#upload-select")[0].files;
		var file_str = "";
		for(var i = 0; files[i]; i++){
			file_str += files[i].name + "\n";
		}
		$("input[name='select_files']").val(file_str);
		$("#add").removeAttr("disabled");
	});
});