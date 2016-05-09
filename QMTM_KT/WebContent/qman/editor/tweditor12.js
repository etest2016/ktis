//#tip create editor
if(true)
{
	var clsid =  "2B9CC783-2A5D-4189-8B97-F5D28E02F6F2";
	var version = "3,5,1,2009";
	var cab = "tweditor.cab";
	var env = "env.xml";
	var id = "twe12";
	var applyinitdata = 1;//apply:1
	var editmode = 0;//edit:0

	var key = "YyR0jzMCXrcRIHFUUta3yyNJs6ksdlzDWAyaSVLlFmHz1/tpL6xOgSLh5+D17+IxpNOTCjDGNOrdSqHMozNG+SPPVCTuEg1SvFLoKVkoy++Dnj1A9J7wbyl1mbxC7Z1p9DrB2cDbyxmurtY7rHpF3grey97L0xkaksjMoxesN97XrbfvRGOmPC+Ovij8+t94";

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