<%
//******************************************************************************
//   프로그램 : subject_view.jsp
//   모 듈 명 : 과목확인
//   설    명 : 문제은행 과목확인 팝업 페이지
//   테 이 블 : q_subject
//   자바파일 : qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree
//   작 성 일 : 2008-04-03
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);       
	request.setCharacterEncoding("EUC-KR");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject= ""; } else { id_q_subject = id_q_subject.trim(); }

	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));
	
		if(true) return ;
	}
	
	// 과목정보 가지고오기
	QmanTreeBean rst = null;

    try {
	    rst = QmanTree.getBean(id_q_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	String yn_valid = "";
	if(rst.getYn_valid().equalsIgnoreCase("Y")) {
		yn_valid = "공개";
	} else {
		yn_valid = "비공개";
	}
%>
<html>
<head>
<title></title>
<script language="javascript">
	function sub_edit() {
		location.href="subject_edit.jsp?id_q_subject=<%=id_q_subject%>";
	}
	
	//--  과목 삭제체크
    function sub_delete()  {
       var st = confirm("*주의* 과목정보를 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "subject_delete.jsp?id_q_subject=<%=id_q_subject%>";
       }
    }
</script>

</head>

<BODY id="admin">
<table border="0" width="300" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC" style="width: 100%; margin-bottom: 20px; margin-top: 30px; border-top: 2px; solid #ffffff; font-size: 9pt;">
	<tr height="30" style="height: 30px; text-align: center; background-image: url(../../../images/tableyj_top2.gif); background-repeat: repeat-x; font-size: 10pt;">
		<td colspan="2" width="30%" align="center">과목확인</td>
	</tr>

	<tr height="30">
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d;">과목명&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-bottom: 1px solid #a9da6d;">&nbsp;&nbsp;<%=rst.getQ_subject()%></td>
	</tr>
	<tr height="30">
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d;">공개여부&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-bottom: 1px solid #a9da6d;">&nbsp;&nbsp;<%=yn_valid%></td>
	</tr>
	<tr height="30">
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d;">등록일자&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-bottom: 1px solid #a9da6d;">&nbsp;&nbsp;<%=rst.getRegdate()%></td>
	</tr>
</table>

<p>
<center>
<!--<input type="button" value="수정하기" onClick="sub_edit();">--><a href="javascript:sub_edit();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="삭제하기" onClick="sub_delete();">--><a href="javascript:sub_delete();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>
</center>

</body>
</html>