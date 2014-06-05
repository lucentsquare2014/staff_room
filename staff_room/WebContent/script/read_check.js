$(function(){
	$("td > a").on("click", function(){
		if(typeof $(this).attr("id") != 'undefined'){
			var news_id = $(this).attr("id");
			$.ajax({
				type: "POST",
				url: "/staff_room/UpdateReadCheck",
				dataType:'json',
				data: {"news_id" : news_id},
				cache: false
			}).done(function(msg){
				$("[id=" + news_id + "]").removeClass();
				$("[id=" + news_id + "]").next(".uk-badge-danger").remove();
				$("#title").text(msg.title);
				$("#text").text(msg.text);
				if(msg.filename != ""){
					$("#filename").text("添付：" + msg.filename);
				}
			});
		}
	});
	$('.uk-modal').on({
	    'uk.modal.hide': function(){
	        console.log("Element is not visible.");
	        $("#title,#text,#filename").text("");
	    }
	});
});