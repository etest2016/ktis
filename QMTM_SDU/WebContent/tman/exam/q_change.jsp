<%
//******************************************************************************
//   ���α׷� : q_change.jsp
//   �� �� �� : ������ü
//   ��    �� : ������ü ������
//   �� �� �� : q, r_difficulty, make_q
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.QmTm, qmtm.tman.exam.QunitBean, 
//              qmtm.tman.exam.Qunit, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean,
//              qmtm.qman.question.QListBean, qmtm.qman.question.QListUtil
//   �� �� �� : 2013-02-19
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.QmTm, qmtm.tman.exam.QunitBean, qmtm.tman.exam.Qunit, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean, qmtm.qman.question.QListBean, qmtm.qman.question.QListUtil " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_qs.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	String[] arrQ = id_qs.split(",");

	int qcount = arrQ.length;

	String exlabel = "��,��,��,��,��,";

	String[][] arrEx = new String[qcount][5];  // ����� + ���⳻��
	
	String[] arrExlabel = exlabel.split(",");

	QunitBean[] qs = null;

	try {
		qs = Qunit.getBeans(id_qs);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	long[] arrId_q = new long[qcount];
	boolean[] arrHasRef = new boolean[qcount]; // ��������
	String[] arrRefTitle = new String[qcount]; // �������� �� �ش繮����ȣ
	String[] arrRefBody = new String[qcount];  // ��������
	String[] arrId_ref = new String[qcount];  // ��������

	String[] arrQuestion = new String[qcount]; // ��������

	int[] arrId_qtype = new int[qcount];        // ���� ����
	boolean[] arrHasEx = new boolean[qcount];  // ��������
	int[] arrExcount = new int[qcount];        // ���� ����

	String[] arrCA = new String[qcount];       // ����ǥ��
	boolean[] arrHasExplain = new boolean[qcount]; // �ؼ�����
	String[] arrExplain = new String[qcount];      // �ؼ�

	String[] arrHint = new String[qcount];      // ��Ʈ

	String[] arrQtype = new String[qcount]; // ��������

	String[] arrEx1 = new String[qcount];
	String[] arrEx2 = new String[qcount];
	String[] arrEx3 = new String[qcount];
	String[] arrEx4 = new String[qcount];
	String[] arrEx5 = new String[qcount];
	
	// �ʱ�ȭ
	String id_ref = "";     // ����ID
	
	for(int i=0; i<qs.length; i++) {

		arrId_qtype[i] = qs[i].getId_qtype();
	    int id_valid_type = qs[i].getId_valid_type();
	    int cacount = qs[i].getCacount();
		int[] arrEx_order = qs[i].getArrEx_order();
		arrCA[i] = QmTm.getNullChk(qs[i].getCa());

		arrEx1[i] = QmTm.delTag2(qs[i].getEx1());
		arrEx2[i] = QmTm.delTag2(qs[i].getEx2());
		arrEx3[i] = QmTm.delTag2(qs[i].getEx3());
		arrEx4[i] = QmTm.delTag2(qs[i].getEx4());
		arrEx5[i] = QmTm.delTag2(qs[i].getEx5());
		
		arrQuestion[i] = qs[i].getQ();

		arrId_q[i] = qs[i].getId_q();
		
		if(qs[i].getId_ref().equals("0")) {
			arrHasRef[i] = false;
		} else {
			arrHasRef[i] = true;
			arrRefTitle[i] = qs[i].getReftitle();
			arrRefBody[i] = qs[i].getRefbody();
			arrId_ref[i] = qs[i].getId_ref();
		}

		if (arrId_qtype[i] <= 3) {
			arrHasEx[i] = true;
		} else {
			arrHasEx[i] = false;
   	    }
	  
		arrExcount[i] = qs[i].getExcount();

		for (int j = 0; j < arrExcount[i]; j++) {
			arrEx[i][j] = arrExlabel[j];
		}
	}

	String id_category = "";
	String id_course = "";

	try {
		id_category = ExamUtil.getId_midcategory(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	try {
		id_course = ExamUtil.getId_category(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	ExamUtilBean[] rst = null;

    try {
	    if(chk_userid.equals("qmtm") || chk_usergrade.equals("M")) {
		    rst = ExamUtil.getCourseList(id_category);
		} else {
			rst = ExamUtil.getCourseList(id_category, chk_userid);
		}
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	QListBean[] q_rst = null;
	
	String bigos = request.getParameter("bigos");
	if (bigos == null) { bigos = ""; } else { bigos = bigos.trim(); }
	
	String sel_id_course = id_course;
	
	String id_subject = "";
	String id_chapter = "0";
	
	if(bigos.equals("Y")) {
		sel_id_course = request.getParameter("sel_id_course");
		if (sel_id_course == null) { sel_id_course = ""; } else { sel_id_course = sel_id_course.trim(); }
		
		id_subject = request.getParameter("id_subject");
		id_chapter = request.getParameter("id_chapter");

		// ��⿡ �ش��ϴ� ���� ��������
		try {
			q_rst = QListUtil.getUBeans(userid, id_subject, id_chapter);
		} catch(Exception ex) {		
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}

	int id_qtype = arrId_qtype[0];
	
%>

<html>
<head>
<title> :: ���� ��ü :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">	
	
	var subj;
	var cpt1;

	// ���� ���� ���������
	function get_subj_list(subj1) {
		var frm = document.form1;
			
		Show_LayerProgressBar(true);
			
		subj = new ActiveXObject("Microsoft.XMLHTTP");
		subj.onreadystatechange = get_subj_list_callback;
		subj.open("GET", "change_subj.jsp?id_subject=<%=id_subject%>&subj="+subj1, true);
		subj.send();
	}

	function get_subj_list_callback() {

		if(subj.readyState == 4) {
			if(subj.status == 200) {
				if(typeof(document.all.div_subj) == "object") {
					Show_LayerProgressBar(false);
					document.all.div_subj.innerHTML = subj.responseText;
				}
			}
		}
	}

	// ��� ���� ���������
	function get_cpt_list(cpts1) {
			
		var frm = document.form1;

		Show_LayerProgressBar(true);
			
		cpt1 = new ActiveXObject("Microsoft.XMLHTTP");
		cpt1.onreadystatechange = get_cpt_list_callback;
		cpt1.open("GET", "change_cpt1.jsp?id_chapter=<%=id_chapter%>&id_subject="+cpts1, true);
		cpt1.send();
	}

	function get_cpt_list_callback() {

		if(cpt1.readyState == 4) {
			if(cpt1.status == 200) {
				if(typeof(document.all.div_cpt1) == "object") {
					Show_LayerProgressBar(false);
					document.all.div_cpt1.innerHTML = cpt1.responseText;
				}
			}
		}
	}

	HTML_P = '<DIV id="ProgressBar" class="progress_img_all_cover">' 
           + '<img src="../../images/loading.gif" style="position:absolute; top:35%; left:30%;"/>' 
           + '</DIV>'; 
  
	document.write(HTML_P); 

	Show_LayerProgressBar(false);
	  
	function Show_LayerProgressBar(isView) { 
			
		var obj = document.getElementById("ProgressBar"); 
		if (isView) { 
			obj.style.display = "block"; 
		}else{ 
			obj.style.display = "none"; 
		} 
	} 

	function chg_list() {

		var frm = document.form1;

		if(frm.id_subject.value == "") {
			alert("������ �����ϼ���.");
			return false;
		}

		frm.bigos.value = "Y";
		frm.action = 'q_change.jsp';
		frm.method = 'post';
		frm.submit();				
	}

	function Send() {
		var frm = document.form1;

		if(frm.new_id_q.value == "") {
			alert("������ ������ �����ϼ���.");
			return false;
		}

		frm.action = 'q_change_ok.jsp';
		frm.method = 'post';
		frm.submit();
	}
</script>

<link rel="STYLESHEET" type="text/css" href="../../codebase/dhtmlxgrid.css">
<link rel="stylesheet" type="text/css" href="../../dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_web.css">
<script src="../../dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
<script src="../../dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
<script src="../../dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
<script src="../../dhtmlxGrid/codebase/ext/dhtmlxgrid_srnd.js"></script>

<script>      
	  
	  var gridQString = "";//we'll save here the last url with query string we used for loading grid (see step 5 for details)
      //we'll use this script block for functions
	  var mygrid = "";
	  function init(){

	  	get_subj_list("<%=sel_id_course%>");		
		get_cpt_list("<%=id_subject%>");
		
		alert("<%=id_exam%>");
		alert("<%=id_subject%>");
		alert("<%=id_chapter%>");
		alert("<%=id_qs%>");
		alert("<%=id_qtype%>");
		
		mygrid = new dhtmlXGridObject('products_grid');
        mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");        
		mygrid.setHeader("�����ڵ�,��������,����,����1,����2,����3,����4,����5,����,�����,����Ƚ��,�����,�����,���̵�,�������");
        mygrid.setInitWidths("70,70,200,80,80,80,80,80,70,70,70,70,70,70,80");
        mygrid.setColAlign("center,center,left,left,left,left,left,left,center,center,center,center,center,center,center");
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("int,str,str,str,str,str,str,str,str,int,int,int,int,str,str")
		mygrid.attachEvent("onRowSelect", doOnRowSelected);
		mygrid.setStyle("text-align:center;", "","", "");
        mygrid.setSkin("dhx_web");
		mygrid.init();
        mygrid.enableSmartRendering(true);
		gridQString = "dyngrid_getXML.jsp?id_exam=<%=id_exam%>&id_subject=<%=id_subject%>&id_chapter=<%=id_chapter%>&id_q=<%=id_qs%>&id_qtype=<%=id_qtype%>";
		mygrid.loadXML(gridQString);
		
	  }

	  function doOnRowSelected(id) {
		 strs = mygrid.getSelectedId();
		 
		 document.form1.new_id_q.value = mygrid.cells(strs,0).getValue();

		 if(mygrid.cells(strs,1).getValue() == "OX��") {
			 document.form1.qtypes.value = "1";
		 } else if(mygrid.cells(strs,1).getValue() == "������") {
			 document.form1.qtypes.value = "2";
	     } else if(mygrid.cells(strs,1).getValue() == "���������") {
			 document.form1.qtypes.value = "3";
	     } else if(mygrid.cells(strs,1).getValue() == "�ܴ���") {
			 document.form1.qtypes.value = "4";
		 } else {
			 document.form1.qtypes.value = "5";
	     }

		 document.form1.excount.value = mygrid.cells(strs,11).getValue();
		 
	  }	
	  	 	 
</script>

</head>

<% if(bigos.equals("Y")) { %>
	<body id="popup2" onload="init()">
<% } else { %>
	<body id="popup2" onload="get_subj_list('<%=sel_id_course%>');">
<% } %>
	
	<form name="form1">
	<input type="hidden" name="bigos" >
	<input type="hidden" name="qtypes" >
	<input type="hidden" name="excount" >
	<input type="hidden" name="id_qs" value="<%=id_qs%>">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
		
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ��ü <span><b> > ���õ� ������ �ٸ� ������ ��ü�մϴ�.</b></span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	
	<div id="contents">
	
	<% for (int i = 0; i < qcount; i++) { /* �������� loop �� �����鼭 */ %>

	<!--------------------------------------- ���� --------------------------------------->
	<Div id="ref">
		<% if (arrHasRef[i]) { %>
		<b>�����ڵ�:<%= arrId_ref[i] %></b><br>
		<%= arrRefTitle[i] %>
		<%= arrRefBody[i] %>
		<% } %>
	</Div>	
		
	<!--------------------------------------- ���� --------------------------------------->
	<Div id="q">
		<b>���������ڵ�:<%= arrId_q[i] %></b><br><br>
		<font color="#0000CC"><%= arrQuestion[i] %></font>
	</Div>
		
	<!--------------------------------------- ���� --------------------------------------->
	<Div id="ex">
		<% if (arrHasEx[i]) { %>
			<% if(arrExcount[i] == 2) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %>
			<% } else if(arrExcount[i] == 3) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %>
			<% } else if(arrExcount[i] == 4) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %>
			<% } else if(arrExcount[i] == 5) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %><br>
				<%=arrExlabel[4]%>&nbsp;&nbsp;<%= arrEx5[i] %>			
			<% } %>
		<% } %>

	</Div>
	
	<Div id="ans">
		<% if(arrId_qtype[i] == 3 || arrId_qtype[i] == 4) { %>
			����: <%=arrCA[i].replace("{|}",", ").replace("{^}"," �Ǵ� ")%>
		<% } else { %>
			����: <%=arrCA[i] %>
		<% } %>
	</Div>
		
	<% } %>

	</div>
	
	<BR>
		
	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>				
				<td id="left" width="15%"><li>��������</td>
				<td width="35%"><select id="sel_id_course" name="sel_id_course" onChange="get_subj_list(this.value);" style="width:300">
					<option value="">������ �����ϼ���</option>
					<% for(int i=0; i<rst.length; i++) { %>
						<option value="<%=rst[i].getId_course()%>" <%if(sel_id_course.equals(rst[i].getId_course())) {%>selected<%}%>><%=rst[i].getCourse()%></option>
					<% } %>
					</select>
				</td>
				<td id="left" width="15%"><li>������</td>
				<td width="35%"><div id="div_subj">&nbsp;&nbsp;<select name="id_subject" style="width:300">
							<option value="">������ �����ϼ���.</option>
						</select>
					</div>
				</td>				
			</tr>	
			<tr>				
				<td id="left" width="15%"><li>�ܿ�����</td>
				<td width="35%"><div id="div_cpt1"><select name="id_chapter" style="width:300">
				<option value="0">�ܿ��� �����ϼ���</option>
				</select>
				</div>
				</td>
				<td align="left" width="15%"><input type="button" value="�����˻��ϱ�" onClick="chg_list();" class="form"></td>
				<td width="35%">&nbsp;</td>
			</tr>	
		</table>
	</div>	
	
	<BR>

	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>				
				<td id="left" width="18%"><li>���������ڵ�</td>
				<td width="10%"><input type="text" name="org_id_q" value = "<%=id_qs%>" size="7" readonly></td>
				<td id="left" width="18%"><li>���湮���ڵ�</td>
				<td width="10%"><input type="text" name="new_id_q" size="7" readonly></td>
				<td width="12%"><input type="button" value="������ü�ϱ�" onClick="Send();" class="form"></td>
				<td width="*">&nbsp;</td>
			</tr>	
		</table>
	</div>	
	
	<BR>

	<% if(bigos.equals("Y")) { %>
		<div id="contents">
			<div id="products_grid" style="width:100%;height:300px;"></div>
		</div>
	<% } %>
	
	</form>
	
 </BODY>
</HTML>