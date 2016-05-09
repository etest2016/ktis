<%
//******************************************************************************
//   프로그램 : web_preview.jsp
//   모 듈 명 : 응시자 웹시험지 미리보기
//   설    명 : 응시자 웹시험지 미리보기
//   테 이 블 : exam_m
//   자바파일 : qmtm.tman.exam.ExamList
//   작 성 일 : 2010-06-18
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;	
	}

	String title = "";

	try {
		title = ExamList.getExamTitle(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
<HEAD>
<TITLE> :: 시험지 미리보기 :: </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">
<!--

	function frameofTest()
	{
		window.open("../../user/paper/fraTest.jsp?id_exam=<%= id_exam %>&userid=tman@@2008", "test_exampaper", "fullscreen=yes, scrollbars=yes");
	}

//-->
</script>


<HEAD>

<BODY id="popup2">   

   <div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험 미리보기 <span>시험지를 미리 확인합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<table id="tableD" cellpadding="0" border="0" cellspacing="0">
			<tr>
				<td id="left" width="65"><li>시험명</td>
				<td><%=title%></td>
			</tr>
			<tr>
				<td id="left">&nbsp;</td>
				<td>
					<input type="text" class="input" name="userid" value="tman@@2008" readonly size="14"><br>
					<div class="point_s" style="margin-top: 5px;">* 해당 아이디로 응시자 시험지를 미리 확인할 수 있으며, 답안 제출후에도 반복해서 시험에 응시할 수 있습니다.</div>
				</td>
			</tr>
		</table>		

	</div>

	<div id="button">
		<a href="javascript:frameofTest();" onfocus="this.blur();"><img src="../../images/bt_paper_preview_yj1.gif"></a>&nbsp;&nbsp;<img src="../../images/bt5_exit_yj1_11.gif" onclick="window.close();" style="cursor: hand;">
	</div>


 </BODY>
</HTML>
