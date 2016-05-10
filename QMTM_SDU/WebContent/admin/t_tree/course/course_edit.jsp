<%
//******************************************************************************
//   프로그램 : course_edit.jsp
//   모 듈 명 : 과정 수정
//   설    명 : 과정수정하기
//   테 이 블 : c_course
//   자바파일 : qmtm.admin.TmanTree
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.TmanTree, qmtm.admin.TmanTreeBean, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil " %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	if (id_course.length() == 0 || id_category.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    // 과정정보 가지고오기
	TmanTreeBean rst = null;

    try {
	    rst = TmanTree.getBean(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	// 그룹구분목록 가지고오기
	GroupKindBean[] rst2 = null;

	try {
		rst2 = GroupKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>
<HTML>
<HEAD>
<TITLE> 과정정보 수정 </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">

<script language="javascript">
  	function sends() {
  		if(document.frmdata.course.value.replace(/\s/g, "")=="") {
  			alert("과정명을 입력하세요.");
  			document.frmdata.course.focus();
  			return;
  		} else {
  			document.frmdata.submit();
  		}
  	}   
  </script>
  
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="course_update.jsp">
<input type="hidden" name="id_course" value="<%=id_course%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">과정정보 수정 <span>과정명 및 공개유무 수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">분야선택</td>
				<td><Select name="id_category">
				<% if(rst2 == null) { %>
					<option value="">분야없음</option>
				<%
					} else {
						for(int i=0; i<rst2.length; i++) {
				%>
						<option value="<%=rst2[i].getId_category()%>" <%if(id_category.equals(rst2[i].getId_category())) { %>selected<% } %>><%=rst2[i].getCategory()%></option>
				<%
						}
					}
				%>
				</select></td>
			</tr>
			<tr>
				<td id="left">과정명</td>
				<td><input type="text" class="input" name="course" size="30" value="<%=rst.getCourse()%>"></td>
			</tr>
			<tr>
				<td id="left">공개유무</td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> 공개&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> 비공개</td>
			</tr>
	</table>
	</div>


	<div id="button">
<img onclick="sends()" src="../../../images/bt5_sjedit_yj1.gif" style="cursor:pointer">&nbsp;&nbsp;<img onClick="window.close();" border="0" src="../../../images/bt5_exit_yj1.gif" style="cursor:pointer">
</div>

	</form>

</BODY>
</HTML>