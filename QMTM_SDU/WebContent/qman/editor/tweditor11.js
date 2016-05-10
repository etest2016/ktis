//#tip create editor
if(true)
{
	var clsid =  "976A7D6C-B14C-4e50-A5C3-B43D8C49D8C8";
	var version = "3,7,1,1004";
	var cab = "tweditor.cab";
	var env = "env2.xml";
	var id = "twe11";
	var applyinitdata = 1;//apply:1
	var editmode = 0;//edit:0

	var key = "Y8yxj8T8hoRxDHvjWNpsqP66tzMEZz6PwH55bEJg8w6G8tXY67En5XpX3nOS0q5uRx5xchMmUI4ubYJnq6zIC29kRe7pfE/KsxZaZ8x92H8MHX4sk0cDXH0bcvTCr8Fc0746Yn//LfrCkGFT7SM61GrFjePjeCcIDXM5iKyHAKHTGgElQ/iA6Gk7+kjLay/4Toy49vKovMZHZ6upD/+kWjW2uMRuHRBMUIHnYV66lxw=";

	document.write('<object ID="'+id+'" width="100%" height="100%" CLASSID="CLSID:'+clsid+'" CODEBASE="'+cab+'#version='+version+'">');
	document.write('<PARAM name="InitFile" value="'+env+'"/>');
	document.write('<PARAM name="ApplyInitData" VALUE="'+applyinitdata+'"/>');
	document.write('<PARAM name="Mode" VALUE="'+editmode+'"/>');
	document.write('<PARAM name="LicenseKey" value="'+key+'">');
	document.write('</object>');
}

//#tip p->br, br->p
if(true)
{
	document.write('<script language="JScript" FOR="'+id+'" EVENT="OnKeyDown(event)">');
	document.write('	if (!event.shiftKey && event.keyCode == 13)');
	document.write('	{');
	document.write('		document.'+id+'.InsertHtml("<br>");');
	document.write('		event.returnValue = true;');
	document.write('	}');	
	document.write('</script>');
}

//#tip protected backspace
if(false)
{
	document.write('<script language="JavaScript">');
	document.write('document.onkeydown = twekeyhandler;');
	document.write('function twekeyhandler() {');
	document.write('    if (window.event && window.event.keyCode == 8) {');
	document.write('        alert("protected backspace key");');
	document.write('        return false;');
	document.write('    }');
	document.write('}');
	document.write('</script>');
}

//#tip activex redesign ref)http://www.tagfree.com/ver2/Support_Center/faq/faq_view.asp?supno=11
if(false)
{
	if(editmode != 1)
	{
		document.write('<script language="JScript" FOR="'+id+'" EVENT="BeforeTabChange">');
		document.write('	var view = document.'+id+'.ActiveTab;');
		document.write('	if(view == 1 || view == 3)');
		document.write('	{')
		document.write('		document.'+id+'.ObjectToScript("object", "object.asp","tag","tweobject");');
		document.write('		document.'+id+'.ObjectToScript("embed", "object.asp","tag","tweobject");');
		document.write('	}')
		document.write('</script>');
		document.write('<script language="JScript" FOR="'+id+'" EVENT="OnLoadComplete">');
 		document.write('	var view = document.'+id+'.ActiveTab;');
 		document.write('	if(view == 1 || view == 3) document.'+id+'.ScriptToObject("tag","tweobject");');
		document.write('</script>');
	}
}

//#tip custom popup menu
if(false)
{
	document.write('<OBJECT id="ContextMenu" width="0" height="0" CLASSID="CLSID:'+clsid+'" CODEBASE="'+cab+'#version='+version+'"></OBJECT>');
	document.write('<script language="JScript" FOR="'+id+'" EVENT="OnContextMenu(event)">');
	document.write('	ContextMenu.Clear();');
	document.write('	ContextMenu.AddItem ("1", 1);');
	document.write('	ContextMenu.AddItem ("2", 2);');
	document.write('	ContextMenu.PopUp();');
	document.write('	event.returnValue = true;');
	document.write('</script>');
	document.write('<SCRIPT LANGUAGE="VBscript">');
	document.write('Sub ContextMenu_Click(ByVal x)');
	document.write('	alert(x)');
	document.write('End Sub');
	document.write('</SCRIPT>');
}