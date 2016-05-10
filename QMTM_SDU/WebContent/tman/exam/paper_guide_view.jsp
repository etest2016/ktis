<%
//******************************************************************************
//   프로그램 : paper_guide_view.jsp
//   모 듈 명 : 영역안내문 확인
//   설    명 : 영역안내문 확인
//   테 이 블 : 
//   자바파일 : qmtm.tman.paper.ExamPaperGuide
//   작 성 일 : 2008-05-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	int nr_q = Integer.parseInt(request.getParameter("nr_q"));

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		window.close();
	</script>
<%	
	}

	// 해당 시험에 영역안내문을 가지고 온다.

	ExamPaperGuideBean rst = null;

	try {
		rst = ExamPaperGuide.getBean(id_exam, nr_q);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<script language="JavaScript">

	function guide_del() {
		var st = confirm("*주의* 영역안내문을 삭제하시겠습니까?" );
        if (st == true) {
			document.location = "paper_guide_delete.jsp?id_exam=<%=id_exam%>&nr_q=<%=nr_q%>";
        }
	}

	function guide_edit() {
		document.location = "paper_guide_edit.jsp?id_exam=<%=id_exam%>&nr_q=<%=nr_q%>";
	}

</script>
<HEAD>
<TITLE> 영역안내문 확인 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">영역안내문 확인 <span>영역안내문 확인및 수정,삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">영역안내문 시작번호</td>
				<td>&nbsp;&nbsp;<%=nr_q%></td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="guide_msg" cols="40" rows="5" readonly><%=rst.getGuide_msg()%></textarea></td>
			</tr>
		</table>
		</div>

	<div id="button">
		<!--<input type="button" value="수정하기" onClick="guide_edit();">--><a href="javascript:guide_edit();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="삭제하기" onClick="guide_del();">--><a href="javascript:guide_del();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;
		<input type="image" value="취소" onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();">
	</div>

	</form>

</BODY>
</HTML>