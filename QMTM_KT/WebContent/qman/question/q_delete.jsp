<%
//******************************************************************************
//   프로그램 : q_delete.jsp
//   모 듈 명 : 문제 삭제
//   설    명 : 출제되지 않은 문제에 한하여 삭제 가능
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-04-21
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 2008-07-07 
//   수 정 자 : 이테스트 석준호
//	 수정사항 : 여러문항 동시 삭제 가능(출제되지 않은 문항에 한해서)
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>  
<%@ page import="qmtm.*, qmtm.qman.question.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
	
	if (id_qs.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%
	}

	String[] arrId_qs = id_qs.split(",");

	QListBean[] rst = null;

	try {
		rst = QListUtil.getQHistory(id_qs);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	StringBuffer del_NQ = new StringBuffer();

	StringBuffer del_YQ = new StringBuffer();

	String res = "";
	String res2 = "";

	String del_ABC = "A";

	if(rst == null) {
		res2 = id_qs;
		res = "";
		del_ABC = "A";
	} else {
		for(int j=0; j<rst.length; j++) {
			del_NQ.append(rst[j].getId_q());
			del_NQ.append(",");
		}

		res = del_NQ.toString().substring(0, del_NQ.toString().length()-1);

		for(int k=0; k<arrId_qs.length; k++) {
			if(res.indexOf(arrId_qs[k]) < 0) {
				del_YQ.append(arrId_qs[k]);
				del_YQ.append(",");
			}
		}

		if(del_YQ.toString().length() ==0) {
			del_ABC = "B";
		} else {
			del_ABC = "C";
			res2 = del_YQ.toString().substring(0, del_YQ.toString().length()-1);
		}
	}
%>

<html>
	<head>
	<title>문제 삭제하기</title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	</head>

	<BODY style="font: normal 12px gulim, dotum; margin: 0px; background-image: url(../../images/popup_bg.gif); padding: 5px 5px 5px 5px;" id="qman">
	
	<form name="form1" method="post" action="q_delete_ok.jsp">
	<input type="hidden" name="id_qs" value="<%=res2%>">
	<center>
	<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/top_left_yj1.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/top_right_yj1.gif"></TD>
		</TR>
		
		<TR style="background-color: #ffffff;">
			<TD></TD>
			<TD>
		<% if(del_ABC.equals("A")) { %>
			<table border="0" width="100%" cellpadding ="0" cellspacing="2" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
				<tr height="40" bgcolor="#DBDBDB">
					<td colspan="2" width="27%" style="background-color: #FCFCFC; text-align: left;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;현재 선택된 문제를 삭제하시겠습니까? 삭제된 문제는 복구할 수 없습니다.</td>
				</tr>
				<tr height="50" bgcolor="#DBDBDB">
					<td align="left" width="27%" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">삭제 문제코드</td>
					<td align="left" bgcolor="#FFFFFF" style="background-color: #FCFCFC; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"><textarea cols="60" rows="5" readonly><%=res2%></textarea></td>
				</tr>
				<tr height="30">
					<td colspan="2" width="17%" rowspan="14" bgcolor="#FFFFFF" valign="top" align="center"><br><input type="image" value="삭제하기" name="submit" src="../../images/bt_q_delete_yj1.gif">&nbsp;&nbsp;&nbsp;<!--input type="button" value="취소하기" onClick="window.close()"--><a href="javascript:window.close();"><img border="0" src="../../images/user_static_yj1_2.gif"></td>
				</tr>
			</table>

		<% } else if(del_ABC.equals("B")) { %>
			<table border="0" width="100%" cellpadding ="0" cellspacing="2" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
				<tr height="60" bgcolor="#DBDBDB">
					<td width="100%" style="background-color: #FCFCFC; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">현재 선택된 문제 모두 시험에 출제되었던 문제들 입니다.<br>이미 출제되었던 문제들은 삭제할 수 없습니다.</td>
				</tr>
				<tr>
					<td width="100%" rowspan="14" bgcolor="#FFFFFF" valign="top" align="center"><BR><BR><!--input type="button" value="창 닫기" onClick="window.close()"--><a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></td>
				</tr>
			</table>
			
		<% } else if(del_ABC.equals("C")) { %>
			<table border="0" width="100%" cellpadding ="0" cellspacing="2" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
				<tr height="30" bgcolor="#DBDBDB">
					<td colspan="2" width="27%" style="background-color: #FCFCFC; text-align: left;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;현재 선택된 문제중 시험에 출제된 문제들이 있습니다. 이미 출제되었던 문제들은 삭제할 수 없습니다.</td>
				</tr>
				<tr height="40" bgcolor="#DBDBDB">
					<td align="left" width="27%" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">기출제 문제코드</td>
					<td align="left" bgcolor="#FFFFFF" style="background-color: #FCFCFC; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"><textarea cols="60" rows="3" readonly><%=del_NQ.toString()%></textarea></td>
				</tr>
				<tr height="30" bgcolor="#DBDBDB">
					<td colspan="2" width="27%" style="background-color: #FCFCFC; text-align: left;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;현재 선택된 문제를 삭제하시겠습니까? 삭제된 문제는 복구할 수 없습니다.</td>
				</tr>
				<tr height="40" bgcolor="#DBDBDB">
					<td align="left" width="27%" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">삭제 문제코드</td>
					<td align="left" bgcolor="#FFFFFF" style="background-color: #FCFCFC; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"><textarea cols="60" rows="3" readonly><%=res2%></textarea></td>
				</tr>				
				<tr>
					<td colspan="2" width="17%" rowspan="14" bgcolor="#FFFFFF" valign="top" align="center"><input type="image" value="삭제하기" name="submit" src="../../images/bt_q_delete_yj1.gif">&nbsp;&nbsp;&nbsp;<!--input type="button" value="취소하기" onClick="window.close()"--><a href="javascript:window.close();"><img border="0" src="../../images/user_static_yj1_2.gif"></td>
				</tr>
			</table>			
		<% } %>
		</TD>
			<TD></TD>
		</TR>

		<TR style="height: 10px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/bottom_left_yj2.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/bottom_right_yj2.gif"></TD>
		</TR>
	</TABLE>
		</form>
	</body>
</html>