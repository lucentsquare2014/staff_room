$(function(){
	$("td > a").one("click", function(){
		if(typeof $(this).attr("id") != 'undefined'){
			var news_id = $(this).attr("id");
			$.ajax({
				type: "POST",
				url: "/staff_room/UpdateReadCheck",
				dataType:'json',
				data: {"news_id" : news_id},
				cache: false
			}).done(function(msg){
				$("#" + news_id).removeClass();
				$("#" + news_id).next().remove();
				$("#title").text(msg.title);
				$("#text").text(msg.text);
				$("#filename").text("添付：" + msg.filename);
			});
		}
	});
});