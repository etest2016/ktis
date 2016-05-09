<%
//******************************************************************************
//   ���α׷� : p_top.jsp
//   �� �� �� : ������ ���� TOP ������
//   ��    �� : ������ ���� TOP ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-04-21
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set= "1"; } else { nr_set = nr_set.trim(); }
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	int ans_cnt = 0;

	try {
		ans_cnt = ExamUtil.getAnsCnt(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
<HEAD>
<TITLE> :: ������ �����, ��� :: </TITLE>
<!--link rel="StyleSheet" href="../../css/style.css" type="text/css"-->
<style>
	
	body { margin: 0px; }
	a:link { text-decoration: none; color: #FFFFFF; font-weight: bold; font-size: 12px; }
	a:visited { text-decoration: none; color: #FFFFFF; font-weight: bold; font-size: 12px; }
	a:active { text-decoration: none; font-size: 12px; }
	a:hover { color: #FFFFFF; text-decoration: underline; font-weight: bold; font-size: 12px;  }

</style>

<script language="JavaScript">

	function exam_make() {
		var ans_cnt = <%=ans_cnt%>;

		if(ans_cnt > 0) {
			alert("������ " + ans_cnt + "���� ������� �ֽ��ϴ�.\n\n�̹� ������ �ǽõ� �������� �߰�, ����, ���� �۾��� �� �� �����ϴ�.");
		} else {
			window.open("exam_make_write.jsp?id_exam=<%=id_exam%>","exam_make","width=660, height=680, scrollbars=yes, top=0, left=0");
		}
    }

	function exam_delete() {
		if(<%=ans_cnt%> > 0) {
			alert("*����* �ش� ���迡 �����ڰ� �ֽ��ϴ�.\n\n�����ڰ� ������� �������� ���� �� �� �����ϴ�. \n�������� �����Ϸ��� �����ڰ� ���� �����Ǿ�� �մϴ�." );		
		} else {
			var st = confirm("*����* �������� �����Ͻðڽ��ϱ�?" );
		}
		    if (st == true) {
				document.location = "exam_delete.jsp?id_exam=<%=id_exam%>";
	        }
		
	}

	function paper_guide() {
		window.open("paper_guide_list.jsp?id_exam=<%=id_exam%>","paper_guide","width=650, height=500, scrollbars=yes, top=0, left=0");
    }

	function paper_option() {
		window.open("paper_option.jsp?id_exam=<%=id_exam%>","paper_option","width=700, height=600, scrollbars=yes, top=0, left=0");
    }

	function paper_preview() {
		window.open("paper_preview.jsp?id_exam=<%=id_exam%>&nr_set=<%=nr_set%>","paper_preview","width=400, height=250, scrollbars=yes, top=0, left=0");
	}

	function chapter_score() {
		window.open("chapter_score_list.jsp?id_exam=<%=id_exam%>","chapter_score","width=700, height=350, scrollbars=yes, top=0, left=0");
	}

	function goout_Click() {
		top.opener.location.reload();
		top.window.close();
	}

	function parent_reload() {
		top.opener.location.reload();
	}

</script>
</HEAD>

<BODY onLoad="parent_reload()">

	<TABLE width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<TR>
			<TD width="155" style="background-image: url(../../images/bg_mpaper_l.gif); background-repeat: repeat-x; background-color: #fafafa;" align="right" valign="top"><img src="../../images/bg_mpaper_l2.gif"></TD>
			<TD style="background-image: url(../../images/bg_mpaper_r.gif); background-repeat: repeat-x;" valign="top">
				<div style="float: left; padding-top: 9px; padding-left: 20px;">
					<a href="javascript:exam_make();">�����������</a>&nbsp;&nbsp;&nbsp;<a href="javascript:exam_delete();">����������</a>&nbsp;&nbsp;&nbsp;<!--<a href="javascript:chapter_score();">�䱸��������</a>&nbsp;&nbsp;&nbsp;--><a href="javascript:paper_option();">�����ɼ�</a>&nbsp;&nbsp;&nbsp;<a href="javascript:paper_preview();">�̸�����</a><!--&nbsp;&nbsp;&nbsp;<a href="javascript:paper_preview();">��������</a>-->
				</div>
				<div style="float: right; margin-right: 15px;"><img src="../../images/bt_mpaper_out.gif" onclick="goout_Click();" style="cursor: hand;"></div>
			</TD>
		</TR>
	</TABLE>
	
 
</BODY>
</HTML>
