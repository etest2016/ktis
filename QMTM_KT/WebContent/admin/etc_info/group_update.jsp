<%
//******************************************************************************
//   프로그램 : exam_kind_update.jsp
//   모 듈 명 : 그룹구분 수정
//   설    명 : 그룹구분 수정하기
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
<%@ page import="qmtm.ComLib, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_category = request.getParameter("id_category"); // 그룹구분 코드
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	if (id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    String category = request.getParameter("category"); // 그룹구분
	
	GroupKindBean bean = new GroupKindBean();

	bean.setId_category(id_category);
	bean.setCategory(category);
	
	// 그룹구분 수정
    try {
	    GroupKindUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("정상적으로 수정되었습니다.");
	window.opener.location.reload();
	window.close();
</script>