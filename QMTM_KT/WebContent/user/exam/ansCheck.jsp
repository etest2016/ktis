<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="qmtm.ComLib, etest.User_QmTm "%>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }	

	if (userid.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String yn_end = "";

	try {
		yn_end = User_QmTm.getYn_end(userid, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>


<html>
<head>
<title>답안제출 확인</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<style type="text/css">	body      { font-size: 9pt; font-family: 굴림체, 돋움체, 굴림; }	table     { font-size: 9pt; font-family: 굴림체, 돋움체, 굴림; line-height: 150%; }</style>
<script language="JavaScript">
<!--
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

//-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<% if (yn_end == null) { %>
        <td align="center"><img src="../images/submitm.gif" border="0" onclick="window.close();" style="cursor: hand;"></td>
	    <% } else if (yn_end.equals("Y")) { %>
        <td align="center"><img src="../images/submito.gif" border="0" onclick="window.close();" style="cursor: hand;"></td>
		<% } else { %><!-- N etc -->
        <td align="center"><img src="../images/submitn.gif" border="0" onclick="window.close();" style="cursor: hand;"></td>
	    <% } %>
	</tr>
</table>
</body>
</html>
