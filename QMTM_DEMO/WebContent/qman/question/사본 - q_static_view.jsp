<%
//******************************************************************************
//   프로그램 : q_static.jsp
//   모 듈 명 : 성적통계 관리 
//   설    명 : 성적통계 관리
//   테 이 블 : 
//   자바파일 : qmtm.tman.statics.StaticQBean, qmtm.tman.statics.StaticQ
//   작 성 일 : 2008-07-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.exam.*, qmtm.tman.statics.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_q = request.getParameter("id_q");

	String id_exam = "";

	QunitBean qbean = null;
	
	try {
		qbean = Qunit.getQBean(Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ex.getMessage());
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
		scoreQ = StaticQ.getQList2(Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>
<html>
<head>
<title>문항분석</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">
	
	self.moveTo(0,0) ;
	self.resizeTo(screen.availWidth,screen.availHeight) ;

	function q_static(id_exam) {
		document.q_view.location.href= "q_static_graph.jsp?id_q=<%=id_q%>&id_exam="+id_exam;
	}
</script>


	</head>
	<BODY style="font: normal 12px gulim, dotum; margin: 0px 0px 0px 0px; background-image:url(../../../images/yj_q_static_bg1.gif);background-color:#8698b3; padding: 15px 15px 15px 15px;">

	<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="28"><img src="../../../images/yj_q_static_leftbg1.gif"></TD>
			<TD style="background-image: url(../../../images/yj_q_static_top.gif); background-repeat: repeat-x; width:100%; height: 66px; padding-top: 0px; font: bold 14px dotum; color: #000;float: left; padding: 2px 0px 5px 22px;"><BR><BR>&nbsp;&nbsp;&nbsp;<img src="../../../images/yj_q_static_icon1.gif" align="absmiddle">&nbsp;&nbsp;문항 분석<font style=" font: normal 11px dotum; letter-spacing: -1px; color: #999; padding-left: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;문항분석 내용을 확인합니다.</font></TD>
			<TD width="28"><img src="../../../images/yj_q_static_rightbg1.gif"></TD>
		</TR>		
		<TR style="background-color: #ffffff;">
			<TD style="background-image: url(../../../images/yj_q_static_leftbg2.gif); background-repeat: repeat-y; width: 28px;"></TD>
			<TD width="100%" style="background-color:#fff;" valign="top">

				<table border="0" width="100%" cellpadding ="0" cellspacing="0" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt; background-color: #FCFCFC;" valign="top">
					<tr bgcolor="#FFFFFF">
						<td width="50%" valign="top">
<BR><BR>
							<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff" width="95%" align="left" style="background-color: #FCFCFC; border-top: 2px solid #8b9eba; border-bottom: 2px solid #8b9eba; border-right: 2px solid #8b9eba; border-left: 2px solid #8b9eba;">
								<tr height="30" style="height: 27px; text-align: center; background-image: url(../../../images/tableyj_top3.gif); background-repeat: repeat-x; font-size: 10pt;">
									<td width="40%" style="border-right: 1px solid #8b9eba; border-bottom: 2px solid #8b9eba;"><font color="#000"><b>항목</b></font></td>
									<td align="center" style="border-bottom: 2px solid #8b9eba;"><font color="#000"><b>정보</b></font></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#F17420">&nbsp;□&nbsp; 문제유형</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba;padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=qtype%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#F17420">&nbsp;□&nbsp; 보기수</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba;padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=excount%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#F17420">&nbsp;□&nbsp; 정답수</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=cacount%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#F17420">&nbsp;□&nbsp; 난이도</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=difficulty%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#F17420">&nbsp;□&nbsp; 출제횟수</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=make_cnt%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#F17420">&nbsp;□&nbsp; 입력자</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=reg_userid%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#F17420">&nbsp;□&nbsp; 입력일</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid ##8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=regdate%></td>
								</tr>
								<tr height="25" bgcolor="#FFFFFF">
									<td width="40%" style="background-color: #f3f6fd; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;"><font color="#F17420">&nbsp;□&nbsp; 최종수정일</font></td>
									<td style="background-color: #FCFCFC; border-bottom: 1px solid #8b9eba; padding: 5px 10px 5px 12px;">&nbsp;&nbsp;<%=up_date%></td>
								</tr>
						</table>
					</td>

					<td width="50%"><iframe src="q_static.jsp?id_q=<%=id_q%>" frameborder="0" name="q_view" width="100%" height="250"  marginwidth="0" marginheight="5" scrolling="auto"></iframe></td>
				</tr>
			</table>

<BR><BR><BR>
			<table border="0" cellpadding="1" cellspacing="0" bgcolor="#ffffff" width="100%" style="background-color: #FCFCFC; border-top: 2px solid #8b9eba; border-bottom: 2px solid #8b9eba; border-right: 2px solid #8b9eba; border-left: 2px solid #8b9eba;">
				<tr bgcolor="#FFFFFF" style="height: 27px; text-align: center; background-image: url(../../../images/tableyj_top3.gif); background-repeat: repeat-x; font-size: 10pt;">
					<td align="center" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>시험명</b></font></td>
					<td align="center" width="8%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>정답률</b></font></td>
					<td align="center" width="8%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>합계</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>O</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>X</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>①</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>②</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>③</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>④</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>⑤</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>⑥</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#000"><b>⑦</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba;"><font color="#000"><b>⑧</b></font></td>
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
					<td style="border-right: 1px solid #8b9eba; background-color: #f3f6fd;">&nbsp;<a href="javascript:q_static(<%=id_exam%>);"><%=scoreQ[q].getTitle()%></a></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getO_rate()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getAll_sum()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getO_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getX_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx1_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx2_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx3_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx4_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx5_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx6_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx7_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx8_cnt()%></td>
				</tr>
	<%
			}
		}
	%>	
		</table>

<BR><BR><BR>
		<table border="1" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" width="100%" style="background-color: #FCFCFC; border-top: 2px solid #8b9eba; border-bottom: 2px solid #8b9eba; border-right: 2px solid #8b9eba; border-left: 2px solid #8b9eba;">
			<tr>
				<td><iframe src="q_static_graph.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>" frameborder="0" name="q_view" width="800" height="270"  marginwidth="0" marginheight="0" scrolling="auto"></iframe></td>
			</tr>
		</table>
</TD>
			<TD style="background-image: url(../../../images/yj_q_static_rightbg2.gif); background-repeat: repeat-y; width: 28px;"></TD>
		</TR>

<TR style="height: 25px; background-color: #ffffff;">
			<TD width="28"><img src="../../../images/yj_q_static_leftbg3.gif"></TD>
			<TD style="background-image: url(../../../images/yj_q_static_bottom.gif); background-repeat: repeat-x; width:100%; height:25px; padding-top: 0px;"></TD>
			<TD width="28"><img src="../../../images/yj_q_static_rightbg3.gif"></TD>
		</TR>
		
</TABLE>

</body>
</html>