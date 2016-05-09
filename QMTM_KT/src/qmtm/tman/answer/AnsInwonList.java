package qmtm.tman.answer;

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

public class AnsInwonList
{
    public AnsInwonList() {
    }

	public static AnsInwonListBean[] getUserids(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select userid From exam_ans Where id_exam = ? ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeUserids(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getUserids]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static AnsInwonListBean makeUserids (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeUserids]");
        }
    }
	
	public static AnsInwonListBean[] getBeans(String id_exam, String bigos) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, a.user_ip ");
		sql.append("From exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.yn_end = ? and a.userid = b.userid ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, bigos);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnsInwonListBean[] getExcelBeans(String id_exam, String bigos) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, b.sosok1, b.sosok2, b.sosok3, b.sosok4, b.jikwi, b.jikmu, a.nr_set, ");
		sql.append("       convert(varchar(16), a.start_time, 120) start_time, convert(varchar(16), a.end_time, 120) end_time, ");
		sql.append("       a.score, a.score_bak, a.score_log, a.user_ip ");
		sql.append("From exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.yn_end = ? and a.userid = b.userid ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, bigos);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeExcelBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 엑셀정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getExcelBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnsInwonListBean[] getOrders(String id_exam, String bigos, String fields, String orders) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, a.user_ip ");
		sql.append("From exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = '"+ id_exam +"' and a.yn_end = '"+ bigos +"' and a.userid = b.userid ");
		sql.append("Order by "+ fields +" "+ orders +" ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
			stm = cnn.createStatement();
			rst = stm.executeQuery(sql.toString());
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getOrders]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            bean.setNr_set(rst.getInt(3));
			bean.setStart_time(rst.getString(4));
			bean.setEnd_time(rst.getString(5));
			bean.setScore(rst.getDouble(6));
			bean.setScore_bak(rst.getDouble(7));
			bean.setScore_log(rst.getString(8));
			bean.setUser_ip(rst.getString(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeBeans]");
        }
    }

	private static AnsInwonListBean makeExcelBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
			bean.setSosok1(rst.getString(3));
			bean.setSosok2(rst.getString(4));
			bean.setSosok3(rst.getString(5));
			bean.setSosok4(rst.getString(6));
			bean.setJikwi(rst.getString(7));
			bean.setJikmu(rst.getString(8));
            bean.setNr_set(rst.getInt(9));
			bean.setStart_time(rst.getString(10));
			bean.setEnd_time(rst.getString(11));
			bean.setScore(rst.getDouble(12));
			bean.setScore_bak(rst.getDouble(13));
			bean.setScore_log(rst.getString(14));
			bean.setUser_ip(rst.getString(15));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeExcelBeans]");
        }
    }

	public static AnsInwonListBean[] getBeans2(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.name From qt_userid a, qt_course_user b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '1' and a.userid = b.userid and ");
		sql.append("      b.id_course = c.id_course and b.id_subject = c.id_subject and b.course_year = c.course_year ");
		sql.append("      and b.course_no = c.course_no and a.userid not in (select userid from exam_ans where id_exam = ?) ");
		sql.append("Union all ");
		sql.append("Select a.userid, a.name From qt_userid a, exam_receipt b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '2' and a.userid = b.userid and b.id_exam = c.id_exam ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
			stm.setString(3, id_exam);
			stm.setString(4, id_exam);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getBeans2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnsInwonListBean[] getExcelBeans2(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.name, a.sosok1, a.sosok2, a.sosok3, a.sosok4, a.jikwi, a.jikmu ");
		sql.append("From qt_userid a, qt_course_user b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '1' and a.userid = b.userid and ");
		sql.append("      b.id_course = c.id_course and b.id_subject = c.id_subject and b.course_year = c.course_year ");
		sql.append("      and b.course_no = c.course_no and a.userid not in (select userid from exam_ans where id_exam = ?) ");
		sql.append("Union all ");
		sql.append("Select a.userid, a.name, a.sosok1, a.sosok2, a.sosok3, a.sosok4, a.jikwi, a.jikmu ");
		sql.append("From qt_userid a, exam_receipt b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '2' and a.userid = b.userid and b.id_exam = c.id_exam ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
			stm.setString(3, id_exam);
			stm.setString(4, id_exam);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeExcelBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getBeans2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnsInwonListBean[] getOrders2(String id_exam, String fields, String orders) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.name From qt_userid a, qt_course_user b, exam_m c ");
		sql.append("Where c.id_exam = '"+ id_exam +"' and c.id_auth_type = '1' and a.userid = b.userid and ");
		sql.append("      b.id_course = c.id_course and b.id_subject = c.id_subject and b.course_year = c.course_year ");
		sql.append("      and b.course_no = c.course_no and a.userid not in (select userid from exam_ans where id_exam = '"+ id_exam +"') ");
		sql.append("Union all ");
		sql.append("Select a.userid, a.name From qt_userid a, exam_receipt b, exam_m c ");
		sql.append("Where c.id_exam = '"+ id_exam +"' and c.id_auth_type = '2' and a.userid = b.userid and b.id_exam = c.id_exam ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = '"+ id_exam +"') ");
		sql.append("Order by "+ fields +" "+ orders +" ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
			rst = stm.executeQuery(sql.toString());
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getOrders2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeBeans2]");
        }
    }

	private static AnsInwonListBean makeExcelBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
			bean.setSosok1(rst.getString(3));
			bean.setSosok2(rst.getString(4));
			bean.setSosok3(rst.getString(5));
			bean.setSosok4(rst.getString(6));
			bean.setJikwi(rst.getString(7));
			bean.setJikmu(rst.getString(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeExcelBeans2]");
        }
    }

	public static AnsInwonListBean[] getBeans3(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, a.user_ip ");
		sql.append("From bak_exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getBeans3]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnsInwonListBean[] getExcelBeans3(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, b.sosok1, b.sosok2, b.sosok3, b.sosok4, b.jikwi, b.jikmu, a.nr_set, ");
		sql.append("       convert(varchar(16), a.start_time, 120) start_time, convert(varchar(16), a.end_time, 120) end_time, ");
		sql.append("       a.score, a.score_bak, a.score_log, a.user_ip ");
		sql.append("From bak_exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeExcelBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getBeans3]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnsInwonListBean[] getOrders3(String id_exam, String fields, String orders) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, a.user_ip ");
		sql.append("From bak_exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = '"+ id_exam +"' and a.userid = b.userid ");
		sql.append("Order by "+ fields +" "+ orders +" ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
			rst = stm.executeQuery(sql.toString());
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getOrders3]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeBeans3 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            bean.setNr_set(rst.getInt(3));
			bean.setStart_time(rst.getString(4));
			bean.setEnd_time(rst.getString(5));
			bean.setScore(rst.getDouble(6));
			bean.setScore_bak(rst.getDouble(7));
			bean.setScore_log(rst.getString(8));
			bean.setUser_ip(rst.getString(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeBeans3]");
        }
    }

	private static AnsInwonListBean makeExcelBeans3 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
			bean.setSosok1(rst.getString(3));
			bean.setSosok2(rst.getString(4));
			bean.setSosok3(rst.getString(5));
			bean.setSosok4(rst.getString(6));
			bean.setJikwi(rst.getString(7));
			bean.setJikmu(rst.getString(8));
            bean.setNr_set(rst.getInt(9));
			bean.setStart_time(rst.getString(10));
			bean.setEnd_time(rst.getString(11));
			bean.setScore(rst.getDouble(12));
			bean.setScore_bak(rst.getDouble(13));
			bean.setScore_log(rst.getString(14));
			bean.setUser_ip(rst.getString(15));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeExcelBeans3]");
        }
    }

	public static AnsInwonListBean[] getSearchBeans(String id_exam, String yn_end, String userid, String name) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, a.user_ip ");
		sql.append("From exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = '"+ id_exam +"' and a.yn_end = '"+ yn_end +"' and a.userid = b.userid and ");
		
		if(userid.equals("")) {
			sql.append(" b.name like '%"+ name +"%' ");
		} else if(name.equals("")) {
			sql.append(" b.userid like '%"+ userid +"%' ");
		} else {
			sql.append(" b.userid like '%"+userid+"%' and b.name like '%"+ name +"%' ");
		}

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
			stm = cnn.createStatement();
	        rst = stm.executeQuery(sql.toString());
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getSearchBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeSearchBeans (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            bean.setNr_set(rst.getInt(3));
			bean.setStart_time(rst.getString(4));
			bean.setEnd_time(rst.getString(5));
			bean.setScore(rst.getDouble(6));
			bean.setScore_bak(rst.getDouble(7));
			bean.setScore_log(rst.getString(8));
			bean.setUser_ip(rst.getString(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeSearchBeans]");
        }
    }

	public static AnsInwonListBean[] getSearchBeans2(String id_exam, String userid, String name) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.name From qt_userid a, qt_course_user b, exam_m c ");
		sql.append("Where c.id_exam = '"+ id_exam +"' and c.id_auth_type = '1' and a.userid = b.userid and ");
		sql.append("      b.id_course = c.id_course and b.id_subject = c.id_subject and b.course_year = c.course_year ");
		sql.append("      and b.course_no = c.course_no and a.userid not in (select userid from exam_ans where id_exam = '"+ id_exam +"') and ");
		if(userid.equals("")) {
			sql.append(" a.name like '%"+ name +"%' ");
		} else if(name.equals("")) {
			sql.append(" a.userid like '%"+ userid +"%' ");
		} else {
			sql.append(" a.userid like '%"+userid+"%' and a.name like '%"+ name +"%' ");
		}
			sql.append("Union all ");
			sql.append("Select a.userid, a.name From qt_userid a, exam_receipt b, exam_m c ");
			sql.append("Where c.id_exam = '"+ id_exam +"' and c.id_auth_type = '2' and a.userid = b.userid and b.id_exam = c.id_exam ");
			sql.append("      and b.userid not in (select userid from exam_ans where id_exam = '"+ id_exam +"') and ");
		if(userid.equals("")) {
			sql.append(" a.name like '%"+ name +"%' ");
		} else if(name.equals("")) {
			sql.append(" a.userid like '%"+ userid +"%' ");
		} else {
			sql.append(" a.userid like '%"+userid+"%' and a.name like '%"+ name +"%' ");
		}

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
	        rst = stm.executeQuery(sql.toString());
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeSearchBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getSearchBeans2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeSearchBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeSearchBeans2]");
        }
    }

	public static AnsInwonListBean[] getSearchBeans3(String id_exam, String userid, String name) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, a.user_ip ");
		sql.append("From bak_exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = '"+ id_exam +"' and a.userid = b.userid and ");
		
		if(userid.equals("")) {
			sql.append(" b.name like '%"+ name +"%' ");
		} else if(name.equals("")) {
			sql.append(" b.userid like '%"+ userid +"%' ");
		} else {
			sql.append(" b.userid like '%"+userid+"%' and b.name like '%"+ name +"%' ");
		}

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
	        rst = stm.executeQuery(sql.toString());
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeSearchBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getSearchBeans3]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeSearchBeans3 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            bean.setNr_set(rst.getInt(3));
			bean.setStart_time(rst.getString(4));
			bean.setEnd_time(rst.getString(5));
			bean.setScore(rst.getDouble(6));
			bean.setScore_bak(rst.getDouble(7));
			bean.setScore_log(rst.getString(8));
			bean.setUser_ip(rst.getString(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.makeSearchBeans3]");
        }
    }

	public static int getTotInwon(String id_exam, int id_auth_type) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		if(id_auth_type == 1) {
			sql.append("Select count(b.userid) as totcnt From exam_m a, qt_course_user b ");
			sql.append("Where a.id_exam = ? and a.id_course = b.id_course and a.id_subject = b.id_subject ");
			sql.append("      and a.course_year = b.course_year and a.course_no = b.course_no ");
		} else if(id_auth_type == 2) {
			sql.append("Select count(userid) as totcnt From exam_receipt Where id_exam = ? ");
		}

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getInt("totcnt"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getTotInwon]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getYesInwon(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(userid) as yescnt From exam_ans Where id_exam = ? and userid <> 'tman@@2008' ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getInt("yescnt"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getYesInwon]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getAnsY(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(userid) as yescnt From exam_ans Where id_exam = ? and yn_end = 'Y' and userid <> 'tman@@2008' ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getInt("yescnt"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getAnsY]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getAnsN(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(userid) as nocnt From exam_ans Where id_exam = ? and yn_end = 'N' and userid <> 'tman@@2008' ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getInt("nocnt"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnsInwonList.getAnsN]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}