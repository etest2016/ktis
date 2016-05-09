<%
//******************************************************************************
//   프로그램 : exam_kind_delete.jsp
//   모 듈 명 : 그룹구분 삭제
//   설    명 : 그룹구분 삭제하기
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

    String param_exam_kind = request.getParameter("id_exam_kind"); // 그룹구분 코드
	if (param_exam_kind == null) { param_exam_kind= ""; } else { param_exam_kind = param_exam_kind.trim(); }

	if (param_exam_kind.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	int id_exam_kind = Integer.parseInt(param_exam_kind);

	// 그룹구분 정보 삭제
	try {
		ExamKindUtil.delete(id_exam_kind);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script type="text/javascript">
	alert("정상적으로 삭제되었습니다.");
	window.opener.location.reload();
	window.close();
</script>