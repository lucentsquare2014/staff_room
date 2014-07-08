$(document).ready(function(){
	var a = $("#year option:selected").val();
	$("input[name='select']").val(a);
  });

$(function(){
	
	$("#add").click(function(){
		var m = $.trim($("input[name='add_month']").val());
		var d = $.trim($("input[name='add_day']").val());
		var h = $.trim($("input[name='add_holiday']").val());
		if(m == ""){
			alert("月を入力してください！");
			return false;
		}
		if(d == ""){
			alert("日を入力してください！");
			return false;
		}
		if(h == ""){
			alert("祝日名を入力してください！");
			return false;
		}
		var y = $("#year option:selected").text();
		var di = new Date(y, m - 1, d);
		if(!(di.getFullYear() == y && di.getMonth() == m-1 && di.getDate() == d)){
			alert("正しい日付を入力してください。");
			return false;
		}
	});
	
	$("input[type='text']").change(function(){
		var txt = $.trim($(this).val());
		var han = txt.replace(/[Ａ-Ｚａ-ｚ０-９]/g,function(s){return String.fromCharCode(s.charCodeAt(0)-0xFEE0);});
		if(han.match(/^[1-9]$/)){
			han = 0 + han;
		}
		$(this).val(han);
	});
	
	$("#update").click(function(){
		var y = $("#year option:selected").text();
		var m = $.trim($("input[name='month']").val());
		var d = $.trim($("input[name='day']").val());
		if(m != "" && d != ""){
			var di = new Date(y, m - 1, d);
			if(!(di.getFullYear() == y && di.getMonth() == m-1 && di.getDate() == d)){
				alert("正しい日付を入力してください。");
				return false;
			}
		}
	});
	
	$("#year").change(function(){
		var year = $("#year option:selected").text();
		$.ajax({
			type: "POST",
			url: "/staff_room/jsp/shanai_s/Exchange",
			dataType:'json',
			data: {"year" : year},
			cache: false
		}).done(function(list){
			var table = $("#main");
			$("tr:not(:eq(0))", table).remove();
			$.each(list, function (index, data) {
				var name = data.h_休日名;
				var ymd = $.trim(data.h_年月日);
				var m = ymd.substr(4,2);
				var d = ymd.substr(6,2);
			    table.append('<tr><td><input type="text" size="5" maxlength="2" name="month" value="' + m + '"></td>'
			    		+ '<td><input type="text" size="5" maxlength="2" name="day" value="' + d + '"></td>'
			    		+ '<td><input type="text" size="30" name="holiday" value="' + name + '"></td></tr>');
			   
			});
		});
	});
	
});