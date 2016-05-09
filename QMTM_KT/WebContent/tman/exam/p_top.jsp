<%
//******************************************************************************
//   프로그램 : p_top.jsp
//   모 듈 명 : 시험지 생성 TOP 프레임
//   설    명 : 시험지 생성 TOP 프레임
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-04-21
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
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
<TITLE> :: 시험지 만들기, 상단 :: </TITLE>
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
			alert("응시자 " + ans_cnt + "명의 답안지가 있습니다.\n\n이미 시험이 실시된 시험지는 추가, 삭제, 변경 작업을 할 수 없습니다.");
		} else {
			window.open("exam_make_write.jsp?id_exam=<%=id_exam%>","exam_make","width=660, height=680, scrollbars=yes, top=0, left=0");
		}
    }

	function exam_delete() {
		if(<%=ans_cnt%> > 0) {
			alert("*주의* 해당 시험에 응시자가 있습니다.\n\n응시자가 있을경우 시험지를 삭제 할 수 없습니다. \n시험지를 삭제하려면 응시자가 먼저 삭제되어야 합니다." );		
		} else {
			var st = confirm("*주의* 시험지를 삭제하시겠습니까?" );
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
					<a href="javascript:exam_make();">시험지만들기</a>&nbsp;&nbsp;&nbsp;<a href="javascript:exam_delete();">시험지삭제</a>&nbsp;&nbsp;&nbsp;<!--<a href="javascript:chapter_score();">요구수준정의</a>&nbsp;&nbsp;&nbsp;--><a href="javascript:paper_option();">출제옵션</a>&nbsp;&nbsp;&nbsp;<a href="javascript:paper_preview();">미리보기</a><!--&nbsp;&nbsp;&nbsp;<a href="javascript:paper_preview();">내보내기</a>-->
				</div>
				<div style="float: right; margin-right: 15px;"><img src="../../images/bt_mpaper_out.gif" onclick="goout_Click();" style="cursor: hand;"></div>
			</TD>
		</TR>
	</TABLE>
	
 
</BODY>
</HTML>
