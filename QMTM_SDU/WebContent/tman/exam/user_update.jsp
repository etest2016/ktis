<%
//******************************************************************************
//   ���α׷� : user_update.jsp
//   �� �� �� : ���� ����
//   ��    �� : ���� ����
//   �� �� �� : exam_m
//   �ڹ����� : qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamCreateBean
//   �� �� �� : 2010-06-10
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
			
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String home_addr1 = request.getParameter("home_addr1");
	String home_addr2 = request.getParameter("home_addr2");
	String home_phone = request.getParameter("home_phone");
	String mobile_phone = request.getParameter("mobile_phone");
	String sosok1 = request.getParameter("sosok1");
	String sosok2 = request.getParameter("sosok2");
	String sosok3 = request.getParameter("sosok3");
	String sosok4 = request.getParameter("sosok4");
	String jikwi = request.getParameter("jikwi");
	String jikmu = request.getParameter("jikmu");
	String company = request.getParameter("company");

	UserInfoBean bean = new UserInfoBean();

	bean.setPassword(password);
	bean.setName(name);
	bean.setEmail(email);	
	bean.setHome_addr1(home_addr1);	
	bean.setHome_addr2(home_addr2);	
	bean.setHome_phone(home_phone);		
	bean.setMobile_phone(mobile_phone);
	bean.setSosok1(sosok1);
	bean.setSosok2(sosok2);
	bean.setSosok3(sosok3);
	bean.setSosok4(sosok4);
	bean.setJikwi(jikwi);
	bean.setJikmu(jikmu);
	bean.setCompany(company);
	
    // ���� ���
	try {
	    UserInfo.update(bean, userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">		
	alert("���������� ������ �����Ǿ����ϴ�.");
	opener.location.reload(); 
	window.close();
</script>