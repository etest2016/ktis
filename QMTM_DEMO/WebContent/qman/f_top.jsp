<%
//******************************************************************************
//   ���α׷� : f_top.asp
//   �� �� �� : �������� ��� ������
//   ��    �� : �������� ��� ������
//   �� �� �� : 
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib
//   �� �� �� : 2010-06-01
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� :   
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");    

	String userid = (String)session.getAttribute("userid"); // ����� ���̵�
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	int qcnt = Integer.parseInt(request.getParameter("qcnt"));
	int tcnt = Integer.parseInt(request.getParameter("tcnt"));
%>

<HTML>
 <HEAD>
  <TITLE> New Document </TITLE>
  <style>
	body { margin: 0px 0px 100px 0px; }
  </style>
  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="tree.js"></script>
 
 <script language="javascript">

	function QSearch(){
		window.open("q_search.jsp","QSearch","width=900,height=650, scrollbars=yes, top=0, left=0");
	}

</script>
 
 </HEAD>

 <BODY>

 <table width="100%" cellpadding="0" cellspacing="0" height="40" border="0"> 
	<tr>
		<td width="250" valign="top" align="center" style="background-image: url(img/bg_logo.gif)"><img src="img/logo.gif"></td>
		<td align="right" valign="middle" style="padding-right: 40px; background-color: #000000;">
			<INPUT TYPE="hidden" NAME="" value="<%=userid%>">

			<div style="float: right;">
				<% if(tcnt!=0 || userid.equals("qmtm")){ %><a href="../tman/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/tman.gif"></a><% } %><% if(qcnt!=0 || userid.equals("qmtm")){ %><a href="../qman/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/qman.gif"></a><% } %><% if(userid.equals("qmtm")){ %><a href="../admin/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/admin.gif"></a><% } %>
			</div>

		</td>
	</tr>
</table>

</BODY>
</HTML>
