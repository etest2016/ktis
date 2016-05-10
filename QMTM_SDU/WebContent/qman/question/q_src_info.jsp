<%
//******************************************************************************
//   프로그램 : q_src_info.jsp
//   모 듈 명 : 문제 출처 관리 
//   설    명 : 문제 출처 관리
//   테 이 블 : q, exam_m, exam_q
//   자바파일 : qmtm.ComLib, qmtm.tman.exam.QunitBean, qmtm.tman.exam.Qunit, 
//              qmtm.tman.statics.StaticQ, qmtm.tman.statics.StaticQBean
//   작 성 일 : 2013-02-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>  
<%@ page import="qmtm.ComLib, qmtm.tman.exam.QunitBean, qmtm.tman.exam.Qunit, qmtm.tman.statics.StaticQ, qmtm.tman.statics.StaticQBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_q = request.getParameter("id_q");

	String id_exam = "";

	QunitBean qbean = null;
	
	try {
		qbean = Qunit.getQBean(Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	int cacount = qbean.getCacount();
	int excount = qbean.getExcount();
	String reg_userid = qbean.getUserid();
	String regdate = qbean.getRegdate();
	String up_date = qbean.getUp_date();
	String qtype = qbean.getQtype();
	String difficulty = qbean.getDifficulty();
	int make_cnt = qbean.getMake_cnt();

	StaticQBean[] scoreQ = null;

	try {
		scoreQ = StaticQ.getQList3(Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>
<html>
<head>
<title>출제정보확인</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
<script language="javascript">
	function exam_info(id_exam) {
		$.posterPopup("../../tman/exam/paper_option.jsp?id_exam="+id_exam, "", "width=850, height=650, scrollbars=yes");
	}
</script>

	</head>
	<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">출제정보확인 <span>시험명을 클릭하면 시험상세정보를 확인할 수 있습니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">

			<TR style="background-color: #ffffff;">
				<TD width="100%" style="background-color:#fff;" valign="top">

					<table border="0" width="100%" cellpadding ="0" cellspacing="0" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt; background-color: #FCFCFC;" valign="top">
						<tr bgcolor="#FFFFFF">
							<td width="50%" valign="top">					
							<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff" width="95%" align="left">
								<tr style="height: 25px; text-align: center; background-image: url(../../images/yj_q_static_tableyj22_1.gif); background-repeat: repeat-x; font-size: 10pt;">
									<td width="40%"><font color="#24908b"><b>항목</b></font></td>
									<td align="center"><font color="#24908b"><b>정보</b></font></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#24908b">&nbsp;□&nbsp; 문제코드</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba;padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=id_q%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#24908b">&nbsp;□&nbsp; 문제유형</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba;padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=qtype%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#24908b">&nbsp;□&nbsp; 보기수</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba;padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=excount%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#24908b">&nbsp;□&nbsp; 정답수</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=cacount%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#24908b">&nbsp;□&nbsp; 난이도</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=difficulty%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#24908b">&nbsp;□&nbsp; 출제횟수</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=make_cnt%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#24908b">&nbsp;□&nbsp; 입력자</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=reg_userid%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#24908b">&nbsp;□&nbsp; 입력일</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=regdate%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#24908b">&nbsp;□&nbsp; 최종수정일</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=up_date%></td>
								</tr>
						</table>
					</td>

					<td width="50%" valign="top"><iframe src="q_static.jsp?id_q=<%=id_q%>" frameborder="0" name="q_view" width="100%" height="250"  marginwidth="0" marginheight="5" scrolling="auto"></iframe></td>
				</tr>
			</table>

			<BR><BR>
			<table border="0" cellpadding="5" cellspacing="0" bgcolor="#ffffff" width="100%" style="background-color: #ffffff; border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba; border-left: 1px solid #8b9eba;">
				<tr bgcolor="#FFFFFF" style="height: 27px; text-align: center; background-image: url(../../images/yj_q_static_tableyj22_1.gif); background-repeat: repeat-x; font-size: 10pt;">
					<td align="center" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>시험명</b></font></td>
					<td align="center" width="10%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>과정명</b></font></td>
					<td align="center" width="10%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>강좌명</b></font></td>
					<td align="center" width="15%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>시험일자</b></font></td>
					<td align="center" width="8%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>정답률</b></font></td>
					<td align="center" width="8%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>응시인원</b></font></td>
					<td align="center" width="4%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>O</b></font></td>
					<td align="center" width="4%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>X</b></font></td>
					<td align="center" width="4%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>①</b></font></td>
					<td align="center" width="4%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>②</b></font></td>
					<td align="center" width="4%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>③</b></font></td>
					<td align="center" width="4%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>④</b></font></td>
					<td align="center" width="4%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>⑤</b></font></td>
				</tr>
			<% 
				if(scoreQ == null) { 
					id_exam = "1";
			%>
				<tr bgcolor="#FFFFFF" style="text-align: center;">
					<td colspan="13" style="padding: 5px 10px 5px 12px;">&nbsp;</td>
				</tr>
			<% 
				} else {
					id_exam = scoreQ[0].getId_exam();
					for(int q=0; q<scoreQ.length; q++) {
			%>
				<tr bgcolor="#FFFFFF" height="25" style="text-align: center;">
					<td style="border-right: 1px solid #8b9eba; background-color: #f3f6fd;">&nbsp;<a href="javascript:" onClick="exam_info('<%=scoreQ[q].getId_exam()%>');"><%=scoreQ[q].getTitle()%></a></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getCourse()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getSubject()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getExam_start()%> ~<BR><%=scoreQ[q].getExam_end()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getO_rate()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getAll_sum()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getO_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getX_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx1_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx2_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx3_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx4_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx5_cnt()%></td>
				</tr>
				<tr bgcolor="#CCCCCC" style="text-align: center;">
					<td colspan="13" style="border-right: 1px solid #CCCCCC;"></td>
				</tr>
			<%
					}
				}	
			%>	
		</table>

	</div>
	<div id="button">
		<img src="../../images/bt5_exit_yj1_11.gif" onclick="javascript:window.close();" onfocus="this.blur();" style="cursor: pointer;">
	</div>

</body>
</html>