<%
//******************************************************************************
//   ���α׷� : course_delete.jsp
//   �� �� �� : ���� ����
//   ��    �� : ���������ϱ�
//   �� �� �� : c_course
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CourseKindUtil
//   �� �� �� : 2013-02-06
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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

	// �������� ���� üũ
	boolean down_YN = false;

	try {
	    down_YN = CourseKindUtil.getDownCnt(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
	
	if(down_YN) {	

    // �������� ����	
	try {
	    CourseKindUtil.delete(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("�����ڵ� : ");
	bigos.append(id_course);
	
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("������������");
	logbean.setBigo(bigos.toString());

	try {
		WorkAdminLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
%>

<script language="javascript">
	alert("������ ���������� �����Ǿ����ϴ�.");	
	window.opener.location.reload();
	window.close();
</script>

<%
	} else {
%>
<script language="javascript">
	alert("������ ������ �־ ������ �� �����ϴ�. \n\n���� ������ ���� �� ������ �ֽñ� �ٶ��ϴ�.");	
	window.close();
</script>
<%
	}
%>