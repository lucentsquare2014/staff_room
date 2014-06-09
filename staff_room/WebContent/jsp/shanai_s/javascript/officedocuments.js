//給与明細表示
function jumpSelectSalary() {
num_year = document.month.year.selectedIndex;
if (num_year != "" || num_year != null) {
if (document.month.year.options[num_year].value != "def")
window.open(document.month.year.options[num_year].value,
"window2", "width=800,height=450");
//location.href=document.month.year.options[num_year].value;
}
}
//申請書作成
function jumpSelectMakeDocu() {
num_docu = document.make.docu.selectedIndex;
if (num_docu != "" || num_docu != null) {
if (document.make.docu.options[num_docu].value != "def")
location.href = document.make.docu.options[num_docu].value;
}
}
// nm : id属性のテーブル名
// key : value属性の絞込みに使用する値
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

function submitNewInfo(id, action) {
		document.newinfoselect.position.value=id;
		document.newinfoselect.action=action;
        document.newinfoselect.submit();
    }

function submitSyouninInfo(id) {
        document.syounininfoselect.position.value=id;
        document.syounininfoselect.submit();
    }