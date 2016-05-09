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

public class ProfList
{
    public ProfList() {
    }
	
	public static void getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select user_id, tcher_nm, subject_code ");
		sql.append("From pocheol_edun.comvsrmtchinfo ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBOracle.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            ProfListBean bean = null;
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
            throw new QmTmException("선생님 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ProfList.getBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static ProfListBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ProfListBean bean = new ProfListBean();
			bean.setUserid(rst.getString(1));
           	bean.setName(rst.getString(2));
			bean.setSubject_code(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("선생님 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ProfList.makeBeans]" + ex.getMessage());
        }
    }	
	
	public static void getCnt(ProfListBean rb) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		int results = 0;

		sql.append("Select count(userid) as cnt ");
		sql.append("From qt_workerid ");
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
            throw new QmTmException("선생님 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ProfList.getCnt]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insertMember(ProfListBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO qt_workerid(userid, password, name, content1, yn_valid, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, 'Y', now()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getUserid());
			stm.setString(2, bean.getUserid());			
			stm.setString(3, bean.getName());
			stm.setString(4, bean.getSubject_code());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("선생님 정보 등록 중 인터넷 연결상태가 좋지 않습니다. [ProfList.insertMember]" + ex.getMessage());		
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateMember(ProfListBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE qt_workerid SET password = ?, name = ?, content1 = ?, regdate = now() ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getUserid());
			stm.setString(2, bean.getName());
			stm.setString(3, bean.getSubject_code());
			stm.setString(4, bean.getUserid());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("선생님정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ProfList.updateMember]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
}