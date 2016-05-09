<%
//******************************************************************************
//   프로그램 : subject_mgr.jsp
//   모 듈 명 : 과목관리
//   설    명 : 과목관리 페이지
//   테 이 블 : q_subject
//   자바파일 : qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree//              
//   작 성 일 : 2008-04-03
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // 과목목록 가지고오기
	QmanTreeBean[] rst = null;

	try {
		rst = QmanTree.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	function sub_insert() {
		window.open("subject_insert.jsp","insert","width=400, height=250, scrollbars=no");
    }

	function sub_view(id_q_subject) {
		
		window.open("subject/subject_view.jsp?id_q_subject="+id_q_subject,"view","width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="main">	
    <br>
    <TABLE width="730" border="0">
	<tr>
	<td width="30"></td>
	<td align="right">

	<TABLE width="700">
		<TR>
			<TD>과목 리스트</TD>
			<!--TD align="right"><a href="javascript:sub_insert();">[신규 과목 등록]</a></TD-->
		</TR>
	</TABLE>
	<table border="0" width="700" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC" align="center">
		<tr height="30" bgcolor="#DBDBDB"  align="center">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB" align="center">과목코드</td>
			<td bgcolor="#DBDBDB">과목명</td>
			<td bgcolor="#DBDBDB">등록일자</td>
			<!--<td bgcolor="#DBDBDB">담당자확인</td>-->
		</tr>
		<% if(rst == null) { %>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center" colspan="4">등록되어진 과목이 없습니다.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center"><%=i+1%></td>
			<td align="center"><a href="javascript:sub_view('<%=rst[i].getId_q_subject()%>');"><%=rst[i].getId_q_subject()%></a></td>
			<td align="center"><a href="subject/subject_list.jsp?id_q_subject=<%=rst[i].getId_q_subject()%>"><%=rst[i].getQ_subject()%></a></td>
			<td align="center"><%=rst[i].getRegdate()%></td>
			<!--<td align="center">[담당자 확인]</td>-->
		</tr>
		<%
			   }
			}
		%>
	</table>

	</td>
	</tr>
	</table>
	
 </BODY>
</HTML>