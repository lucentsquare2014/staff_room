var clicked_count = 0;
//nm : id属性のテーブル名
//key : value属性の絞込みに使用する値
function tblfilter(nm, key) {
	if (!document.getElementsByTagName)
		return;
	var trs = document.getElementById(nm).rows;
	for ( var i = 0; i < trs.length; i++) {
		var tr = trs[i];
		if (!tr.title || tr.title == '')
			continue;
		var found = 0;
		if (key == '')
			found = 1;
		else {
			var keys = tr.title.split(',');
			for ( var j = 0; j < keys.length; j++) {
				if (keys[j] == key) {
					found = 1;
					break;
				}
			}
		}
		tr.style.display = found ? '' : 'none';
	}
}

function checkGroup() {
	if (!document.getElementsByTagName)
		return;
	var filter = document.getElementById("groupFilter");
	var key = filter.options[filter.selectedIndex].value;
	var trs = document.getElementById("selectTable").rows;
	for ( var i = 0; i < trs.length; i++) {
		var tr = trs[i];
		if (!tr.title || tr.title == '')
			continue;
		var found = 0;
		var keys = tr.title.split(',');
		for ( var j = 0; j < keys.length; j++) {
			if (keys[j] == key) {
				found = 1;
				break;
			}
		}
		if(found){
			var cbox = document.getElementById(keys[2]);
			if(!cbox.checked) clickBox(keys[2],keys[1]);
		}
	}
}

function uncheckGroup() {
	if (!document.getElementsByTagName)
		return;
	var filter = document.getElementById("groupFilter");
	var key = filter.options[filter.selectedIndex].value;
	var trs = document.getElementById("selectTable").rows;
	for ( var i = 0; i < trs.length; i++) {
		var tr = trs[i];
		if (!tr.title || tr.title == '')
			continue;
		var found = 0;
		var keys = tr.title.split(',');
		for ( var j = 0; j < keys.length; j++) {
			if (keys[j] == key) {
				found = 1;
				break;
			}
		}
		if(found){
			var cbox = document.getElementById(keys[2]);
			if(cbox.checked) clickBox(keys[2],keys[1]);
		}
	}
}

function changeBox(nm, tg){
	if (!document.getElementsByTagName)
		return;
	var cbox = document.getElementById(nm);
	var tr = document.getElementById(tg);
	var disp;
	if(cbox.checked){
		disp = '';
		clicked_count++;
	}
	else {
		disp = 'none';
		clicked_count--;
	}
	tr.style.display = disp; 
	checkDisableButton();
}

function clickBox(nm,tg){
	if (!document.getElementsByTagName)
		return;

	var cbox = document.getElementById(nm);
	if(cbox.checked) cbox.checked = false;
	else cbox.checked = true;
	changeBox(nm, tg);
}

function resetCheckBox(){
	if (!document.getElementsByTagName)
		return;
	var trs = document.getElementById("selectedTable").rows;
	for ( var i = 0; i < trs.length; i++) {
		var tr = trs[i];
		if(tr.id != "headder")
		tr.style.display = 'none';
	}
	clicked_count = 0;
	checkDisableButton();
}

function checkDisableButton(){
	var able = true;
	if(clicked_count > 0) able = false;
	document.sendform.send.disabled = able;
	//document.sendform.send_nyuryoku.disabled = able;
}

function sendNyuryoku(action){
	document.body.style.cursor = 'wait';
	document.sendform.send.disabled = true;
	//document.sendform.send_nyuryoku.disabled = true;
	document.sendform.action=action;
	document.sendform.submit();
}

window.onload = function() {
	if (!document.getElementsByTagName)
		return;
	var trs = document.getElementById("selectedTable").rows;
	for ( var i = 0; i < trs.length; i++) {
		var tr = trs[i];
		if(tr.id != "headder")
		tr.style.display = 'none';
	}
	document.sendform.send.disabled = true;
	//document.sendform.send_nyuryoku.disabled = true;
};

