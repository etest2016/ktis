<%
//******************************************************************************
//   프로그램 : inwon_order_lists3.jsp
//   모 듈 명 : 응시자 정렬 리스트
//   설    명 : 응시자 정렬 리스트
//   테 이 블 : exam_ans, qt_userid
//   자바파일 : qmtm.tman.answer.AnsInwonList, qmtm.tman.answer.AnsInwonListBean
//   작 성 일 : 2008-06-20
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String fields = request.getParameter("fields");
	if (fields == null) { fields = ""; } else { fields = fields.trim(); }

	String orders = request.getParameter("orders");
	if (orders == null) { orders = ""; } else { orders = orders.trim(); }
	
	if (id_exam.length() == 0 || fields.length() == 0 || orders.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = "X";
	
	AnsInwonListBean[] rst = null;
	
	// 미응시자 가지고오기
    try {
	    rst = AnsInwonList.getOrders2(id_exam, fields, orders);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

	<select name="inwon_lists" multiple size="33" style="width:100%;" >
		<% 
			if(rst == null) {
		%>
		<%
			} else {
				for(int i=0; i<rst.length; i++) { 
					
				String u_id = "";
				
				if(rst[i].getUserid().length() == 10) {
					u_id = rst[i].getUserid() + "&nbsp;&nbsp;&nbsp;&nbsp;";
				} else if(rst[i].getUserid().length() == 11) {
					u_id = rst[i].getUserid() + "&nbsp;&nbsp;&nbsp;";
				} else if(rst[i].getUserid().length() == 12) {
					u_id = rst[i].getUserid() + "&nbsp;&nbsp;";
				} else if(rst[i].getUserid().length() == 13) {
					u_id = rst[i].getUserid() + "&nbsp;";
				} else {
					u_id = "&nbsp;&nbsp;&nbsp;&nbsp;" + rst[i].getUserid() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}
		%>
			<option value="<%=rst[i].getUserid()%>" >&nbsp;&nbsp;<%=u_id%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rst[i].getName()%></option>
		<% 		
					out.flush();
				} 
			}
		%>
	</select>