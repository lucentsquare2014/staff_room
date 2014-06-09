$.jPrintArea=function(el){
	var iframe=document.createElement('IFRAME');
	var doc=null;
	$(iframe).attr('style','position:absolute;width:0px;height:0px;left:-500px;top:-500px;');
	document.body.appendChild(iframe);
	doc=iframe.contentWindow.document;
	doc.write('<link type="text/css" rel="stylesheet" href=""></link>');
	doc.write('<div class="'+$(el).attr("class")+'">'+$(el).html()+'</div>');
	doc.close();
	iframe.contentWindow.focus();
	iframe.contentWindow.print();
	document.body.removeChild(iframe);
};