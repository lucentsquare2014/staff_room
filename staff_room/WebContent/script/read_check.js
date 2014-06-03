$(function(){
	$("td > a").one("click", function(){
		var news_id = $(this).attr("id");
		$.ajax({
			type: "POST",
			url: "/staff_room/UpdateReadCheck",
			data: {"news_id" : news_id},
			cache: false
		}).done(function(){
			$("#" + news_id).removeClass();
		});
	});
});