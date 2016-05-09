package qmtm.tman.exam;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class RqtypeUtil
{
    public RqtypeUtil() {
    }
	
	public static RqtypeBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "Select id_qtype, qtype From r_qtype Order by id_qtype ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();
            RqtypeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (RqtypeBean[]) beans.toArray(new RqtypeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제유형 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static RqtypeBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            RqtypeBean bean = new RqtypeBean();
            bean.setId_qtype(rst.getString(1));
            bean.setQtype(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제유형 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }
}