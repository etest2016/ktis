<%
//******************************************************************************
//   프로그램 : search_comp.jsp
//   모 듈 명 : 키워드 비교 결과 정보
//   설    명 : 키워드 비교 결과 정보
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2009-02-09
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*, java.util.*, java.util.regex.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	if (id_q.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

	String comp_bigo = request.getParameter("comp_bigo");
	if (comp_bigo == null) { comp_bigo = ""; } else { comp_bigo = comp_bigo.trim(); }

	if (comp_bigo.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}
	

	String basic_ans = "";
				
	try {
		basic_ans = Score_Comp.getBasicAns(id_exam, id_q, 1);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());
		if(true) return;
	}

	String[] arrSearch = basic_ans.split(" ");
	String myAns = "";

	try {
		myAns = Score_Comp.getAnswers(id_exam, id_q, userid);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());
		if(true) return;
	}

	myAns = myAns.trim();
	myAns = myAns.replace(")","");
	myAns = myAns.replace("(","");
	myAns = myAns.replace("|","");
	//엔터값을 스페이스로 변환
	myAns = myAns.replace("\r\n"," ");

	String[] arrMyAns = myAns.split(" ");
	String[] arrResult = new String[arrMyAns.length];
	String sPos = "";

	Pattern pt = null;
	Matcher mt = null;
	int p = 0;
	int q = 0;

	for (p=0; p<arrSearch.length; p++) {
		pt = Pattern.compile(arrSearch[p]);

		if (arrSearch[p].trim().length() > 0) {
			for(q=0; q < arrMyAns.length; q++) {

				mt = pt.matcher(arrMyAns[q]);
				if(mt.find()) {
					arrResult[q] = "<font color=red>" + arrMyAns[q] + "</font>";
					sPos = sPos + Integer.toString(q) + ",";
				}
			}
		}
	}

	String sResultAns = "";

	if (sPos != "") {
		sPos = sPos.substring(0, sPos.length()-1);

		String[] arrPos = sPos.split(",");

		int iPos = 0;
		for (p=0; p<arrPos.length; p++) {
			iPos = Integer.parseInt(arrPos[p]);
			arrMyAns[iPos] = arrResult[iPos];
		}
	}

	for (p=0; p<arrMyAns.length; p++) {
		sResultAns = sResultAns + arrMyAns[p] + " ";
	}

%>

<html>
<head>
<title>키워드 비교 결과</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>

<body style="padding: 20px;">

	<table border="0" width="100%" cellpadding="5">
		<tr>
			<td align="center">
				
				<div class="title">키워드 비교 결과 정보</div>
				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="tableD">
					<tr height="30">    
						<td width="20%" align="center" id="left"><B>키워드</B></td>      
						<td width="45%" bgcolor="#ffffff"><B>&nbsp;<%= basic_ans %></B></td> 		
					</tr>
					<tr height="30">    
						<td align="center" id="left"><B>응시자</B></td>
						<td bgcolor="#ffffff"><B>&nbsp;<%=userid%></B></td> 		
					</tr>
					<tr>
						<td width="45%" bgcolor="#FFFFFF" colspan="2"><%= sResultAns %></td> 
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<BR>
	<table border="0" width="100%">
		<tr>
			<td align=center><img src="../images/bt5_exit_yj1.gif" onclick="window.close();" style="cursor: pointer;"></td>
		</tr>
	</table>

</body>
</html>