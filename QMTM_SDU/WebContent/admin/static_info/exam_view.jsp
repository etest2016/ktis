<%
//******************************************************************************
//   프로그램 : paper_option.jsp
//   모 듈 명 : 시험출제옵션 정보
//   설    명 : 시험출제옵션 정보
//   테 이 블 : exam_m, q_chapter
//   자바파일 : qmtm.tman.exam.ExamPaperGuide, ExamPaperGuideBean
//   작 성 일 : 2008-05-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		window.close();
	</script>
<%	
	}

	IngInwonBean rst = null;

	try {
		rst = IngInwon.getInwonRe(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));		    

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> 시험 정보 확인 </TITLE>

 <link rel="StyleSheet" href="../../css/style.css" type="text/css">

 </HEAD>

<BODY id="popup2">
   
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험 정보 확인</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		
		<div class="subtitle">시험 설정 정보</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="20%"><li>시험명</td>
				<td width="37%"><%=rst.getTitle()%></td>
				<td id="left" width="23%"><li>시험코드</td>
				<td width="20%"><%=rst.getId_exam()%></td>
			</tr>
			<tr>
				<td id="left"><li>전체 문제수</td>
				<td><%=rst.getQcount()%> 문제</td>
				<td id="left"><li>시험지갯수</td>
				<td><%=rst.getSetcount()%> 개</td>
			</tr>
			<tr>
				<td id="left"><li>총점</td>
				<td><%=rst.getAllotting()%> 점</td>
				<td id="left"><li>제한시간</td>
				<td><%=rst.getLimittime()/60%> 분</td>
			</tr>
			<tr>
				<td id="left"><li>시험구분</td>
				<td colspan="3">&nbsp;<% if(rst.getId_exam_kind() == 1) { %>일반평가 전용<% } else if(rst.getId_exam_kind() ==2) { %>스마트폰평가 전용<% } else { %>일반&스마트폰평가 혼용<% } %></td>
			</tr>

		</table>
			
		<br>

		<div class="subtitle">응시 현황</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%">
			<tr id="tr">
				<td width='20%'>대상인원</td>
				<td width='20%'>응시인원</td>
				<td width='20%'>미응시인원</td>
				<td width='20%'>답안완료</td>
				<td width='20%'>답안미완료</td>
			</tr>
			<% 
				if(rst == null) {
			%>
			<tr height="45">
				<td class="blank" colspan="5">응시현황 내역이 없습니다.</td>
			</tr>
			<%
				} else {
			%>
			<tr id="td" align="center">
				<td><%=rst.getTot_inwon()%> 명</td>
				<td><%=rst.getAns_inwon()%> 명</td>
				<td><%=rst.getNo_inwon()%> 명</td>
				<td><%=rst.getAns_y_inwon()%> 명</td>
				<td><%=rst.getAns_n_inwon()%> 명</td>
			</tr>
			<% 
				}
			%>
		</table>
			
	</div>

	<div id="button">
		<img src="../../images/bt5_exit_yj1_11.gif" onclick="javascript:window.close();" onfocus="this.blur();" style="cursor: pointer;">
	</div>

	</form>

</BODY>
</HTML>