<%
//******************************************************************************
//   프로그램 : inwon_order_lists2.jsp
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
	
	String bigos = "N";
	
	AnsInwonListBean[] rst = null;
	
	// 완료자/미완료자 가지고오기
    try {
	    rst = AnsInwonList.getOrders(id_exam, bigos, fields, orders);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<select name="inwon_lists" multiple size="33" style="width:100%;" ondblclick = "selects(this.value);" >
	<%
		if(rst == null) {
	%>
	<%
		} else {
			for(int i=0; i<rst.length; i++) { 
				String score_bak = "";
				String score_log = "";

				String nr_set = "";
				String now_score = "";
				String user_ip = "";
				String u_name = "";
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
				
				if(rst[i].getName().length() == 2) {
					u_name = rst[i].getName() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				} else if(rst[i].getName().length() == 3) {
					u_name = rst[i].getName() + "&nbsp;&nbsp;&nbsp;";
				} else if(rst[i].getName().length() > 3) {
					u_name = rst[i].getName();
				} 

				if(rst[i].getScore_bak() > -1.0) {
					score_bak = String.valueOf(rst[i].getScore_bak());
				} else {
					score_bak = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				} 

				if(!rst[i].getScore_log().equals("-1")) {
					score_log = rst[i].getScore_log();
				} else {
					score_log = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}

				if(rst[i].getNr_set() < 10) {
					nr_set = String.valueOf(rst[i].getNr_set()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				} else if(rst[i].getNr_set() >= 10 && rst[i].getNr_set() < 100) {
					nr_set = String.valueOf(rst[i].getNr_set()) + "&nbsp;&nbsp;&nbsp;";
				} else if(rst[i].getNr_set() >= 100) {
					nr_set = String.valueOf(rst[i].getNr_set());
				}
				
				if(rst[i].getScore() < 10) {
					now_score = String.valueOf(rst[i].getScore()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				} else if(rst[i].getScore() >= 10 && rst[i].getScore() < 100) {
					now_score = String.valueOf(rst[i].getScore()) + "&nbsp;&nbsp;&nbsp;&nbsp;";
				} else if(rst[i].getScore() >= 100) {
					now_score = String.valueOf(rst[i].getScore());
				}

				if(rst[i].getUser_ip() == null) {
					user_ip = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				} else {
					if(rst[i].getUser_ip().length() == 8) {
						user_ip = rst[i].getUser_ip() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					} else if(rst[i].getUser_ip().length() == 9) {
						user_ip = rst[i].getUser_ip() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					} else if(rst[i].getUser_ip().length() == 10) {
						user_ip = rst[i].getUser_ip() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					} else if(rst[i].getUser_ip().length() == 11) {
						user_ip = rst[i].getUser_ip() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					} else if(rst[i].getUser_ip().length() == 12) {
						user_ip = rst[i].getUser_ip() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					} else if(rst[i].getUser_ip().length() == 13) {
						user_ip = rst[i].getUser_ip() + "&nbsp;&nbsp;&nbsp;&nbsp;";
					} else if(rst[i].getUser_ip().length() == 14) {
						user_ip = rst[i].getUser_ip() + "&nbsp;&nbsp;";
					} else {
						user_ip = rst[i].getUser_ip();
					} 
				}
				
	%>
		<option value="<%=rst[i].getUserid()%>" >&nbsp;&nbsp;<%=u_id%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=u_name%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=nr_set%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rst[i].getStart_time()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rst[i].getEnd_time()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=user_ip%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=now_score%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=score_bak%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=score_log%></option>
	<%
			}
		}
	%>
</select>
