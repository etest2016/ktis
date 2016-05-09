<%
//******************************************************************************
//   프로그램 : q_list2.jsp
//   모 듈 명 : 성적통계 관리 
//   설    명 : 성적통계 관리
//   테 이 블 : 
//   자바파일 : qmtm.tman.statics.StaticQBean, qmtm.tman.statics.StaticQ
//   작 성 일 : 2008-06-09
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.statics.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	
%>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<%
	StaticQBean staticQ = null;

	try {
		staticQ = StaticQ.getQStaticList(id_exam, Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	StringBuffer ox_inwon = new StringBuffer();

	ox_inwon.append(staticQ.getO_cnt());
	ox_inwon.append(",");
	ox_inwon.append(staticQ.getX_cnt());

    String[] arrOx_inwon = ox_inwon.toString().split(",", -1);

	int ox_inwon_max = QmTm.getMax(arrOx_inwon);

	double ox_inwon_rate = ox_inwon_max / 4.0;

	java.text.DecimalFormat df = new java.text.DecimalFormat(",##0.0");

	double ox_inwon_g1 = ox_inwon_rate;
	double ox_inwon_g2 = ox_inwon_g1 + ox_inwon_rate;
	double ox_inwon_g3 = ox_inwon_g2 + ox_inwon_rate;
	double ox_inwon_g4 = ox_inwon_g3 + ox_inwon_rate;
	
	double ox_inwon_min1 = 0.0;
	double ox_inwon_min2 = 0.0;
	double ox_inwon_min3 = 0.0;
	double ox_inwon_min4 = 0.0;

	double ox_inwon_rate2 = 180.0 / ox_inwon_max;

	if((ox_inwon_max * 20) > 180) {
		ox_inwon_min1 = ((ox_inwon_max * 20) - 180) / 4.0;
		ox_inwon_min2 = ox_inwon_min1 + ox_inwon_min1;
		ox_inwon_min3 = ox_inwon_min2 + ox_inwon_min1;
		ox_inwon_min4 = ox_inwon_min3 + ox_inwon_min1;
	}

	StringBuffer q_inwon = new StringBuffer();

	q_inwon.append(staticQ.getEx1_cnt());
	q_inwon.append(",");
	q_inwon.append(staticQ.getEx2_cnt());
	q_inwon.append(",");
	q_inwon.append(staticQ.getEx3_cnt());
	q_inwon.append(",");
	q_inwon.append(staticQ.getEx4_cnt());
	q_inwon.append(",");
	q_inwon.append(staticQ.getEx5_cnt());
	q_inwon.append(",");
	q_inwon.append(staticQ.getEx6_cnt());
	q_inwon.append(",");
	q_inwon.append(staticQ.getEx7_cnt());
	q_inwon.append(",");
	q_inwon.append(staticQ.getEx8_cnt());

	String[] arrQ_inwon = q_inwon.toString().split(",", -1);

	int q_inwon_max = QmTm.getMax(arrQ_inwon);

	double q_inwon_rate = q_inwon_max / 4.0;

	double q_inwon_g1 = q_inwon_rate;
	double q_inwon_g2 = q_inwon_g1 + q_inwon_rate;
	double q_inwon_g3 = q_inwon_g2 + q_inwon_rate;
	double q_inwon_g4 = q_inwon_g3 + q_inwon_rate;

	double q_inwon_min1 = 0.0;
	double q_inwon_min2 = 0.0;
	double q_inwon_min3 = 0.0;
	double q_inwon_min4 = 0.0;

	double q_inwon_rate2 = 180.0 / q_inwon_max;

	if((q_inwon_max * 20) > 180) {
		q_inwon_min1 = ((q_inwon_max * 20) - 180) / 4.0;
		q_inwon_min2 = q_inwon_min1 + q_inwon_min1;
		q_inwon_min3 = q_inwon_min2 + q_inwon_min1;
		q_inwon_min4 = q_inwon_min3 + q_inwon_min1;
	}
%>

	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="100%">
		<tr align="center">
			<td width="5%"></td>
			<td width="25%">정답,오답 - [<%=id_q%>]</td>
			<td width="7%"></td>
			<td>보기 - [<%=id_q%>]</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="5%"></td>
			<td width="25%" align="center">
			<table border="0"  width="100%" align="center" width="200">
					<tr bgcolor="#ffffff">
						<td style="border-right:1px solid #86d2f6;" height="204" valign="bottom">
							<div style="position:relative;">
						    <span style="position:absolute;bottom:<%=(ox_inwon_g4 * 20) - ox_inwon_min4%>px;right:5px;"><%=(int)ox_inwon_g4%></span>
							<span style="position:absolute;bottom:<%=(ox_inwon_g3 * 20) - ox_inwon_min3%>px;right:5px;"><%=(int)ox_inwon_g3%></span>
							<span style="position:absolute;bottom:<%=(ox_inwon_g2 * 20) - ox_inwon_min2%>px;right:5px;"><%=(int)ox_inwon_g2%></span>
							<span style="position:absolute;bottom:<%=(ox_inwon_g1 * 20) - ox_inwon_min1%>px;right:5px;"><%=(int)ox_inwon_g1%></span>
							<span style="position:absolute;bottom:0;right:5px;">0</span>
							</div>
						</td>

						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff;">
							<!-- 최대 height는 200px입니다 -->
							<div style="background-color:#eae263;width:30px;height:<%=staticQ.getO_cnt() * ox_inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:10px;"><%=staticQ.getO_cnt()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff;">	
							<div style="background-color:#eae263;width:30px;height:<%=staticQ.getX_cnt() * ox_inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:10px;"><%=staticQ.getX_cnt()%></span></div>
						</td>											
					</tr>
					<tr bgcolor="#ffffff" align="center">
						<td></td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">O</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">X</td>
					</tr>
				</table>
			</td>
			<td width="7%"></td>
			<td align="center">
				<table border="0"  width="100%" align="center" width="200">
					<tr bgcolor="#ffffff">
						<td style="border-right:1px solid #86d2f6;" height="204" valign="bottom">
							<div style="position:relative;">
						    <span style="position:absolute;bottom:<%=(q_inwon_g4 * 20) - q_inwon_min4%>px;right:5px;"><%=(int)q_inwon_g4%></span>
							<span style="position:absolute;bottom:<%=(q_inwon_g3 * 20) - q_inwon_min3%>px;right:5px;"><%=(int)q_inwon_g3%></span>
							<span style="position:absolute;bottom:<%=(q_inwon_g2 * 20) - q_inwon_min2%>px;right:5px;"><%=(int)q_inwon_g2%></span>
							<span style="position:absolute;bottom:<%=(q_inwon_g1 * 20) - q_inwon_min1%>px;right:5px;"><%=(int)q_inwon_g1%></span>
							<span style="position:absolute;bottom:0;right:5px;">0</span>
							</div>
						</td>

						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff;">
							<!-- 최대 height는 200px입니다 -->
							<div style="background-color:#ea7663;width:30px;height:<%=staticQ.getEx1_cnt() * q_inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:10px;"><%=staticQ.getEx1_cnt()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff;">	
							<div style="background-color:#ea7663;width:30px;height:<%=staticQ.getEx2_cnt() * q_inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:10px;"><%=staticQ.getEx2_cnt()%></span></div>
						</td>											
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff;">	
							<div style="background-color:#ea7663;width:30px;height:<%=staticQ.getEx3_cnt() * q_inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:10px;"><%=staticQ.getEx3_cnt()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff;">	
							<div style="background-color:#ea7663;width:30px;height:<%=staticQ.getEx4_cnt() * q_inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:10px;"><%=staticQ.getEx4_cnt()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff;">	
							<div style="background-color:#ea7663;width:30px;height:<%=staticQ.getEx5_cnt() * q_inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:10px;"><%=staticQ.getEx5_cnt()%></span></div>
						</td>
					</tr>
					<tr bgcolor="#ffffff" align="center">
						<td></td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">①</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">②</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">③</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">④</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">⑤</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>