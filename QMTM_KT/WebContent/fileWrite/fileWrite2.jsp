<%@ page contentType="text/html; charset=euc-kr" %>
<%@page import="qmtm.ComLib, qmtm.FileSecurity, qmtm.ZipUtils, qmtm.SET, qmtm.QmTm, qmtm.common.*, java.io.*, java.util.* "%>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");
%>

<%
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	ExamInfoBean info = null;
	
	try {
		info = ExamWriteInfo.getBean(id_exam);
	}
    catch (Exception ex) {
        out.println(ex.getMessage());

		if(true) return;
	}

	int qcount = info.getQcount();
	int setcount = info.getSetcount();
	
	String[] arrExlabel = info.getExlabel().split(",");

	ExamPaperBean[] qs = null;

	String dirName = "";
	String fileName = "";
	String strTextRes = "";

	String examQType = "";

	String[][] arrEx = new String[qcount][8];  // 보기라벨 + 보기내용
	
	// 시험지 갯수만큼 폴더를 사전에 생성한다.
	for (int k = 1; k <= setcount; k++) 
	{		
		dirName = SET.PAPER_HTML_PATH+id_exam+"_"+String.valueOf(k);
		
		// 시험코드+NR_SET으로 폴더를 생성한다.
		File dir = new File(dirName);

		try {
			if(!dir.exists()) {
				dir.mkdir();
			}
		} catch(Exception ex) {
			out.println(ex.getMessage());

		    if(true) return;
		}
		
		try {
			qs = ExamWritePaper.getBeans(id_exam, k);
		} catch (Exception ex) {
			out.println(ex.getMessage());

		    if(true) return;
		}

		if(qs == null) 
		{
%>
			<script language="JavaScript">
				alert("해당하는 문제정보가 없습니다");
			</script>
<%
			if(true) return;
		}

		for (int i = 0; i < qcount; i++) 
		{		
		
			StringBuffer strText = new StringBuffer();
			
			// 시험코드+NR_SET 폴더내에 문제별 파일 생성
			strText.append("<!doctype html>");
			strText.append(SET.NL);
			strText.append("<HTML>");
			strText.append(SET.NL);
			strText.append("<HEAD>");
			strText.append(SET.NL);
			strText.append("<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>");
			strText.append(SET.NL);
			strText.append("<script src='../js/jquery.js'></script>");
			strText.append(SET.NL);
			strText.append("<script src='../js/paper.js'></script>");
			strText.append(SET.NL);
			strText.append("<link rel='stylesheet' type='text/css' href='../css/common.css'> ");
			strText.append(SET.NL);
			strText.append("</HEAD>");
			strText.append(SET.NL);
			strText.append("<BODY>");
			strText.append(SET.NL);
			strText.append("<input type='hidden' id='id_q' name='id_q' value="+qs[i].getId_q()+" />");
			strText.append(SET.NL);
			strText.append("<input type='hidden' id='nr_q' name='nr_q' value="+qs[i].getNr_q()+" />");
			strText.append(SET.NL);
			strText.append("<input type='hidden' id='id_qtype' name='id_qtype' value="+qs[i].getId_qtype()+" />");
			strText.append(SET.NL);
			strText.append("<input type='hidden' id='excount' name='excount' value="+qs[i].getExcount()+" />");
			strText.append(SET.NL);
			strText.append("<input type='hidden' id='cacount' name='cacount' value="+qs[i].getCacount()+" />");
			strText.append(SET.NL);
			strText.append("<div class='q_group' id="+qs[i].getNr_q()+">");
			strText.append(SET.NL);	
			strText.append("<SPAN class='q_no'>"+qs[i].getNr_q()+".&nbsp;</SPAN><SPAN class='q'>"+qs[i].getQ()+"</SPAN><BR><BR>");
			strText.append(SET.NL);

			if(qs[i].getId_qtype() < 4) {

				if(qs[i].getCacount() > 1) {
					examQType = "checkbox";
				} else {
					examQType = "radio";
				}

				if(qs[i].getExcount() == 2) { 
					strText.append("<input type="+examQType+" name='answer' value='1' class='radio_answer'><SPAN class='ex_no'>①&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx1())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='2' class='radio_answer'><SPAN class='ex_no'>②&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx2())+"</SPAN><BR>");
					strText.append(SET.NL);
				} else if(qs[i].getExcount() == 3) {
					strText.append("<input type="+examQType+" name='answer' value='1' class='radio_answer'><SPAN class='ex_no'>①&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx1())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='2' class='radio_answer'><SPAN class='ex_no'>②&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx2())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='3' class='radio_answer'><SPAN class='ex_no'>③&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx3())+"</SPAN><BR>");
					strText.append(SET.NL);
				} else if(qs[i].getExcount() == 4) {
					strText.append("<input type="+examQType+" name='answer' value='1' class='radio_answer'><SPAN class='ex_no'>①&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx1())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='2' class='radio_answer'><SPAN class='ex_no'>②&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx2())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='3' class='radio_answer'><SPAN class='ex_no'>③&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx3())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='4' class='radio_answer'><SPAN class='ex_no'>④&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx4())+"</SPAN><BR>");
					strText.append(SET.NL);
				} else if(qs[i].getExcount() == 5) {
					strText.append("<input type="+examQType+" name='answer' value='1' class='radio_answer'><SPAN class='ex_no'>①&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx1())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='2' class='radio_answer'><SPAN class='ex_no'>②&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx2())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='3' class='radio_answer'><SPAN class='ex_no'>③&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx3())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='4' class='radio_answer'><SPAN class='ex_no'>④&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx4())+"</SPAN><BR>");
					strText.append(SET.NL);
					strText.append("<input type="+examQType+" name='answer' value='5' class='radio_answer'><SPAN class='ex_no'>⑤&nbsp;</SPAN><SPAN class='ex'>"+QmTm.delTag2(qs[i].getEx5())+"</SPAN><BR>");
					strText.append(SET.NL);
				}
			
			} else if(qs[i].getId_qtype() == 4) {
				for(int m = 1; m <= qs[i].getCacount(); m++) {
					strText.append("<input type='text' id='answer'"+m+" name='answer'"+m+" class='text_answer' value='' /><br />");
				}
			} else if(qs[i].getId_qtype() == 5) {
				strText.append("<textarea rows='8' cols='100' id='answer' class='answer_textarea'></textarea>");
			}

			strText.append("</div>");
			strText.append(SET.NL);
			strText.append("</BODY>");
			strText.append(SET.NL);
			strText.append("</HTML>");

			fileName = String.valueOf(i+1) + ".html";

			strTextRes = strText.toString();

			byte[] byteEnc = FileSecurity.encoding(strTextRes);

			String strTextRes_Enc = new String(byteEnc);

			byte[] byteEnc2 = strTextRes_Enc.getBytes();

			out.println(strTextRes_Enc);

			out.println("<BR><BR><BR><BR>");

			String strTextRes_Enc2 = new String(byteEnc2);
			
			out.println(strTextRes_Enc2);

			out.println("<BR><BR><BR><BR>");

			out.println(FileSecurity.decoding(byteEnc));

			out.println("<BR><BR><BR><BR>");

			out.println(FileSecurity.decoding(byteEnc2));

			if(true) return;

			try {
			  SET.saveFile(strTextRes_Enc, dirName, fileName, true);
			}
			catch (Exception ex) {
			  out.println(ex.getMessage());

			  if(true) return;
			}
		}

		// 생성된 폴더 zip 파일로 압축		
		String sourcePath = "";
		String zipFileName = "";

		sourcePath = dirName;
		zipFileName = dirName+".zip";

		try {
			ZipUtils.zip(sourcePath, zipFileName);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	
	}

%>

<Script type="text/javascript">
	alert("파일 생성이 완료되었습니다.");
</Script>

