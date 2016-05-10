<%
//******************************************************************************
//   프로그램 : q_static.jsp
//   모 듈 명 : 성적통계 관리 
//   설    명 : 성적통계 관리
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
		scoreQ = StaticQ.getQList2(Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	java.text.DecimalFormat df = new java.text.DecimalFormat(",##0.00"); 
%>
<html>
<head>
<title>문제분석</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">
	
	self.moveTo(0,0) ;
	self.resizeTo(screen.availWidth,screen.availHeight) ;

	function q_static(id_exam) {
		document.q_graph_view.location.href= "q_static_graph.jsp?id_q=<%=id_q%>&id_exam="+id_exam;
	}
</script>


	</head>
	<BODY style="font: normal 12px gulim, dotum; margin: 0px 0px 25px 0px; background-color:#fff; padding: 15px 15px 15px 15px;" id="qman">

	<div>
		<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
			<TR>
				<TD><img src="../../images/yj_q_static_top1.gif"></TD>
				<TD style="background-image: url(../../images/yj_q_static_top2.gif); background-repeat: repeat-x; width: 100%;"></TD>
				<TD><img src="../../images/yj_q_static_top3.gif"></TD>
			</TR>
		</TABLE>
	</div>

	<div>
		<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
			<TR style="background-color: #ffffff;">
				<TD valign="top"><img src="../../images/yj_q_static_leftbg1.gif"></TD>
				<TD style="background-image: url(../../images/yj_q_static_top.gif);  background-repeat: repeat-x; width:100%; padding-top: 0px;">&nbsp;&nbsp;&nbsp;</TD>
				<TD valign="top"><img src="../../images/yj_q_static_rightbg1.gif"></TD>
			</TR>		
			<TR style="background-color: #ffffff;">
				<TD style="background-image: url(../../images/yj_q_static_leftbg2.gif); background-repeat: repeat-y;"  valign="top"></TD>
				<TD width="100%" style="background-color:#fff;" valign="top">

					<table border="0" width="100%" cellpadding ="0" cellspacing="0" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt; background-color: #FCFCFC;" valign="top">
						<tr bgcolor="#FFFFFF">
							<td width="50%" valign="top">
					<BR><BR>
							<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff" width="95%" align="left">
								<tr style="height: 25px; text-align: center; background-image: url(../../images/yj_q_static_tableyj22_1.gif); background-repeat: repeat-x; font-size: 10pt;">
									<td width="40%"><font color="#24908b"><b>항목</b></font></td>
									<td align="center"><font color="#24908b"><b>정보</b></font></td>
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

					<td width="50%"><iframe src="q_static.jsp?id_q=<%=id_q%>" frameborder="0" name="q_view" width="100%" height="250"  marginwidth="0" marginheight="5" scrolling="auto"></iframe></td>
				</tr>
			</table>

<BR><BR><BR>
			<table border="0" cellpadding="1" cellspacing="0" bgcolor="#ffffff" width="100%" style="background-color: #ffffff; border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba; border-left: 1px solid #8b9eba;">
				<tr bgcolor="#FFFFFF" style="height: 27px; text-align: center; background-image: url(../../images/yj_q_static_tableyj22_1.gif); background-repeat: repeat-x; font-size: 10pt;">
					<td align="center" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>시험명</b></font></td>
					<td align="center" width="8%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>정답률</b></font></td>
					<td align="center" width="8%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>합계</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>O</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>X</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>①</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>②</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>③</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>④</b></font></td>
					<td align="center" width="5%" bgcolor="#D9D9D9" style="border-bottom: 1px solid #8b9eba; border-right: 1px solid #8b9eba;"><font color="#24908b"><b>⑤</b></font></td>
				</tr>
			<% 
				if(scoreQ == null) { 
					id_exam = "1";
			%>
				<tr bgcolor="#FFFFFF" style="text-align: center;">
					<td colspan="10" style="padding: 5px 10px 5px 12px;">&nbsp;</td>
				</tr>
			<% 
				} else {
					double o_rate_res = 0.0; 
					id_exam = scoreQ[0].getId_exam();
					for(int q=0; q<scoreQ.length; q++) {
						int all_cnt = 1;
					
						if(scoreQ[q].getAll_sum() == 0) {
							all_cnt = 1;
						} else {
							all_cnt = scoreQ[q].getAll_sum();
						}
					
						o_rate_res = (Double.parseDouble(String.valueOf(scoreQ[q].getO_cnt())) / Double.parseDouble(String.valueOf(all_cnt))) * 100;
			%>
				<tr bgcolor="#FFFFFF" height="25" style="text-align: center;">
					<td style="border-right: 1px solid #8b9eba; background-color: #f3f6fd;">&nbsp;<a href="javascript:q_static('<%=scoreQ[q].getId_exam()%>');"><%=scoreQ[q].getTitle()%></a></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=df.format(o_rate_res)%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getAll_sum()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getO_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getX_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx1_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx2_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx3_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx4_cnt()%></td>
					<td align="center" style="border-right: 1px solid #8b9eba;"><%=scoreQ[q].getEx5_cnt()%></td>
				</tr>
			<%
					}
				}	
			%>	
		</table>

<BR><BR><BR>
		<table border="1" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" width="100%" style="background-color: #FCFCFC; border-top: 2px solid #8b9eba; border-bottom: 2px solid #8b9eba; border-right: 2px solid #8b9eba; border-left: 2px solid #8b9eba;">
			<tr>
				<td><iframe src="q_static_graph.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>" frameborder="0" name="q_graph_view" width="800" height="290"  marginwidth="0" marginheight="0" scrolling="auto"></iframe></td>
			</tr>
		</table>
</TD>
			<TD style="background-image: url(../../images/yj_q_static_rightbg2.gif); background-repeat: repeat-y;"  valign="top"></TD>
		</TR>

<TR style="background-color: #ffffff;">
			<TD><img src="../../images/yj_q_static_leftbg3.gif"></TD>
			<TD style="background-image: url(../../images/yj_q_static_bottom.gif); background-repeat: repeat-x; width:100%; padding-top: 0px;"></TD>
			<TD><img src="../../images/yj_q_static_rightbg3.gif"></TD>
		</TR>
		
</TABLE>

<div style="margin-top: 20px; text-align: center;">
		<img src="../../images/user_static_yj1_1.gif" onclick="javascript:window.close();" onfocus="this.blur();" style="cursor: pointer;">
	</div>

</body>
</html>