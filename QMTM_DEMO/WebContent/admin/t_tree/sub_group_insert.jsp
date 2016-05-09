<%
//******************************************************************************
//   프로그램 : subject_group_insert.jsp
//   모 듈 명 : 과목그룹 등록
//   설    명 : 과목그룹 등록 팝업 페이지
//   테 이 블 : c_subjec, q_subject
//   자바파일 : qmtm.admin.TmanTree, qmtm.admin.TmanTreeBean
//   작 성 일 : 2008-04-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.admin.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("UTF8");

	String id_course = request.getParameter("id_course");

    // 담당자 담당과목 목록 가지고오기
	TmanTreeBean[] rst = null;

	try {
		rst = TmanTree.getAddBeans(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	
%>

<HTML>
 <HEAD>
  <TITLE> :: 과목선택 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <script language="JavaScript">
	function checks() {
		var frm = document.form1;
		var cnt = 0;

		if (frm.subjects.length == undefined) { //한개일때 체크
			if(frm.subjects.checked==true ) {
			   cnt = cnt + 1;
			} 
		}else{

			for(i=0;i<frm.subjects.length;i++) {
				if(frm.subjects[i].checked) {
					cnt = cnt + 1;
				}
			}
		}
			
		if(cnt == 0) {
			alert("과목을 선택하세요.!!!");
			return false;
		}

		frm.submit();
    }	
 </script>

 </HEAD>

 <BODY id="popup2">

	<form name="form1" method="post" action="sub_group_insert_ok.jsp">
	<input type="hidden" name="id_course" value="<%=id_course%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">과목 등록 <span>과목을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA">
			 <tr id="tr">
				<td width="7%">선택</td>
				<td>과목코드</td>
				<td>과목명</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="3">추가하실 과목이 없습니다.</td>
			</tr>
			
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>		
			<tr id="td">
				<input type="hidden" name="names<%=rst[i].getId_subject()%>" value="<%=rst[i].getSubject()%>">
				<td align="center"><input type="checkbox" name="subjects" value="<%=rst[i].getId_subject()%>"></td>			
				<td align="center"><%=rst[i].getId_subject()%></td>
				<td align="center"><%=rst[i].getSubject()%></td>			
			</tr>
			<%
				   }
				}
			%>
		</table>
	
	</div>

	<div id="button">
		<% if(rst != null) { %><img onClick="checks();" src="../../images/bt_sja_1.gif" style="cursor:hand"><% } %>&nbsp;&nbsp;<img src="../../images/bt_close_1.gif" align="top" style="cursor:hand" onClick="window.close();">
	</div>

	</form>	

 </BODY>
</HTML>