<%
//******************************************************************************
//   프로그램 : exam_kind_list.jsp
//   모 듈 명 : 그룹구분 리스트
//   설    명 : 그룹구분 리스트 페이지
//   테 이 블 : r_exam_kind
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil 
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // 그룹구분목록 가지고오기
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script type="text/javascript">
	function insert() {
		window.open("exam_kind_insert.jsp","insert","top=0, left=0, width=400, height=300, scrollbars=no");
    }

	function view(id_exam_kind) {
		
		window.open("exam_kind_view.jsp?id_exam_kind="+id_exam_kind,"view","top=0, left=0, width=400, height=300, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">그룹구분 리스트</div>
			<div class="location">ADMIN > 기타정보관리 > <span>그룹구분코드관리</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt">
			<TD colspan="4"><a href="javascript:insert();"><img src="../../images/g_purpose.gif"></a></TD>
		</TR>
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">코드</td>
			<td bgcolor="#DBDBDB">그룹구분</td>
			<td bgcolor="#DBDBDB">설명</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="4">등록되어진 그룹구분이 없습니다.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getId_exam_kind()%></td>
			<td><a href="javascript:view('<%=rst[i].getId_exam_kind()%>');"><%=rst[i].getExam_kind()%></a></td>
			<td><%=ComLib.nullChk(rst[i].getRmk())%>&nbsp;</td>
		</tr>
		<%
			   }
			}
		%>
	</table>
	</div>

	<jsp:include page="../../copyright.jsp"/>
		
		
 </BODY>
</HTML>