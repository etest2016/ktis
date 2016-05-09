//#tip create editor
if(true)
{
	var clsid =  "154BFB55-C14A-49c3-BC94-887BDA7C2BEE";
	var version = "3,0,0,1031";
	var cab = "tweditor2.cab";
	var env = "env.xml";
	var id = "twe12";
	var applyinitdata = 1;//apply:1
	var editmode = 0;//edit:0
	var key = "Qjg3RDJFNkQ3NjE4NzNDQTA3OEM0RkI2MDEwREFCQThDMjIyOUVBRkFBQzk5QzY0RTNDMjVFRURBQkFEODNDQ0JCMzQzODk3QTQ0MTVERTJFN0JDRjZCMkRBMEE2QkI0MjdGQjg3RjgyQTI4NzA2QzBEQjM1OEQ5RDk3OEIzRjJDM0E1MEEzRTgxQzM0RDdDNzU4MTBDNzAzRjFBMDQ0NjMyMERGN0JBQUNGNzFCNERFMjdFREE2MDAyRTgyMUM4OERGRThENTM3RjdDMkI2NTQ4NTU4NkI3QzUzQTNEMzYzQ0M2NUU3MDc5RDlBQzVBMjZFQzI5MDEzRDA4QTYwMjk4QzYxM0E0MzQyNzhBNDI1NTNEMTNBQTNEMEVGMDM3QTI2MzMwMjA5OTk0QTUzNjQ4RUVGMURCQTI2NkFEMkZBQjg4NzBCMzg3NzFDMTM0AA==";
	
	document.write('<object ID="'+id+'" width="100%" height="100%" CLASSID="CLSID:'+clsid+'" CODEBASE="'+cab+'#version='+version+'">');
	document.write('<PARAM name="InitFile" value="'+env+'"/>');
	document.write('<PARAM name="ApplyInitData" VALUE="'+applyinitdata+'"/>');
	document.write('<PARAM name="Mode" VALUE="'+editmode+'"/>');
	document.write('<PARAM name="LicenseKey" value="'+key+'">');
	document.write('</object>');
}

//#tip p->br, br->p
if(false)
{
	document.write('<script language="JScript" FOR="'+id+'" EVENT="OnKeyDown(event)">');
	document.write('	if (!event.shiftKey && event.keyCode == 13)');
	document.write('	{');
	document.write('		document.'+id+'.InsertHtml("<br>");');
	document.write('		event.returnValue = true;');
	document.write('	}');
	document.write('	if (event.shiftKey && event.keyCode == 13)');
	document.write('	{');
	document.write('		document.'+id+'.InsertHtml("<p>");');
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
	document.write('<OBJECT id="ContextMenu" width="0" height="0" classid="CLSID:7823A620-9DD9-11CF-A662-00AA00C066D2" CODEBASE="http://activex.microsoft.com/controls/iexplorer/x86/iemenu.cab#version=4"></OBJECT>');
	document.write('<script language="JScript" FOR="twe" EVENT="OnContextMenu(event)">');
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