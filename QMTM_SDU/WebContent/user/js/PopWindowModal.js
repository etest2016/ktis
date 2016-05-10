// <META name="AUTHOR" content="CheongJH">

var popObj, popObjM, popObjF

function PopWindow(url)
{
  // no toolbar, no status
  var w = window.screen.availWidth - 12;
  var h = window.screen.availHeight - 78;
  if (popObj && !popObj.closed) popObj.close();
  popObj = window.open(url, "popWin", "Width="+w+", Height="+h+", Left=0,Top=0, resizable=yes, scrollbars=yes, status=no, menubar=yes, toolbar=no");
}

function PopWindowM(url)
{
  // no toolbar, no status, no memu
  var w = window.screen.availWidth - 12;
  var h = window.screen.availHeight - 32;
  if (popObjM && !popObjM.closed) popObjM.close();
  popObjM = window.open(url, "popWinL", "Width="+w+", Height="+h+", Left=0,Top=0, resizable=yes, scrollbars=yes, status=no, menubar=no, toolbar=no");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function PopFullScreen(url, scrollYN)
{
  var YN = (scrollYN == "Y") ? "yes" : "no";
  if (popObjF && !popObjF.closed) popObjF.close();
  popObjF = window.open(url, "popWinF", "fullscreen=yes,scrollbars="+YN);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function PopModal(url, vArg, w, h)
{
	// url
	// vArg : dialogArguments
	// w : width in px
	// h : height in px

  var left = (window.screen.width - w) / 2;
  var top = (window.screen.height - h) / 2;

  var retVal = window.showModalDialog(url, vArg, "dialogWidth:"+w+"px;dialogHeight:"+h+"px; status: no; scroll: no; help: off; edge: sunken;");
  return retVal;

  // window.dialogArguments
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function PopModal_00(url, vArg, w, h)
{
	// url
	// vArg : dialogArguments
	// w : width in px
	// h : height in px

  var retVal = window.showModalDialog(url, vArg, "dialogWidth:"+w+"px; dialogHeight:"+h+"px; dialogLeft:0; dialogTop:0; status: no; scroll: yes; help: off; edge: sunken;");
  return retVal;

  // window.dialogArguments
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

