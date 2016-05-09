<%
//******************************************************************************
//   프로그램 : exam_kind_view.jsp
//   모 듈 명 : 그룹구분확인
//   설    명 : 그룹구분확인 팝업 페이지
//   테 이 블 : r_exam_kind
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil
//   작 성 일 : 2010-06-08
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

	String id_exam_kind = request.getParameter("id_exam_kind");
	if (id_exam_kind == null) { id_exam_kind= ""; } else { id_exam_kind = id_exam_kind.trim(); }

	if (id_exam_kind.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	ExamKindBean rst = null;

    try {
	    rst = ExamKindUtil.getBean(id_exam_kind);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="exam_kind_edit.jsp?id_exam_kind=<%=id_exam_kind%>";
	}
	
	//--  삭제체크
    function deletes()  {
       var st = confirm("*주의* 그룹구분를 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "exam_kind_delete.jsp?id_exam_kind=<%=id_exam_kind%>";
       }
    }
</script>
<html>
<head>
	<title>:: 그룹구분 확인 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">그룹구분 확인 <span> 그룹구분 확인 및 수정,삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">코드</td>
				<td width="200"><%=id_exam_kind%></td>
			</tr>
			<tr>
				<td id="left">그룹구분</td>
				<td><%=rst.getExam_kind()%></td>
			</tr>
			<tr>
				<td id="left">설명</td>
				<td><textarea name="rmk" rows="3" cols="25" readonly><%=ComLib.nullChk(rst.getRmk())%></textarea></td>
			</tr>
	</table>
</div>

<div id="button">
<!--<input type="button" onClick="edits()" value="수정하기">--><a href="javascript:edits();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onClick="deletes()"  value="삭제하기">--><a href="javascript:deletes();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onclick="window.close()" value="창닫기">--><a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>