<%
//******************************************************************************
//   프로그램 : paper_guide_edit.jsp
//   모 듈 명 : 영역안내문 등록
//   설    명 : 영역안내문 등록
//   테 이 블 : exam_paper_guide
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

	// 해당 시험에 시험지 최대번호를 가지고온다.
	
	int q_cnts = 0;

	try {
		q_cnts = ExamPaperGuide.getPaperQcnt(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
	
	// 해당 시험에 영역안내문을 수정한다.

	ExamPaperGuideBean rst = null;

	try {
		rst = ExamPaperGuide.getBean(id_exam, nr_q);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<script language="JavaScript" type="text/javascript">
    <!--
    
	function checks() {
		if(document.frmdata.guide_msg.value == "") {
			alert("지시문 내용을 입력하세요.");
			return false;
		} else {
			document.frmdata.submit();
		}
	}

	//-->

</script>
<HEAD>
<TITLE> 영역안내문 수정 </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
 <link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="paper_guide_update.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="nr_qs" value="<%=nr_q%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">영역안내문 수정 <span>영역안내문 수정합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="48%">영역안내문시작번호</td>
				<td>&nbsp;&nbsp;<select name="nr_q">
					<% for(int i=0; i<q_cnts; i++) { %>
					<option value="<%=i+1%>" <% if(nr_q == (i+1)) { %> selected <% } %>>&nbsp;&nbsp;&nbsp;# <%=i+1%>&nbsp;&nbsp;&nbsp;</option>
					<% } %>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="guide_msg" cols="40" rows="5"><%=rst.getGuide_msg()%></textarea></td>
			</tr>
		</table>
	</div>

	<div id="button">
	<!--<input type="button" value="수정하기" onClick="checks();">--><a href="javascript:checks();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;
		<input type="image" value="취소" onclick="window.close();" src="../../../images/bt5_exit_yj1.gif" onfocus="this.blur();">
	</div>

	</form>

</BODY>
</HTML>