<%
//******************************************************************************
//   ���α׷� : course_update.jsp
//   �� �� �� : ���� ����
//   ��    �� : ���������ϱ�
//   �� �� �� : c_course
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CourseKindUtil, qmtm.admin.etc.CourseKindBean
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.etc.CourseKindUtil, qmtm.admin.etc.CourseKindBean" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	String id_midcategory = request.getParameter("id_midcategory");
	if (id_midcategory == null) { id_midcategory = ""; } else { id_midcategory = id_midcategory.trim(); }
	
	if (id_course.length() == 0 || id_midcategory.length() == 0) {
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

	String course = request.getParameter("course");
    String yn_valid = request.getParameter("yn_valid");
	String orders = request.getParameter("orders");

    CourseKindBean bean = new CourseKindBean();

	bean.setId_midcategory(id_midcategory);
	bean.setCourse(course);
	bean.setYn_valid(yn_valid);
	bean.setOrders(Integer.parseInt(orders));

    // ��������
	try {
	    CourseKindUtil.update(bean, id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("�ҿ����ڵ� : ");
	bigos.append(id_midcategory);
	bigos.append(", �����ڵ� : ");
	bigos.append(id_course);
	bigos.append(", ������ : ");
	bigos.append(course);
	bigos.append(", ���ļ��� : ");
	bigos.append(orders);
	bigos.append(", �������� : ");
	bigos.append(yn_valid);
		
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