<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

<%!
	String PageNumber(int curpage, int totpage, String url, String add_tag) {

    int idxcur, idxtot, i, idxpage, tmp;

    String outStr = "";
    String outStr2 = "";
    String outStr3 = "";

    idxcur = (curpage - 1) / 10 + 1;
    idxtot = (totpage - 1) / 10 + 1;

    for(i = 1; i <= 10; i++) {
      idxpage = (idxcur - 1) * 10 + i;

      if (idxpage <= totpage) { // ���� �������� ���������� ��ü �������� ũ�ų� ���� ���
        
			if(idxpage == totpage) {
				if(curpage == idxpage) {
					outStr = outStr + " <A HREF='" + url + "?page=" + idxpage + add_tag + "' class=bbs07><font color=red><b>" + idxpage + "</b></font></A> " + " <img src=/img_bbs/but_next.gif>" + " <A HREF='" + url + "?page=" + totpage + add_tag + "'><img src=/img_bbs/but_lastpage.gif></a>";
				} else {
					outStr = outStr + " <A HREF='" + url + "?page=" + idxpage + add_tag + "' class=bbs07>" + idxpage + "</A> " + " <img src=/img_bbs/but_next.gif>" + " <A HREF='" + url + "?page=" + totpage + add_tag + "'><img src=/img_bbs/but_lastpage.gif></a>";
				}
			} else {
				if(idxpage == curpage) {
					outStr = outStr + " <A HREF='" + url + "?page=" + idxpage + add_tag + "' class=bbs08><font color=red><b>" + idxpage + "</b></font></A> ";
				} else {
					outStr = outStr + " <A HREF='" + url + "?page=" + idxpage + add_tag + "' class=bbs07>" + idxpage + "</A> ";
				}
			}
        

        if (i == 1) { // ����Ʈ�� �������� ù��° �������ϰ��
          tmp = idxpage - 1;
          outStr2 = " <A HREF='" + url + "?page=" + tmp + add_tag + "'><img src=/img_bbs/but_prev.gif border=0></A>";
          outStr3 = " <A HREF='" + url + "?page=1" + add_tag + "'><img src=/img_bbs/but_firstpage.gif border=0></A> ";

          if (idxcur == 1) { // ù��° �׷��� ���
            outStr = " <A HREF='" + url + "?page=1" + add_tag + "'><img src=/img_bbs/but_firstpage.gif></A> " + "<img src=/img_bbs/but_prev.gif> " + outStr;
          } else { // 2�׷� ���� (11page ~ )
            outStr = outStr3 + outStr2 + outStr;
          }

        } else if (i == 10) { // ����Ʈ�� �������� ������ �������ϰ��
          tmp = idxpage + 1;
          outStr2 = " <A HREF='" + url + "?page=" + tmp + add_tag + "'><img src=/img_bbs/but_next.gif border=0></A>";
          outStr3 = " <A HREF='" + url + "?page=" + totpage + add_tag + "'><img src=/img_bbs/but_lastpage.gif border=0></A>";
		  	
          if (idxcur < idxtot) {
            outStr = outStr + outStr2 + outStr3;			
          } else {
            outStr = outStr + " <img src=/img_bbs/but_next.gif>" + " <img src=/img_bbs/but_lastpage.gif>";
          }
        } 
      }
    }
    return outStr;
  }
%>