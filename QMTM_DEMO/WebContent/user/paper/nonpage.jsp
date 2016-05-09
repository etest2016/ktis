<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="etest.*, etest.paper.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");
%>
<%
	String id_q = request.getParameter("id_q");
	String userid = request.getParameter("userid");
	String id_exam = request.getParameter("id_exam");
	int index = Integer.parseInt(request.getParameter("index"));

	User_ExamAnsNonBean bean;
	try {
	  bean = User_ExamAnsNon.getBean(Long.parseLong(id_q), userid, id_exam);
	} catch (Exception ex) {
		 response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		 if(true) return;
	}

	String ans = bean.getUserans1() + bean.getUserans2() + bean.getUserans3();
	ans = User_QmTm.changeChar(ans);
	ans = ans.replaceAll("\r\n", User_QmTm.CHAR_PATTERN2); // vbCrLf --> AAAAETAAAA
	ans = ans.replaceAll("\r", ""); // vbCr --> ""
	ans = ans.replaceAll("\n", ""); // vbLf --> ""
%>

<script language="javascript">

var gPattern1 = /<%= User_QmTm.CHAR_PATTERN1 %>/gi;
var gPattern2 = /<%= User_QmTm.CHAR_PATTERN2 %>/gi;
var gPattern3 = /<%= User_QmTm.CHAR_PATTERN3 %>/gi;
var gPattern4 = /<%= User_QmTm.CHAR_PATTERN4 %>/gi;
var tmp2 = "";

tmp2 += "<p align=\"right\"><a href=\"javascript:AnsSave('')\"><img src=\"../images/tmp_save.gif\" border=\"0\"></a><br>";
tmp2 += "<textarea style=\"font-family:Arial\" cols=80 rows=18 name=\"nonans\" onblur=\"javascript:AnsCheck(<%= index - 1 %>, this.value);\"></textarea>";

top.frames("fraTest").document.all.ex11.innerHTML = tmp2;
top.frames("fraTest").document.frmData.nonans.value = RestoreChar2(Cnv("<%= ans %>"));
top.frames("fraTest").document.frmData.oldnon.value = RestoreChar2(Cnv("<%= ans %>"));
top.frames("fraTest").ButtonVisible();

function RestoreChar2(strTmp)
{
  var tmpStr = "";
  tmpStr = strTmp.replace(gPattern1, "\"");
  tmpStr = tmpStr.replace(gPattern2, "\r");
  tmpStr = tmpStr.replace(gPattern3, "\\");
  tmpStr = tmpStr.replace(gPattern4, "\"");
  return(tmpStr);
}

function Cnv(str)
{
  // 다국어 처리 함수
  var ver = parseFloat(ScriptEngineMajorVersion() + "." + ScriptEngineMinorVersion());
  var re = /(&#)(\d+)(;)/g;
  var re2 = /\&amp;/g;
  var re3 = /\&lt;/g;
  var re4 = /\&gt;/g;
  var tmpStr = "";

  if (ver >= 5.5)
  {
    tmpStr = str.replace
    (re, function($0,$1,$2) {
      return (String.fromCharCode($2));
    }
    );
  }
  else
  {
    if (str != "")
    {
      var arr, i, repStr;
      arr = str.match(re);

      if (arr != null)
      {
        for (i=0;i<arr.length;i++) {
          repStr = arr[i].substr(2, arr[i].length - 3);
          str = str.replace(arr[i], String.fromCharCode(repStr));
        };
        tmpStr = str;
      }
      else
      {
        tmpStr = str;
      }
    }
  }

  tmpStr = tmpStr.replace(re3, "<");
  tmpStr = tmpStr.replace(re4, ">");
  tmpStr = tmpStr.replace(re2, "&");

  return(tmpStr);
}

</script>
