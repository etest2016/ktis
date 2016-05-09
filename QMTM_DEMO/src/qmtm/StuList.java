package qmtm;

// Package Import
import qmtm.DBPool;
import qmtm.DBOracle;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class StuList
{
    public StuList() {
    }
	
	public static void getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		/*
		sql.append("Select user_id, std_nm, nvl(class_dept,''), concat(nvl(class_group,''), nvl(class_num,'')) ");
		sql.append("From pocheol_edun.comvsrminfo ");
		*/

		sql.append("Select user_id, std_nm, nullif(class_dept,''), concat(nullif(class_group,''), nullif(class_num,'')) ");
		sql.append("From pocheol_edun.comvsrminfo ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBOracle.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            StuListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);

				if(bean == null) { 
				} else {
					getCnt(bean);
				}
            }            
        }
        catch (SQLException ex) {
            throw new QmTmException("학생 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StuList.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static StuListBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            StuListBean bean = new StuListBean();
			bean.setUserid(rst.getString(1));
           	bean.setName(rst.getString(2));
			bean.setSosok1(rst.getString(3));
			bean.setSosok2(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("학생 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StuList.makeBeans]");
        }
    }	
	
	public static void getCnt(StuListBean rb) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		int results = 0;

		sql.append("Select count(userid) as cnt ");
		sql.append("From qt_userid ");
		sql.append("Where userid = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, rb.getUserid());

            rst = stm.executeQuery();
            if (rst.next()) { results = rst.getInt("cnt"); }

			if(results > 0) {
				updateMember(rb);
			} else {
				insertMember(rb);
			}

        } catch (SQLException ex) {
            throw new QmTmException("학생 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StuList.getCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insertMember(StuListBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO qt_userid(userid, password, name, sosok1, sosok2, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, now()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getUserid());
			stm.setString(2, bean.getUserid());			
			stm.setString(3, bean.getName());
			stm.setString(4, bean.getSosok1());
			stm.setString(5, bean.getSosok2());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("학생 정보 등록 중 인터넷 연결상태가 좋지 않습니다. [StuList.insertMember]");			
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateMember(StuListBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE qt_userid SET password = ?, name = ?, sosok1 = ?, sosok2 = ?, regdate = now() ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getUserid());
			stm.setString(2, bean.getName());
			stm.setString(3, bean.getSosok1());
			stm.setString(4, bean.getSosok2());
			stm.setString(5, bean.getUserid());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("학생 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [StuList.updateMember]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
}