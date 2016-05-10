<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_q.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	//����¡ ó��
	String sPg = request.getParameter("Page");
	if (sPg == null || sPg == "" || sPg == "0") {
		sPg = "1";
	}
	int iPage = Integer.parseInt(sPg);

	int TotRecord = 0;
	int TotPage = 0;
	int pgSize = 15;
	int segment = 0;

	String k_equal_value = request.getParameter("k_equal_value");
	if (k_equal_value == null || k_equal_value.equals("")) { k_equal_value= ""; } else { k_equal_value = k_equal_value.trim(); }



	Score_EquallistBean3 mBean = null;

	try {
		mBean = Score_Equallist.getQ(id_exam, Integer.parseInt(id_q));
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());

		if(true) return;
	}

	double allotting = mBean.getAllotting();
	String q = mBean.getQ();

	q = q.replace("<BR>", "");
	q = q.replace("</BR>", "");
	q = q.replace("<P>", "");
	q = q.replace("</P>", "");



	try {
		TotRecord = Score_Equallist.getResultCount(id_exam, Integer.parseInt(id_q), "N");
		segment = TotRecord % pgSize;
		if (segment > 0) {
			TotPage = (TotRecord - segment) / pgSize + 1;
		} else {
			TotPage = TotRecord / pgSize;
		}
	} catch(Exception ex) {
		out.println("getCount" + ex.getMessage());
		if(true) return;
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
	}


	Score_EqualResultBean[] rst = null;

	try {
		rst = Score_Equallist.getResult(id_exam, Integer.parseInt(id_q), "N", iPage, pgSize);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());

		if(true) return;
	}
%>


<html>
<head>
<title>��� ��� ������</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
<script language="JavaScript">
	function equal_ans_comp(userid, kwd_rate) {
		var equalansComp;
		equalansComp = $.posterPopup("exam_ans_non_frm.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+userid+"&kwd_rate="+kwd_rate, "compwin", "menubar=no, scrollbars=yes, width=1000, height=700, left=0, top=0");
		equalansComp.focus();
	}

	function search_equal_value() {
		var frm = document.forms1;
		if(frm.k_equal_value.value == "") {
			alert("����� �˻����� �Է��ϼ���.");
			frm.k_equal_value.focus();
			return;			
		} else if (frm.k_equal_value.value > "100" && frm.k_equal_value.value < "70") {
			alert("����� �˻������� 70 ~ 100% �����Դϴ�.\n\n70 ~ 100% ���� ���� �Է��ϼ���.");
			frm.k_equal_value.value = "";
			frm.k_equal_value.focus();
			return;
		} else {
			frm.submit();
		}
	}
</script>
</head>

<BODY Style="margin:0px;">

	<!-- Ÿ��Ʋ ������ -->
	<div style="width: 100%; height: 70px; background-image: url(../images/bg_mark_top.gif); text-align: right;"><img src="../images/bt_re.gif" onclick="location.href='ans_equal_result.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>';" style="cursor: pointer;"><img src="../images/bt_out.gif" style="cursor: pointer;" onclick="javascript:window.close();"></div>
	<!-- �ܴ��� ���� ��ä�� -->
	<div style="width: 100%; margin: 0px 30px 10px 30px;">
		<!--img src="../images/title_ad_webscore4.gif"-->
	</div>
	

	<table border="0" width="100%" cellpadding="5">
		<tr>
			<td align="center" style="padding-left: 30px; padding-right: 30px;">

				<div class="title">����� ���� ����</div>
				
				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="TableD">
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>������ȣ</B></td>  
						<td bgcolor="#FFFFFF">&nbsp;<%=id_q%></td>
						<td width="15%" align="center" id="left"><B>����</B></td> 
						<td bgcolor="#FFFFFF">&nbsp;<%=allotting%> ��</td>	
					</tr>
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>����</B></td>  
						<td height="30" bgcolor="#FFFFFF" colspan="3">&nbsp;<%=q%></td>
					</tr>
				</table>

				<hr size="1" width="90%" bgcolor="#FFFFFF">
				
				<div class="title">����� �� ��� ����Ʈ</div>

				<table border='0' width='100%'>
					<tr>
						<form name="forms1" method="post" action="ans_equal_result.jsp">
						<input type = "hidden" name = "id_exam" value="<%=id_exam%>">
						<input type = "hidden" name = "id_q" value="<%=id_q%>">
						
						<td align="left">
							
							<div style="float: left; padding-top: 3px;">
							�� <font color='red'><b><%=TotRecord%></b></font> ��
							</div>
							<div style="float: left;">&nbsp;&nbsp;&nbsp;<a href="ans_equal_result2.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>"><img src="../images/bt8_e.gif"></a>
							</div>
						</td>	
						<td align="right">
							<div style="float: right;"><img src="../images/bt3_search.gif" style="cursor: pointer;" onClick="search_equal_value();"><!--input type="button" value="�˻��ϱ�"-->
							</div>
							<div style="float: right;">
							<B> ����� �˻� : <input type="text" name="k_equal_value" size="3" value="<%=k_equal_value%>">&nbsp;% ��,&nbsp;</B>
							</div>
							<% if(k_equal_value != "") { %>
								<div style="float: right; margin-top: 6px;">
								<a href="ans_equal_result.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>">[��ü����Ʈ�� �̵�]</a>&nbsp;&nbsp;
								</div>
							<% } %>
							
							
							
						</td>
						</form>
					</tr>
				</table>

				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="TableD">
				  <tr align="center" bgcolor='#95DB95' height="30" id="tr">    	
					<td width="7%"><B>NO</B></td>
					<td width="15%"><B>������</B></td>
					<td width="20%"><B>�������ð�</B></td>
					<td width="15%"><B>��ȱ���</B></td>
					<% if (k_equal_value.equals("")) { %>
					<td width="15%"><B>[ 90 % �̻� ]</B></td>    
					<td width="15%"><B>[ 80 % �̻� ]</B></td>    
					<td width="15%"><B>[ 70 % �̻� ]</B></td>    
					<% } else { %>
					<td colspan><B>[ <%=k_equal_value%> % ] �̻�</B></td>    	
					<% } %>
					
				  </tr>

				<%
					if (rst == null) {
				%>

				  <tr bgcolor="#FFFFFF">
					<td colspan="7" align="center" class="blank">������ ����Ÿ�� �����ϴ�.</td>
				  </tr>	

				<%
					} else {
						int i = 0;
						int j = 0;
						int newno = TotRecord;
						newno = newno - (pgSize * (iPage-1));

						for(i=0; i<rst.length; i++) {
							String[] o_t_comp_rate2 = rst[i].getO_t_res_rate().split(QmTm.OR_GUBUN_re, -1);
							String[] t_o_comp_rate2 = rst[i].getT_o_res_rate().split(QmTm.OR_GUBUN_re, -1);
							
							String cho_userid100 = "";
							String cho_userid90 = "";
							String cho_userid80 = "";
							String cho_userid2_100 = "";
							String cho_userid2_90 = "";
							String cho_userid2_80 = "";

							String cho_userid_Res1 = "";
							String cho_userid_Res2 = "";
							String cho_userid_Res3 = "";

							String cho_userid_search = "";
							String cho_userid_search2 = "";

							int count100 = 0;
							int count90 = 0;
							int count80 = 0;
							int count_search = 0;
							int ans_len = 0;
							
							if (k_equal_value.equals("")) {
								for(j=0; j<o_t_comp_rate2.length; j++) {
									if (Double.parseDouble(o_t_comp_rate2[j]) >= 90) {
										cho_userid100 = cho_userid100 + Integer.toString(j) + "{^}";
									} else if(Double.parseDouble(o_t_comp_rate2[j]) >= 80) {
										cho_userid90 = cho_userid90 + Integer.toString(j) + "{^}";
									} else if(Double.parseDouble(o_t_comp_rate2[j]) >= 70) {
										cho_userid80 = cho_userid80 + Integer.toString(j) + "{^}";
									}
								}

								for(j=0; j<t_o_comp_rate2.length; j++) {
									if (Double.parseDouble(t_o_comp_rate2[j]) >= 90) {
										cho_userid2_100 = cho_userid2_100 + Integer.toString(j) + "{^}";
									} else if(Double.parseDouble(t_o_comp_rate2[j]) >= 80) {
										cho_userid2_90 = cho_userid2_90 + Integer.toString(j) + "{^}";
									} else if(Double.parseDouble(t_o_comp_rate2[j]) >= 70) {
										cho_userid2_80 = cho_userid2_80 + Integer.toString(j) + "{^}";
									}
								}
								
								cho_userid_Res1 = cho_userid100 + cho_userid2_100;
								cho_userid_Res2 = cho_userid90 + cho_userid2_90;
								cho_userid_Res3 = cho_userid80 + cho_userid2_80;

								if (cho_userid_Res1.trim() != "" && cho_userid_Res1.length() > 3) {
									cho_userid_Res1 = cho_userid_Res1.substring(0, cho_userid_Res1.length() -3);
									count100 = cho_userid_Res1.split(QmTm.LIKE_GUBUN_re, -1).length;
								}

								if (cho_userid_Res2.trim() != "" && cho_userid_Res2.length() > 3) {
									cho_userid_Res2 = cho_userid_Res2.substring(0, cho_userid_Res2.length() -3);
									count90 = cho_userid_Res2.split(QmTm.LIKE_GUBUN_re, -1).length;
								}

								if (cho_userid_Res3.trim() != "" && cho_userid_Res3.length() > 3) {
									cho_userid_Res3 = cho_userid_Res3.substring(0, cho_userid_Res3.length() -3);
									count80 = cho_userid_Res3.split(QmTm.LIKE_GUBUN_re, -1).length;
								}
							} else {
								for(j=0; j<o_t_comp_rate2.length; j++) {
									if (Double.parseDouble(o_t_comp_rate2[j]) >= Double.parseDouble(k_equal_value)) {
										cho_userid_search = cho_userid_search + Integer.toString(j) + "{^}";
									}
								}

								for(j=0; j<t_o_comp_rate2.length; j++) {
									if (Double.parseDouble(t_o_comp_rate2[j]) >= Double.parseDouble(k_equal_value)) {
										cho_userid_search2 = cho_userid_search2 + Integer.toString(j) + "{^}";
									}
								}

								String cho_userid_search_Res = "";
								cho_userid_search_Res = cho_userid_search + cho_userid_search2;

								if (cho_userid_search_Res.trim() != "" && cho_userid_search_Res.length() > 3) {
									cho_userid_search_Res = cho_userid_search_Res.substring(0, cho_userid_search_Res.length() -3);
									count_search = cho_userid_search_Res.split(QmTm.LIKE_GUBUN_re, -1).length;
								}
							}

							String userAns = rst[i].getUserans().trim();
							userAns = userAns.replace(")","");
							userAns = userAns.replace("(","");
							userAns = userAns.replace(",","");
							userAns = userAns.replace(".","");
							userAns = userAns.replace("*","");
							userAns = userAns.replace("[","");
							userAns = userAns.replace("\r\n"," ");

							ans_len = userAns.length();
				%>

				  <tr align="center" bgcolor='#FFFFFF' height="25" id="td">    
					<td ><%= newno %></td>  
					<td ><%= rst[i].getO_userid() %></td>
					<td ><%= rst[i].getEnd_time() %></td>
					<td ><%= ans_len %> Len</td>
					<% if (k_equal_value == "") { %>
					<td ><a href="javascript:" onClick="equal_ans_comp('<%= rst[i].getO_userid() %>', '90')"><%=count100%> ��</a></td>    
					<td ><a href="javascript:" onClick="equal_ans_comp('<%= rst[i].getO_userid() %>', '80')"><%=count100 + count90%> ��</a></td>    
					<td ><a href="javascript:" onClick="equal_ans_comp('<%= rst[i].getO_userid() %>', '70')"><%=count100 + count90 + count80%> ��</a></td>    
					<% } else { %>
					<td colspan="3"><a href="javascript:" onClick="equal_ans_comp('<%= rst[i].getO_userid() %>', '<%=k_equal_value%>')"><%=count_search%> ��</a></td>
					<% } %>
				  </tr>

				 
				<%
							newno = newno-1;
						}
					}
				%>

				</table>


				<!-- ����¡ ó�� �κ�... -->
				<table width="100%" cellpadding="2" cellspacing="0" border="0" style="margin-top: 10px;">
					<tr>
						<td colspan='6' height="10" align="right">
						<font color='red'><b><%= iPage %></b></font> / <b><%=TotPage%></b> page&nbsp;&nbsp;&nbsp;
						 <!-- ����¡ ó���ϴ� �κ�-->
						<%

							int GSize = 10;
							int PreGNum = (iPage - 1) / GSize;
							int EndPNum = PreGNum * GSize;
							int k = 0;
							String Tar = "";
							
							Tar = "Page=" + EndPNum;
							Tar = Tar + "&k_equal_value=" + k_equal_value;
							Tar = Tar + "&id_exam=" + id_exam;
							Tar = Tar + "&id_q=" + id_q;

							//�����׷����---------------
							//�����׷��� �ִٸ� ����Ѵ�
							if (EndPNum > 0){

						%>
							[<a href="ans_equal_result.jsp?<%=Tar%>">�� ��</a>]
						<% 
							}
							//�����׷� ��---------------

							//����׷����---------------
							//����׷��� ����Ѵ� (Gsize��ŭ)

							int LCount = GSize;
							int intI = EndPNum + 1;

							//for (int i=0; i<=TotPage; i++) {
							for (intI=EndPNum + 1; intI<=TotPage; intI++) {
								Tar = "";
								Tar = Tar + "Page=" + intI;
								Tar = Tar + "&k_equal_value=" + k_equal_value;
								Tar = Tar + "&id_exam=" + id_exam;
								Tar = Tar + "&id_q=" + id_q;
							
						%>
							[<a href="ans_equal_result.jsp?<%=Tar%>"><%=intI%></a>]
						<%
								LCount = LCount -1;
								if (LCount == 0) {
									break;
								}

							}

							//����׷� ��--------------- 

							//�����׷����---------------
							intI = EndPNum + (GSize + 1);
							
							Tar = "";
							Tar = Tar + "Page=" + intI;
							Tar = Tar + "&k_equal_value=" + k_equal_value;
							Tar = Tar + "&id_exam=" + id_exam;
							Tar = Tar + "&id_q=" + id_q;

							//�����׷��� �ִٸ� ����Ѵ�
							if (intI <= TotPage ) {
							
						%>
							[<a href="ans_equal_result.jsp?<%=Tar%>">����</a>]
						<% 
							//�����׷� ��---------------
							
							}

						%>
						</td>
					</tr> 
				</table>

			</td>
		</tr>
	</table>

</body>
</html>