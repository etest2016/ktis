<%
//******************************************************************************
//   프로그램 : course_delete.jsp
//   모 듈 명 : 과정 삭제
//   설    명 : 과정삭제하기
//   테 이 블 : c_course
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CourseKindUtil
//   작 성 일 : 2013-02-06
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.etc.CourseKindUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// 하위과목 유무 체크
	boolean down_YN = false;

	try {
	    down_YN = CourseKindUtil.getDownCnt(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
	
	if(down_YN) {	

    // 과정정보 삭제	
	try {
	    CourseKindUtil.delete(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("과정코드 : ");
	bigos.append(id_course);
	
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("과정정보삭제");
	logbean.setBigo(bigos.toString());

	try {
		WorkAdminLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
%>

<script language="javascript">
	alert("과정이 정상적으로 삭제되었습니다.");	
	window.opener.location.reload();
	window.close();
</script>

<%
	} else {
%>
<script language="javascript">
	alert("하위에 과목이 있어서 삭제할 수 없습니다. \n\n하위 과목을 삭제 후 진행해 주시기 바랍니다.");	
	window.close();
</script>
<%
	}
%>