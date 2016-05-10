<%
//******************************************************************************
//   프로그램 : subject_delete.jsp
//   모 듈 명 : 강좌 삭제
//   설    명 : 시험관리 강좌 삭제하기
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil,
//              qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog
//   작 성 일 : 2013-02-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil, qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course"); // 과정 ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // 과목 ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String bigo = request.getParameter("bigo"); 

    // 하위시험 유무 체크 
	boolean down_YN = false;

	try {
	    down_YN = SubjectTmanUtil.getDownCnt2(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
	
	if(down_YN) {
	
		// 강좌정보 삭제
		try {
			SubjectTmanUtil.delete(id_course, id_subject);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "close"));

		    if(true) return;
	    }

		StringBuffer bigos = new StringBuffer();

		bigos.append("과정코드 : ");
		bigos.append(id_course);
		bigos.append(", 강좌코드 : ");
		bigos.append(id_subject);
		
		WorkExamLogBean logbean = new WorkExamLogBean();

		logbean.setId_exam("강좌삭제");	
		logbean.setUserid(userid);
		logbean.setGubun("강좌삭제");
		logbean.setId_q("");
		logbean.setBigo(bigos.toString());

		try {
			WorkExamLog.insert(logbean);
		} catch(Exception ex) {
			out.println(ex.getMessage());

			if(true) return;
		}
%>

<script language="javascript">	
	alert("정상적으로 삭제되었습니다.");
	opener.parent.fraLeft.location.reload(); 	
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>

<%
		if(true) return;
	} else {
%>
<script language="javascript">
	alert("하위에 시험이 있어서 삭제할 수 없습니다. \n\n하위 시험을 삭제 후 진행해 주시기 바랍니다.");	
	window.close();
</script>
<%
		if(true) return;
	}
%>