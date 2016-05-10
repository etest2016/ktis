<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*, java.util.*, java.util.regex.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

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

	String ans_rate = request.getParameter("ans_rate");
	if (ans_rate == null) { ans_rate = ""; } else { ans_rate = ans_rate.trim(); }

	if (ans_rate.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}


	String basic_ans = "";
				
	try {
		basic_ans = Score_Comp.getBasicAns(id_exam, id_q, 2);
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
	String aPos = "";
	String bPos = "";
	String sPos = "";

	Pattern pt = null;
	Matcher mt = null;
	int p = 0;
	int q = 0;

	//응시자의 답안 하이라이트 처리
	for (p=0; p<arrSearch.length; p++) {
		aPos = "";
		pt = Pattern.compile(arrSearch[p]);

		if (arrSearch[p].trim().length() > 0) {
			for(q=0; q < arrMyAns.length; q++) {

				mt = pt.matcher(arrMyAns[q]);
				if(mt.find()) {
					arrResult[q] = "<font color=red>" + arrMyAns[q] + "</font>";
					sPos = sPos + Integer.toString(q) + ",";
					
					//응시자의 답안과 일치하는 검색어의 위치를 기억한다.
					if (aPos != Integer.toString(p)) {
						bPos = bPos + Integer.toString(p) + ",";
						aPos = Integer.toString(p);
					}
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


	String SearchCa = "";

	if (Double.parseDouble(ans_rate) >= 100) {
		SearchCa = "<font color=blue>" + basic_ans + "</font>";
	} else if (bPos != "") {
		//모범답안 하이라이트 처리
		bPos = bPos.substring(0, bPos.length()-1);
		String[] arrPosCa = bPos.split(",");

		int iPos = 0;
		for (p=0; p<arrPosCa.length; p++) {
			iPos = Integer.parseInt(arrPosCa[p]);
			arrSearch[iPos] = "<font color=blue>" + arrSearch[iPos] + "</font>";
		}

		for (p=0; p<arrSearch.length; p++) {
			SearchCa = SearchCa + arrSearch[p] + " ";
		}
	} else {
		SearchCa = basic_ans;
	}
%>

<html>
<head>
<title>답안 비교 결과</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>

<body style="padding: 20px;">

	<div class="title">비교 결과 정보</div>

	<table border='0' cellspacing='0' cellpadding='3' width='100%' bgcolor='#EEEEEE' id="TableD">
		<tr>
			<td id="left"><li><B>응시자</B></td>
			<td bgcolor="#FFFFFF" style="border-left: 1px solid #c2c9d9; border-right: 1px solid #c2c9d9;"><%=userid%></td>
			<td id="left" ><li><B>유사율</B></td>
			<td bgcolor="#FFFFFF" style="border-left: 1px solid #c2c9d9;"><%=ans_rate%> %</td>
		</tr>
		<tr>    
			<td width="50%" colspan="2" id="left" style="border-right: 1px solid #c2c9d9;"><li><B>모범 답안</B></td>  
			<td width="50%" colspan="2" id="left"><li><B>응시자 답안</B></td> 		
		</tr>
		<tr>    
			<td width="50%" colspan="2" bgcolor="#FFFFFF" style="border-right: 1px solid #c2c9d9;" valign="top"><%=SearchCa%>&nbsp;</td>  
			<td width="50%" colspan="2" bgcolor="#FFFFFF" valign="top"><%=sResultAns%></td>  
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