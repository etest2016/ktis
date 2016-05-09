<%
//******************************************************************************
//   프로그램 : 
//   모 듈 명 : 오류문항 신고
//   설    명 : 
//   테 이 블 : 
//   자바파일 : qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil              
//   작 성 일 : 2008-12-05
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.*, qmtm.qman.question.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

    // 신규 등록 문제 가져오기
	QListBean[] rst = null; 

	try {
		rst = QListUtil.getNewQ(userid);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<HTML>
<HEAD>
<TITLE> :: 오류문항 신고 :: </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">
</HEAD>


<BODY id="popup2">

	<form name="frmdata" method="post" action="exams2_ok.jsp">
	<input type="hidden" name="id_q_subject" value="">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">오류문항 신고 <span>해당 문항에 대한 오류접수를 진행합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="15%">문항코드</td>
				<!--문제코드 입력-->
				<td width="35%">&nbsp;</td>
				<td id="left" width="15%">오류문항</td>
				<td>
					<SELECT NAME="">
						<OPTION VALUE="" SELECTED>유형선택
						<OPTION VALUE="">
					</SELECT>
				</td>
			</tr>
			<tr>
				<td id="left">신고자</td>
				<td>&nbsp;</td>
				<td id="left">신고일</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td id="left">신고자</td>
				<td colspan="3">
					<textarea style="width: 100%; height: 200px;"></textarea>
				</td>
			</tr>
		</table>
	<div>
	<br>
	<span class="point_s">※ 신고 할 오류 유형과 오류 내용을 입력 후 [확인] 버튼을 클릭 하십시오.<br>
	&nbsp;&nbsp;(주의) 한번 신고한 오류문항은 수정할 수 없으므로 정확하게 입력해 주시기 바랍니다.</span>


	<div id="button">
		<input type="image" value="확인" name="submit" src="../images/bt5_submit.gif" onfocus="this.blur();">&nbsp;
		<input type="image" value="취소" onclick="window.close();" src="../images/bt5_cancle.gif" onfocus="this.blur();">
	</div>
	
	
	</form>

</body>
</HTML>