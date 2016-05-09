package qmtm.qman.editor;

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

public class QUtil
{
    public QUtil() {
    }

	public static void insert(QBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q(id_subject, id_chapter, id_chapter2, id_chapter3, id_chapter4, id_ref, id_qtype, excount, cacount, "); 
		sql.append("              allotting, limittime, id_difficulty1, q, ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ca, yn_caorder, "); 
		sql.append("              yn_case, yn_blank, explain, hint, src_book, src_author, src_page, src_pub_comp, src_pub_year, src_misc, "); 
		sql.append("              find_kwd, userid, id_q_use, ex_rowcnt, yn_single_line, input_text ) "); 
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, 'N' ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_subject());
			stm.setString(2, bean.getId_chapter());
			stm.setString(3, bean.getId_chapter2());
            stm.setString(4, bean.getId_chapter3());
			stm.setString(5, bean.getId_chapter4());
			stm.setString(6, bean.getId_ref());
			stm.setInt(7, bean.getId_qtype());
			stm.setInt(8, bean.getExcount());
			stm.setInt(9, bean.getCacount());
			stm.setDouble(10, bean.getAllotting());
			stm.setInt(11, bean.getLimittime());
			stm.setInt(12, bean.getId_difficulty1());
			stm.setString(13, bean.getQ());
			stm.setString(14, bean.getEx1());
			stm.setString(15, bean.getEx2());
			stm.setString(16, bean.getEx3());
			stm.setString(17, bean.getEx4());
			stm.setString(18, bean.getEx5());
			stm.setString(19, bean.getEx6());
			stm.setString(20, bean.getEx7());
			stm.setString(21, bean.getEx8());
			stm.setString(22, bean.getCa());
			stm.setString(23, bean.getYn_caorder());
			stm.setString(24, bean.getYn_case());
			stm.setString(25, bean.getYn_blank());
			stm.setString(26, bean.getExplain());
			stm.setString(27, bean.getHint());
			stm.setString(28, bean.getSrc_book());
			stm.setString(29, bean.getSrc_author());
			stm.setString(30, bean.getSrc_page());
			stm.setString(31, bean.getSrc_pub_comp());
			stm.setString(32, bean.getSrc_pub_year());
			stm.setString(33, bean.getSrc_misc());
			stm.setString(34, bean.getFind_kwd());
			stm.setString(35, bean.getUserid());
			stm.setInt(36, bean.getId_q_use());
			stm.setInt(37, bean.getEx_rowcnt());
			stm.setString(38, bean.getYn_single_line());

			stm.execute();
        }
        catch (SQLException ex) {
            //throw new QmTmException("문제 등록하는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.insert]");        
			throw new QmTmException(ex.getMessage());        	
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(String id_q, QBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Update q ");
		sql.append("       Set id_ref = ?, id_qtype = ?, excount = ?, cacount = ?, allotting = ?, ");
		sql.append("           limittime = ?, id_difficulty1 = ?, q = ?, ex1 = ?, ex2 = ?, ex3 = ?, ex4 = ?, ");
		sql.append("           ex5 = ?, ex6 = ?, ex7 = ?, ex8 = ?, ca = ?, yn_caorder = ?, yn_case =?, yn_blank = ?, ");
		sql.append("           explain = ?, hint = ?, src_book = ?, src_author = ?, src_page = ?, src_pub_comp = ?, ");
		sql.append("           src_pub_year = ?, src_misc = ?, find_kwd = ?, userid = ?, id_q_use = ?, ex_rowcnt = ?, ");
		sql.append("           yn_single_line = ? ");
		sql.append("Where id_q = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_ref());
			stm.setInt(2, bean.getId_qtype());
			stm.setInt(3, bean.getExcount());
			stm.setInt(4, bean.getCacount());
			stm.setDouble(5, bean.getAllotting());
			stm.setInt(6, bean.getLimittime());
			stm.setInt(7, bean.getId_difficulty1());
			stm.setString(8, bean.getQ());
			stm.setString(9, bean.getEx1());
			stm.setString(10, bean.getEx2());
			stm.setString(11, bean.getEx3());
			stm.setString(12, bean.getEx4());
			stm.setString(13, bean.getEx5());
			stm.setString(14, bean.getEx6());
			stm.setString(15, bean.getEx7());
			stm.setString(16, bean.getEx8());
			stm.setString(17, bean.getCa());
			stm.setString(18, bean.getYn_caorder());
			stm.setString(19, bean.getYn_case());
			stm.setString(20, bean.getYn_blank());
			stm.setString(21, bean.getExplain());
			stm.setString(22, bean.getHint());
			stm.setString(23, bean.getSrc_book());
			stm.setString(24, bean.getSrc_author());
			stm.setString(25, bean.getSrc_page());
			stm.setString(26, bean.getSrc_pub_comp());
			stm.setString(27, bean.getSrc_pub_year());
			stm.setString(28, bean.getSrc_misc());
			stm.setString(29, bean.getFind_kwd());
			stm.setString(30, bean.getUserid());
			stm.setInt(31, bean.getId_q_use());
			stm.setInt(32, bean.getEx_rowcnt());
			stm.setString(33, bean.getYn_single_line());
			stm.setString(34, id_q);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문항 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void insert_text(QBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q(id_subject, id_chapter, id_chapter2, id_chapter3, id_chapter4, id_ref, id_qtype, excount, cacount, "); 
		sql.append("              allotting, limittime, id_difficulty1, q, ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ca, yn_caorder, "); 
		sql.append("              yn_case, yn_blank, explain, hint, src_book, src_author, src_page, src_pub_comp, src_pub_year, src_misc, "); 
		sql.append("              find_kwd, userid, id_q_use, ex_rowcnt, yn_single_line, input_text ) "); 
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, 'Y' ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_subject());
			stm.setString(2, bean.getId_chapter());
			stm.setString(3, bean.getId_chapter2());
            stm.setString(4, bean.getId_chapter3());
			stm.setString(5, bean.getId_chapter4());
			stm.setString(6, bean.getId_ref());
			stm.setInt(7, bean.getId_qtype());
			stm.setInt(8, bean.getExcount());
			stm.setInt(9, bean.getCacount());
			stm.setDouble(10, bean.getAllotting());
			stm.setInt(11, bean.getLimittime());
			stm.setInt(12, bean.getId_difficulty1());
			stm.setString(13, bean.getQ());
			stm.setString(14, bean.getEx1());
			stm.setString(15, bean.getEx2());
			stm.setString(16, bean.getEx3());
			stm.setString(17, bean.getEx4());
			stm.setString(18, bean.getEx5());
			stm.setString(19, bean.getEx6());
			stm.setString(20, bean.getEx7());
			stm.setString(21, bean.getEx8());
			stm.setString(22, bean.getCa());
			stm.setString(23, bean.getYn_caorder());
			stm.setString(24, bean.getYn_case());
			stm.setString(25, bean.getYn_blank());
			stm.setString(26, bean.getExplain());
			stm.setString(27, bean.getHint());
			stm.setString(28, bean.getSrc_book());
			stm.setString(29, bean.getSrc_author());
			stm.setString(30, bean.getSrc_page());
			stm.setString(31, bean.getSrc_pub_comp());
			stm.setString(32, bean.getSrc_pub_year());
			stm.setString(33, bean.getSrc_misc());
			stm.setString(34, bean.getFind_kwd());
			stm.setString(35, bean.getUserid());
			stm.setInt(36, bean.getId_q_use());
			stm.setInt(37, bean.getEx_rowcnt());
			stm.setString(38, bean.getYn_single_line());

			stm.execute();
        }
        catch (SQLException ex) {
            //throw new QmTmException("문제 등록하는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.insert_text]");        
			throw new QmTmException(ex.getMessage());        	
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void insertRef(QRefBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q_REF(id_ref, reftitle, refbody1, refbody2, refbody3) ");
        sql.append("VALUES (?, ?, ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_ref());
			stm.setString(2, bean.getReftitle());
			stm.setString(3, bean.getRefbody1());
			stm.setString(4, bean.getRefbody2());
			stm.setString(5, bean.getRefbody3());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("지문문항 등록하는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.insertRef]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateRef(String id_ref, QRefBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_ref ");
		sql.append("       Set reftitle = ?, refbody1 = ?, refbody2 = ?, refbody3 = ? ");
        sql.append("Where id_ref = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getReftitle());
			stm.setString(2, bean.getRefbody1());
			stm.setString(3, bean.getRefbody2());
			stm.setString(4, bean.getRefbody3());
            stm.setString(5, id_ref);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("지문문항 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.updateRef]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void insertMsg(int seq, String front_msg, String back_msg, String box_size) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q_MSG ");
        sql.append("Select max(id_q), "+seq+", '"+front_msg+"', '"+back_msg+"', '"+box_size+"' From q ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
            stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("단답형 답안 입력박스 등록하는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.insertMsg]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void insertMsg2(String id_q, int seq, String front_msg, String back_msg, String box_size) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q_MSG ");
        sql.append("Select id_q, "+seq+", '"+front_msg+"', '"+back_msg+"', '"+box_size+"' From q ");
		sql.append("Where id_q = '"+id_q+"' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
            stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("단답형 답안 입력박스 등록하는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.insertMsg2]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateMsg(String id_q, int seq, String front_msg, String back_msg, String box_size) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_msg ");
		sql.append("       Set front_msg = '"+front_msg+"', back_msg = '"+back_msg+"', box_size = '"+box_size+"' ");
		sql.append("Where id_q = '"+id_q+"' and seq = "+seq+" ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
            stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("단답형 답안 입력박스 수정하는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.updateMsg]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QBean getBean(String id_q) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select b.id_ref, b.id_qtype, b.excount, b.cacount, b.allotting, b.limittime, b.id_difficulty1, b.id_difficulty2, ");
		sql.append("       b.q, b.ex1, b.ex2, b.ex3, b.ex4, b.ex5, b.ex6, b.ex7, b.ex8, b.ca, b.yn_caorder, b.yn_case, b.yn_blank, b.explain, ");
		sql.append("       b.hint, b.src_book, b.src_author, b.src_page, b.src_pub_comp, b.src_pub_year, b.src_misc, b.find_kwd, b.userid, ");
		sql.append("       b.id_valid_type, b.id_q_use, b.q_use_detail, b.ex_rowcnt, b.yn_single_line, c.reftitle, c.refbody1, c.refbody2, c.refbody3, a.make_cnt ");
		sql.append("From make_q as a inner join q as b ");
		sql.append("     on b.id_q = ? and a.id_q = b.id_q ");
		sql.append("     left outer join q_ref as c on b.id_ref = c.id_ref ");

		try
		{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			//stm.setString(1, id_q);
			stm.setInt(1, Integer.parseInt(id_q));
			
			//System.out.println(stm.toString());
			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} 
		catch (SQLException ex) {
			//System.out.println(ex.getSQLState() + ex.getMessage());
			throw new QmTmException("문항 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.getBean]");
		} 
		finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}		
	}

	private static QBean makeBean (ResultSet rst) throws QmTmException
    {
		try {
            QBean bean = new QBean();
            bean.setId_ref(rst.getString(1));
			bean.setId_qtype(rst.getInt(2));
			bean.setExcount(rst.getInt(3));
			bean.setCacount(rst.getInt(4));
			bean.setAllotting(rst.getDouble(5));
			bean.setLimittime(rst.getInt(6));
			bean.setId_difficulty1(rst.getInt(7));
			bean.setId_difficulty2(rst.getInt(8));
			bean.setQ(rst.getString(9));
			bean.setEx1(rst.getString(10));
			bean.setEx2(rst.getString(11));
			bean.setEx3(rst.getString(12));
			bean.setEx4(rst.getString(13));
			bean.setEx5(rst.getString(14));
			bean.setEx6(rst.getString(15));
			bean.setEx7(rst.getString(16));
			bean.setEx8(rst.getString(17));
			bean.setCa(rst.getString(18));
			bean.setYn_caorder(rst.getString(19));
			bean.setYn_case(rst.getString(20));
			bean.setYn_blank(rst.getString(21));
			bean.setExplain(rst.getString(22));
			bean.setHint(rst.getString(23));
			bean.setSrc_book(rst.getString(24));
			bean.setSrc_author(rst.getString(25));
			bean.setSrc_page(rst.getString(26));
			bean.setSrc_pub_comp(rst.getString(27));
			bean.setSrc_pub_year(rst.getString(28));
			bean.setSrc_misc(rst.getString(29));
			bean.setFind_kwd(rst.getString(30));
			bean.setUserid(rst.getString(31));
			bean.setId_valid_type(rst.getInt(32));
			bean.setId_q_use(rst.getInt(33));
			bean.setQ_use_detail(rst.getString(34));
			bean.setEx_rowcnt(rst.getInt(35));
			bean.setYn_single_line(rst.getString(36));
			bean.setReftitle(rst.getString(37));
			bean.setRefbody1(rst.getString(38));
			bean.setRefbody2(rst.getString(39));
			bean.setRefbody3(rst.getString(40));
			bean.setMake_cnt(rst.getInt(41));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문항 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.. [QUtil.makeBean]");
        }
    }

	public static QMsgBean[] getMsgBeans(String id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select front_msg, back_msg, box_size ");
		sql.append("From q_msg ");
		sql.append("Where id_q = ? ");
		sql.append("Order by seq ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q);
            rst = stm.executeQuery();
            QMsgBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QMsgBean[]) beans.toArray(new QMsgBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("단답형 답안 입력박스 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.getMsgBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static QMsgBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            QMsgBean bean = new QMsgBean();
			bean.setFront_msg(rst.getString(1));
            bean.setBack_msg(rst.getString(2));
            bean.setBox_size(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("단답형 답안 입력박스 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.makeBeans]");
        }
    }

	public static void updateIncorrect(String id_q, int id_valid_type) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Update q ");
		sql.append("       Set id_valid_type = ? ");
		sql.append("Where id_q = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setInt(1, id_valid_type);
			stm.setString(2, id_q);
            stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("오류문항 처리작업 중 인터넷 연결상태가 좋지 않습니다. [QUtil.updateIncorrect]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateIncorrect(String id_q, String ca, int id_valid_type) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Update q ");
		sql.append("       Set ca = ?, id_valid_type = ? ");
		sql.append("Where id_q = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());			
			stm.setString(1, ca);
			stm.setInt(2, id_valid_type);
			stm.setString(3, id_q);
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("오류문항 처리작업 중 인터넷 연결상태가 좋지 않습니다. [QUtil.updateIncorrect]");
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
            throw new QmTmException("문항 출제횟수 등록하는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.makecntAdd]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QRefBean[] getBeans(String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		//sql.append("Select b.id_ref, b.reftitle, b.refbody1, b.refbody2, b.refbody3, convert(varchar(10), b.regdate, 120) regdate ");
		sql.append("Select b.id_ref, b.reftitle, b.refbody1, b.refbody2, b.refbody3, to_char(b.regdate, 'YYYY-MM-DD') regdate ");
		sql.append("From q a, q_ref b ");
		sql.append("Where a.id_subject = ? and a.id_ref <> '0' and a.id_ref = b.id_ref ");
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
            rst = stm.executeQuery();
            QRefBean bean = null;
            while (rst.next()) {
                bean = makeRefBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QRefBean[]) beans.toArray(new QRefBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("지문형 문항정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QRefBean makeRefBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            QRefBean bean = new QRefBean();
			bean.setId_ref(rst.getString(1));
            bean.setReftitle(rst.getString(2));
			bean.setRefbody1(rst.getString(3));
			bean.setRefbody2(rst.getString(4));
			bean.setRefbody3(rst.getString(5));
            bean.setRegdate(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("지문형 문항정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QUtil.makeRefBeans]");
        }
    }
}