package qmtm.qman.question;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class QListUtil
{
    public QListUtil() {
    }

	/* 신규 등록 문제 가져오는 쿼리 */
	
	public static QListBean[] getNewQ(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select top 15 c.q_subject, a.id_q, b.qtype, a.q, a.ca, a.allotting, d.difficulty, ");
		sql.append("       convert(varchar(16), a.regdate, 120) regdate ");
		sql.append("From q a, r_qtype b, q_subject c, r_difficulty d ");
		sql.append("Where a.id_qtype = b.id_qtype and a.id_difficulty1 = d.id_difficulty "); 
		sql.append("      and a.id_subject = c.id_q_subject ");
		if(!userid.equals("qmtm")) {
			sql.append("      and a.userid = ? ");
		}
		sql.append("Order by a.id_q desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			if(!userid.equals("qmtm")) {
				stm.setString(1, userid);
			}
            rst = stm.executeQuery();
            QListBean bean = null;
            while (rst.next()) {
                bean = makeNewQ(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QListBean[]) beans.toArray(new QListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.getNewQ]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QListBean makeNewQ (ResultSet rst) throws QmTmException
    {

		try {
            QListBean bean = new QListBean();
            bean.setQ_subject(rst.getString(1));
			bean.setId_q(rst.getString(2));
            bean.setQtype(rst.getString(3));
			bean.setQ(rst.getString(4));
			bean.setCa(rst.getString(5));
			bean.setAllotting(rst.getString(6));
			bean.setDifficulty(rst.getString(7));
            bean.setRegdate(rst.getString(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.makeNewQ]");
        }
    }
	
	/* 과목 선택시 쿼리 */
	public static QListBean[] getSBeans(String userid, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q, b.qtype, case when a.id_ref = '0' then '일반형' else '지문형' end refs, a.q, a.input_text ");
		sql.append("From q a, r_qtype b, q_subject c ");
		sql.append("Where a.id_subject = ? and a.id_chapter in ('0','-1') and ");
		sql.append("	  a.id_qtype = b.id_qtype and a.id_subject = c.id_q_subject ");
		sql.append("Order by a.id_q desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
            rst = stm.executeQuery();
            QListBean bean = null;
            while (rst.next()) {
                bean = makeLists(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QListBean[]) beans.toArray(new QListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.getSBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QListBean makeLists (ResultSet rst) throws QmTmException
    {
		try {
            QListBean bean = new QListBean();
 			bean.setId_q(rst.getString(1));
            bean.setQtype(rst.getString(2));
			bean.setRefs(rst.getString(3));
			bean.setQ(rst.getString(4));
			bean.setInput_text(rst.getString(5));
			return bean;
        } catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.makeLists]");
        }
	}

	/* 단원 선택시 쿼리 */
	public static QListBean[] getUBeans(String userid, String id_q_subject, String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q, b.qtype, case when a.id_ref = '0' then '일반형' else '지문형' end refs, a.q, a.input_text ");
		sql.append("From q a, r_qtype b, q_subject c ");
		sql.append("Where a.id_subject = ? and a.id_chapter = ? and a.id_chapter2 in ('-1','0') ");
		sql.append("	  and a.id_qtype = b.id_qtype and a.id_subject = c.id_q_subject "); 
		sql.append("Order by a.id_q desc ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_subject);
			stm.setString(2, id_q_chapter);
            rst = stm.executeQuery();
            QListBean bean = null;
            while (rst.next()) {
                bean = makeLists(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QListBean[]) beans.toArray(new QListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.getUBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QListBean[] getUBeans(String userid, String id_q_subject, String id_q_chapter, String id_q_chapter2) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q, b.qtype, case when a.id_ref = '0' then '일반형' else '지문형' end refs, a.q, a.input_text ");
		sql.append("From q a, r_qtype b, q_subject c ");
		sql.append("Where a.id_subject = ? and a.id_chapter = ? and a.id_chapter2 = ? and a.id_chapter3 in ('-1','0') ");
		sql.append("	  and a.id_qtype = b.id_qtype and a.id_subject = c.id_q_subject ");
		sql.append("Order by a.id_q desc ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_subject);
			stm.setString(2, id_q_chapter);
			stm.setString(3, id_q_chapter2);
            rst = stm.executeQuery();
            QListBean bean = null;
            while (rst.next()) {
                bean = makeLists(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QListBean[]) beans.toArray(new QListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.getUBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QListBean[] getUBeans(String userid, String id_q_subject, String id_q_chapter, String id_q_chapter2, String id_q_chapter3) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q, b.qtype, case when a.id_ref = '0' then '일반형' else '지문형' end refs, a.q, a.input_text ");
		sql.append("From q a, r_qtype b, q_subject c ");
		sql.append("Where a.id_subject = ? and a.id_chapter = ? and a.id_chapter2 = ? and a.id_chapter3 = ? ");
		sql.append("	  and a.id_chapter4 in ('0','-1') and a.id_qtype = b.id_qtype and a.id_subject = c.id_q_subject ");
		sql.append("Order by a.id_q desc ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_subject);
			stm.setString(2, id_q_chapter);
			stm.setString(3, id_q_chapter2);
			stm.setString(4, id_q_chapter3);
            rst = stm.executeQuery();
            QListBean bean = null;
            while (rst.next()) {
                bean = makeLists(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QListBean[]) beans.toArray(new QListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.getUBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QListBean[] getUBeans(String userid, String id_q_subject, String id_q_chapter, String id_q_chapter2, String id_q_chapter3, String id_q_chapter4) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q, b.qtype, case when a.id_ref = '0' then '일반형' else '지문형' end refs, a.q, a.input_text ");
		sql.append("From q a, r_qtype b, q_subject c ");
		sql.append("Where a.id_subject = ? and a.id_chapter = ? and a.id_chapter2 = ? and a.id_chapter3 = ? ");
		sql.append("	  and a.id_chapter4 = ? and a.id_qtype = b.id_qtype and a.id_subject = c.id_q_subject ");
		sql.append("Order by a.id_q desc ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_subject);
			stm.setString(2, id_q_chapter);
			stm.setString(3, id_q_chapter2);
			stm.setString(4, id_q_chapter3);
			stm.setString(5, id_q_chapter4);
            rst = stm.executeQuery();
            QListBean bean = null;
            while (rst.next()) {
                bean = makeLists(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QListBean[]) beans.toArray(new QListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.getUBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static QListBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            QListBean bean = new QListBean();
            bean.setId_q(rst.getString(1));
            bean.setId_qtype(rst.getString(2));
			bean.setQ(rst.getString(3));
			bean.setCa(rst.getString(4));
            bean.setRegdate(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.makeBeans]");
        }
    }

	/* 문제 출제 기록 조회 */
	public static QListBean[] getQHistory(String id_qs) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select distinct id_q From exam_paper2 ");
		sql.append("Where id_q in (" + id_qs + ") ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
		    rst = stm.executeQuery(sql.toString());
            QListBean bean = null;
            while (rst.next()) {
                bean = makeQHistory(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QListBean[]) beans.toArray(new QListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.getQHistory]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QListBean makeQHistory (ResultSet rst) throws QmTmException
    {
		try {
            QListBean bean = new QListBean();
            bean.setId_q(rst.getString(1));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.makeQHistory]");
        }
    }

	/* 문제 삭제 */
	public static void deletes(String id_qs) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; String sql = "";

        sql = "Delete From q Where id_q in (" + id_qs + ") ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
		    stm.executeUpdate(sql);
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.deletes]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	/* 문제 이동 */
	public static void qmoves(String id_qs, String id_subject, String id_chapter1, String id_chapter2, String id_chapter3, String id_chapter4) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q set id_subject = '"+ id_subject +"', id_chapter = '"+ id_chapter1 +"', ");
		sql.append("             id_chapter2 = '"+ id_chapter2 +"', id_chapter3 = '"+ id_chapter3 +"', ");
		sql.append("             id_chapter4 = '"+ id_chapter4 +"' ");
		sql.append("Where id_q in (" + id_qs + ") ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
		    stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 이동하는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.qmoves]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	/* 문제 복사 */
	public static void qcopys(String id_qs, String id_subject, String id_chapter1, String id_chapter2, String id_chapter3, String id_chapter4) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		String sOldIDRef = "";
	    String sNewIDRef = "";

        sql.append("Select id_q, id_ref From q ");
		sql.append("Where id_q in (" + id_qs + ") ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
		    rst = stm.executeQuery(sql.toString());

			sOldIDRef = "0";
		    sNewIDRef = "0";
			
			while (rst.next()) 
			{

				// 지문이 있는 경우
	            if(!rst.getString("id_ref").equals("0")) {

					 // 지문코드 비교
	                 if(!sOldIDRef.equals(rst.getString("id_ref"))) {
	                    sOldIDRef = rst.getString("id_ref");
	                    sNewIDRef = CopyRef(sOldIDRef);
	                 }

				// 지문이 없는 경우
				} else {
	                 sNewIDRef = rst.getString("id_ref");
				}

				qcopys_res(rst.getString("id_q"), id_subject, id_chapter1, id_chapter2, id_chapter3, id_chapter4, sNewIDRef);
			}

			makecntAdd();
			
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 복사하는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.copys]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static void qcopys_res(String id_q, String id_subject, String id_chapter1, String id_chapter2, String id_chapter3, String id_chapter4, String id_ref) throws QmTmException
	{
		Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into q(id_subject, id_chapter, id_chapter2, id_chapter3, id_chapter4, id_ref, id_qtype, excount, ");
		sql.append("              cacount, allotting, limittime, id_difficulty1, id_difficulty2, q, ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ");
        sql.append("              ca, yn_caorder, yn_case, yn_blank, explain, hint, src_book, src_author, src_page, src_pub_comp, src_pub_year, ");
		sql.append("              src_misc, find_kwd, userid, id_valid_type, regdate, up_date, id_q_use, q_use_detail, ex_rowcnt, yn_single_line, input_text) ");         
		sql.append("Select '"+id_subject+"', '"+id_chapter1+"', '"+id_chapter2+"', '"+id_chapter3+"', '"+id_chapter4+"', '"+id_ref+"', ");
		sql.append("       id_qtype, excount, cacount, allotting, limittime, id_difficulty1, id_difficulty2, q, ex1, ex2, ex3, ex4, ex5, ");
        sql.append("       ex6, ex7, ex8, ca, yn_caorder, yn_case, yn_blank, explain, hint, src_book, src_author, src_page, src_pub_comp, src_pub_year, ");
		sql.append("       src_misc, find_kwd, userid, id_valid_type, getdate(), getdate(), id_q_use, q_use_detail, ex_rowcnt, yn_single_line, input_text ");
		sql.append("From q ");
		sql.append("Where id_q = '" + id_q + "' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
		    stm.executeUpdate(sql.toString());						
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 복사하는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.qcopys_res]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void makecntAdd() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("insert into make_q ");
		sql.append("Select a.id_q, 0 From q a ");
		sql.append("Where not exists (Select id_q, 0 From make_q Where id_q = a.id_q) ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());

			stm.execute();

        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제 출제횟수 등록 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.makecntAdd]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static String CopyRef(String pid_ref) throws QmTmException 
	{
		Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();
		
		String NewRef = MakeCode();

		sql.append("Insert into q_ref(id_ref, reftitle, refbody1, refbody2, refbody3) ");
		sql.append("Select '" + NewRef + "', reftitle, refbody1, refbody2, refbody3 ");
		sql.append("From q_ref ");
		sql.append("Where id_ref = '" + pid_ref + "' ");

         try
         {
			 cnn = DBPool.getConnection();
             stm = cnn.createStatement();
		     stm.executeUpdate(sql.toString());

		 } catch (SQLException ex) {
		     throw new QmTmException("지문문항 등록 작업 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.CopyRef]");
         } finally {
             if (stm != null) try { stm.close(); } catch (SQLException ex) {}
             if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
         } 

		 return NewRef;
	}

	private static String MakeCode() throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		String stryymmdd = "";
		String sRandom = "";
		String sCode = "";

		// YYMMDDHHMMSS 형식으로 데이터를 가져온다
		sql = "select right(replace(replace(replace(convert(varchar(19), getdate(), 120),'-',''),':',''),' ',''),12)";

		try
        {
		    cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();

			if(rst.next()) {
			    stryymmdd = rst.getString(1);
		    }

		} catch (SQLException ex) {
		    throw new QmTmException("날짜형식 데이타를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QListUtil.MakeCode]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }				

		sRandom = RndChar() + RndChar();
		sCode = "R" + stryymmdd + sRandom;

		return sCode;
	}

	private static String RndChar() 
	{
		String RndStr = "";
		int pNum = 0;

	    try {
		   pNum = (int)(Math.random() * 90);
        } catch (Exception ex) {
		   System.out.print(ex.getMessage());
		}
		
		if(pNum < 65) {
		   pNum = (pNum / 3) + 65; 
		}

		RndStr = String.valueOf((char)pNum);

		return RndStr;
	}
}