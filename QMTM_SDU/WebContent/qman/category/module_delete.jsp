<%
//******************************************************************************
//   ���α׷� : module_delete.jsp
//   �� �� �� : ��� ����
//   ��    �� : ��� �����ϱ�
//   �� �� �� : q_chapter
//   �ڹ����� : qmtm.ComLib, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	String id_module = request.getParameter("id_module");
	if (id_module == null) { id_module= ""; } else { id_module = id_module.trim(); }

	if (id_subject.length() == 0 || id_module.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");

	// ��ϵ� ������ �ִ��� Ȯ�� �� ���� ���� �� ����.
	int cnts = 0;

	try {
		cnts = ModuleUtil.getCnt(id_module);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	if(cnts > 0) {
%>
		<script language="javascript">
			alert("��ϵǾ��� ������ �־ ������ �� �����ϴ�.\n\n���� ���� �� �����Ͻñ� �ٶ��ϴ�.");
			window.close();
		</script>
<%
		if(true) return;
	} else {
	
		// ��� ���� ����
		try {
			ModuleUtil.delete(id_module);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		StringBuffer bigos = new StringBuffer();
	
		bigos.append("�����ڵ� : ");
		bigos.append(id_subject);

		bigos.append(", �ܿ��ڵ� : ");
		bigos.append(id_module);
		
		// �α����� ��� ����
		WorkQLogBean logbean = new WorkQLogBean();

		logbean.setId_subject(id_subject);
		logbean.setId_chapter(id_module);
		logbean.setId_chapter2("-1");
		logbean.setId_chapter3("-1");
		logbean.setId_chapter4("-1");
		logbean.setUserid(userid);
		logbean.setGubun("�ܿ�����");
		logbean.setId_q("");
		logbean.setBigo(bigos.toString());

		try {
			WorkQLog.insert(logbean);
		} catch(Exception ex) {
			out.println(ex.getMessage());

			if(true) return;
		}
		// �α����� ��� ����
%>
		<script language="javascript">
			alert("���������� �����Ǿ����ϴ�.");
			opener.parent.fraLeft.location.reload(); 
			opener.parent.fraMain.location.reload(); 
			window.close();
		</script>
<%
	}
%>