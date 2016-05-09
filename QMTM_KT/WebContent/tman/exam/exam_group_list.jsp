<%
//******************************************************************************
//   프로 그램 : exam_group_list.jsp
//   모  듈  명 : 시험 일괄 관리
//   설       명 : 시험 일괄 관리
//   테  이  블 : exam_m
//   자바 파일 : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   작  성  일 : 2008-06-15
//   작  성  자 : 이테스트 석준호
//   수  정  일 : 
//   수  정  자 : 
//	  수정 사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	
	
	if (id_course.length() == 0 || id_subject.length() ==0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	

    // 과목 아래 시험정보 가지고오기
	ExamListBean[] rst = null;

    try {
	    rst = ExamList.getGrpBeans(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }	
%>

<HTML>
 <HEAD>
  <TITLE> :: 시험 일괄 설정 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function exam_copy() {

		var str = confirm("체크한 시험에 대해서 일괄복사 작업을 진행하시겠습니까?");

		if(str == true) {
			document.form1.submit();
		}
    }

 </script>

</HEAD>

<BODY id="popup2">

	<form name="form1" method="post" action="exam_copy_ok.jsp">
	<input type="hidden" name="id_course" value="<%=id_course%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험 일괄 설정<span>일괄시험 셋팅을 진행합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="5%">선택</td>
				<td >시험제목</td>
				<!--<td width="8%">시험구분</td>-->
				<td width="8%">가능여부</td>
				<td width="20%">입장시간일자</td>
				<td width="20%">시험시간일자</td>				
				<td width="20%">성적조회일자</td>

			</tr>
		</table>
		
		<div style="overflow: auto; width:100%; height:260px; margin-top: 0px;">

			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="7">복사할 시험이 없습니다.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {
				%>
				<tr id="td" align="center">
					<td><input type="checkbox" name="id_exams" value="<%=rst[i].getId_exam()%>"></td>
					<td align="left">&nbsp;<%=rst[i].getTitle()%></td>
					<td><%=rst[i].getYn_enable()%></td>
					<td><%=rst[i].getLogin_start()%>~<%=rst[i].getLogin_end()%></td>
					<td><%=rst[i].getExam_start1()%>~<%=rst[i].getExam_end1()%></td>
					<td><%=rst[i].getStat_start()%>~<%=rst[i].getStat_end()%></td>
				</tr>
				<%
						}
					}
				%>
			</table>
			
		</div>

	</div>
	<div id="button">
		<a href="javascript:exam_copy();"><img src="../../images/bt_subj_list_2.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>