function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function showAllOn() {  // 채점·해설 보이기
	self.focus();
	var chk = document.thisfrm.chkflag.value;
	var chk2 = document.thisfrm.chkflag2.value;
	var objTable = document.all.tags("table");
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("crtTab") != -1) { objTable[i].style.display = "none"; }
	}
	if (chk == 'all') {
		if (chk2 == 'expOnly') {
			for (var i = 0; i < objTable.length; i++) {
				if (objTable[i].id.indexOf("Tab") != -1) { objTable[i].style.display = ""; }
				if (objTable[i].id.indexOf("Show") != -1) { objTable[i].style.display = ""; }
			}
		} else {
			for (var i = 0; i < objTable.length; i++) {
				if (objTable[i].id.indexOf("Show") != -1) { objTable[i].style.display = ""; }
			}
		}
	} else {
		if (chk2 == 'expOnly') {
			for (var i = 0; i < objTable.length; i++) {
				if (objTable[i].id.indexOf("NoTab") != -1) { objTable[i].style.display = ""; }
				if (objTable[i].id.indexOf("ShowYes") != -1) { objTable[i].style.display = "none"; }
				if (objTable[i].id.indexOf("ShowNo") != -1) { objTable[i].style.display = ""; }
				if (objTable[i].id.indexOf("ShowExNo") != -1) { objTable[i].style.display = ""; }
			}
		} else {
			for (var i = 0; i < objTable.length; i++) {
				if (objTable[i].id.indexOf("ShowYes") != -1) { objTable[i].style.display = "none"; }
				if (objTable[i].id.indexOf("ShowNo") != -1) { objTable[i].style.display = ""; }
				if (objTable[i].id.indexOf("ShowExNo") != -1) { objTable[i].style.display = ""; }
			}
		}
	}
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("crtTab") != -1) { objTable[i].style.display = "none"; }
	}
}
function showAllOff() {  // 채점·해설 감추기
	self.focus();
	var chk = document.thisfrm.chkflag.value;
	var objTable = document.all.tags("table");
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("crtTab") != -1) { objTable[i].style.display = "none"; }
	}
	if (chk == 'all') {
		for (var i = 0; i < objTable.length; i++) {
			if (objTable[i].id.indexOf("Tab") != -1) { objTable[i].style.display = ""; }
			if (objTable[i].id.indexOf("Show") != -1) { objTable[i].style.display = "none"; }
		}
	} else {
		for (var i = 0; i < objTable.length; i++) {
			if (objTable[i].id.indexOf("NoTab") != -1) { objTable[i].style.display = ""; }
			if (objTable[i].id.indexOf("Show") != -1) { objTable[i].style.display = "none"; }
		}
	}
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("crtTab") != -1) { objTable[i].style.display = "none"; }
	}
}
function showOnlyEx() {	// 해설만 보기
	self.focus();
	var chk = document.thisfrm.chkflag.value;
	var objTable = document.all.tags("table");
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("crtTab") != -1) { objTable[i].style.display = "none"; }
	}
	if (chk == 'all') {
		for (var i = 0; i < objTable.length; i++) {
			if (objTable[i].id.indexOf("Tab") != -1) { objTable[i].style.display = "none"; }
			if (objTable[i].id.indexOf("Show") != -1) { objTable[i].style.display = "none"; }
			if (objTable[i].id.indexOf("ShowEx") != -1) { objTable[i].style.display = ""; }
		}
	} else {
		for (var i = 0; i < objTable.length; i++) {
			if (objTable[i].id.indexOf("Tab") != -1) { objTable[i].style.display = "none"; }
			if (objTable[i].id.indexOf("Show") != -1) { objTable[i].style.display = "none"; }
			if (objTable[i].id.indexOf("ShowExYes") != -1) { objTable[i].style.display = "none"; }
			if (objTable[i].id.indexOf("ShowExNo") != -1) { objTable[i].style.display = ""; }
		}
	}
	document.thisfrm.chkflag2.value = 'expOnly';
}
function viewYes() {	//모든문제 보기;
	self.focus();
	var objTable = document.all.tags("table");
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("crtTab") != -1) { objTable[i].style.display = "none"; }
	}
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("Show") != -1) { objTable[i].style.display = "none"; }
		if ((objTable[i].id.indexOf("YesTab") != -1)||(objTable[i].id.indexOf("NoTab") != -1)) { objTable[i].style.display = ""; }
	}
	document.thisfrm.chkflag.value = 'all';
}
function viewNo() {		//틀린문제만 보기;
	self.focus();
	var objTable = document.all.tags("table");
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("crtTab") != -1) { objTable[i].style.display = "none"; }
	}
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("Show") != -1) { objTable[i].style.display = "none"; }
		if (objTable[i].id.indexOf("YesTab") != -1) { objTable[i].style.display = "none"; }
		if (objTable[i].id.indexOf("NoTab") != -1) { objTable[i].style.display = ""; }
	}
	document.thisfrm.chkflag.value = 'prt';	
}
function viewCrtTab() {
	self.focus();
	var objTable = document.all.tags("table");
	for (var i = 0; i < objTable.length; i++) {
		if (objTable[i].id.indexOf("Show") != -1) { objTable[i].style.display = "none"; }
		if (objTable[i].id.indexOf("Tab") != -1) { objTable[i].style.display = "none"; }
		if (objTable[i].id.indexOf("crtTab") != -1) { objTable[i].style.display = ""; }
	}	
}
