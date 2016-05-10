<%
//******************************************************************************
//   ���α׷� : module_update.jsp
//   �� �� �� : ��� �����Ϸ�
//   ��    �� : ��� �����Ϸ� ������
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
	
	String id_module = request.getParameter("id_module"); // ��� �ڵ�
	if (id_module == null) { id_module= ""; } else { id_module = id_module.trim(); }

	if (id_subject.length() == 0 || id_module.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");

    String module = request.getParameter("q_module"); // ����
	String yn_valid = request.getParameter("yn_valid"); 
	String module_order = request.getParameter("module_order"); // ���ļ���

	ModuleBean bean = new ModuleBean();

	bean.setId_chapter(id_module);
	bean.setChapter(module);
	bean.setYn_valid(yn_valid);
	bean.setChapter_order(Integer.parseInt(module_order));
	
	// ��� ����
    try {
	    ModuleUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));		

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();
	
	bigos.append("�����ڵ� : ");
	bigos.append(id_subject);

	bigos.append(", �ܿ��ڵ� : ");
	bigos.append(id_module);

	bigos.append(", �ܿ��� : ");
	bigos.append(module);
	
	bigos.append(", �������� : ");
	if(yn_valid.equals("Y")) {
		bigos.append("����");
	} else {
		bigos.append("�����");
	}

	bigos.append(", ���ļ��� : ");
	bigos.append(module_order);

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